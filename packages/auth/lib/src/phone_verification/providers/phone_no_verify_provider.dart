import 'package:core/core.dart';
import 'package:models/models.dart';
import '../phone_no_verify_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'phone_no_verify_provider.freezed.dart';
part 'phone_no_verify_provider.g.dart';

@riverpod
class PhoneNoVerify extends _$PhoneNoVerify {
  @override
  FutureOr<PhoneNoVerifyState> build() => PhoneNoVerifyState.initial();

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) codeSent,
  }) async {
    state = const AsyncLoading();
    _updateState(
        longLoading: true, otpTimedOut: false, phoneNumber: phoneNumber);
    state = await AsyncValue.guard(() async {
      await ref.read(phoneNoVerifyServiceProvider).verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationFailed: (exception) {
              _updateState(longLoading: false);
              throw exception;
            },
            codeSent: (vId, token) {
              _updateState(
                longLoading: false,
                verificationId: vId,
                otpStartTime: DateTime.now(),
              );
              codeSent(vId, token);
            },
            verificationCompleted: (credential) {
              _updateState(
                longLoading: false,
                verificationId: credential.verificationId,
              );
            },
            codeAutoRetrievalTimeout: (vId) {
              // print(
              // 'codeAutoRetrievalTimeout --------------------------------- $vId');
              _updateState(
                otpTimedOut: true,
                verificationId: vId,
              );
            },
          );

      // ✅ return final state from current value
      return state.value!;
    });
  }

  Future<void> verifyOtpCode({
    required String otpCode,
    required void Function(UserX user) onUserPresent,
    required void Function() onUserNotPresent,
    required void Function(UserX deletedUser)
        onDeletedUserFound, // optional hook
  }) async {
    state = const AsyncLoading();
    _updateState(longLoading: true);
    // print('🔹 verifyOtpCode started for OTP: $otpCode');

    state = await AsyncValue.guard(() async {
      try {
        final verificationId = state.value?.verificationId;
        // print('🔹 Current verificationId: $verificationId');
        if (verificationId == null) {
          throw convertToAppException(
            title: 'Invalid verification ID',
            exception: 'Invalid verification ID',
          );
        }

        // print('🔹 Verifying OTP with service...');
        await ref
            .read(phoneNoVerifyServiceProvider)
            .verifyOtpCode(verificationId: verificationId, otpCode: otpCode);
        // print('✅ OTP verified successfully');

        final fullPhone = "+91${state.value?.phoneNumber}";
        // print('🔹 Full phone number: $fullPhone');

        final dairyB2bRepo = ref.read(dairyB2bRepositoryProvider);
        final allPhoneNos = await dairyB2bRepo.fetchPhoneNos();
        final deletedPhoneNos = await dairyB2bRepo.fetchUniqueDeletedPhoneNos();
        // print('🔹 All phone numbers: $allPhoneNos');
        // print('🔹 Deleted phone numbers: $deletedPhoneNos');

        if (allPhoneNos.contains(fullPhone)) {
          // print('🔹 Phone exists in active users');
          final user = await dairyB2bRepo.fetchUserByComparisonPhone(
              phoneNumber: fullPhone);
          if (user != null && user.hashedPassword.containsValidValue) {
            // print('✅ User found, calling onUserPresent');
            onUserPresent.call(user);
          } else {
            // print(
            // '⚠️ User found but password invalid or null, calling onUserNotPresent');
            onUserNotPresent();
          }
        } else if (deletedPhoneNos.contains(fullPhone)) {
          // print('🔹 Phone exists in deleted users');
          final deletedUser =
              await dairyB2bRepo.fetchLatestDeletedUserByPhone(fullPhone);
          // print('🔹 Deleted user: ${deletedUser?.firstName}');
          final currentUid =
              await ref.read(phoneNoVerifyServiceProvider).currentUser?.uid;
          // print('🔹 Current UID: $currentUid');

          if (deletedUser != null && currentUid == deletedUser.uid) {
            // print(
            // '✅ Deleted user matches current UID, calling onDeletedUserFound');
            onDeletedUserFound.call(deletedUser);
          } else if (deletedUser != null && currentUid != deletedUser.uid) {
            // print('⚠️ Deleted user UID mismatch, archiving old user');
            final archivedUser = deletedUser.copyWith(replacedBy: currentUid);
            await ref.read(firestoreServiceProvider).setDocument(
                  collectionPath: DbPathManager.deletedUsers(),
                  documentId: deletedUser.uid,
                  data: archivedUser.toDocument(),
                );
            onUserNotPresent();
          } else {
            // print('⚠️ Deleted user not found, calling onUserNotPresent');
            onUserNotPresent();
          }
        } else {
          // print('⚠️ Phone not found anywhere, calling onUserNotPresent');
          onUserNotPresent();
        }

        return state.value!;
      } catch (e, _) {
        // print('❌ Error in verifyOtpCode: $e');
        // print('Stack trace: $st');
        _updateState(longLoading: false);
        rethrow;
      }
    });
  }

  int get otpSecondsLeft {
    final start = state.value?.otpStartTime;
    if (start == null) return 0;
    final elapsed = DateTime.now().difference(start).inSeconds;
    return (60 - elapsed).clamp(0, 60);
  }

  void _updateState({
    bool? longLoading,
    bool? otpTimedOut,
    String? verificationId,
    String? phoneNumber,
    DateTime? otpStartTime,
  }) {
    final current = state.valueOrNull ?? PhoneNoVerifyState.initial();
    state = AsyncValue.data(
      current.copyWith(
        longLoading: longLoading ?? current.longLoading,
        otpTimedOut: otpTimedOut ?? current.otpTimedOut,
        verificationId: verificationId ?? current.verificationId,
        phoneNumber: phoneNumber ?? current.phoneNumber,
        otpStartTime: otpStartTime ?? current.otpStartTime,
      ),
    );
  }

  void reset() {
    state = AsyncData(PhoneNoVerifyState.initial());
  }
}

@freezed
abstract class PhoneNoVerifyState with _$PhoneNoVerifyState {
  const factory PhoneNoVerifyState({
    @Default(false) bool longLoading,
    @Default(false) bool otpTimedOut,
    String? verificationId,
    String? phoneNumber,
    DateTime? otpStartTime,
  }) = _PhoneNoVerifyState;

  factory PhoneNoVerifyState.initial() => const PhoneNoVerifyState();
}
