import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'phone_no_verify_service.g.dart';

const kOtpTimeoutSeconds = 60;

class PhoneNoVerifyService {
  PhoneNoVerifyService({
    required this.auth,
    required this.ref,
  });

  final FirebaseAuth auth;
  final Ref ref;

  User? get currentUser => auth.currentUser;

  Stream<User?> authStateChanges() => auth.authStateChanges();

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(AppException exception) verificationFailed,
    required void Function(String verificationId, int? resendToken) codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    required void Function(PhoneAuthCredential phoneAuthCredential)
        verificationCompleted,
  }) async {
    final formattedPhoneNumber = '+91$phoneNumber';
    await auth.verifyPhoneNumber(
      phoneNumber: formattedPhoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: (exception) {
        //print('Phone verification failed: $exception');
        verificationFailed(
          convertToAppException(
              title: 'Phone number verification failed', exception: exception),
        );
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: const Duration(seconds: kOtpTimeoutSeconds),
    );
  }

  Future<void> verifyOtpCode(
      {required String verificationId, required String otpCode}) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );
    //print('verifying otp code: $otpCode at PhoneNoVerifyService');

    final user = currentUser;
    if (user != null) {
      if (user.isAnonymous) {
        await linkWithCredential('Sms verification failed', credential);
      } else {
        await signInWithCredential('Sms verification failed', credential);
      }
    } else {
      await signInWithCredential('Sms verification failed', credential);
    }
  }

  Future<void> signInWithCredential(
      String errorTitle, AuthCredential credential) async {
    //print('signing in with credential at PhoneNoVerifyService');
    await handleAsyncError(
        title: errorTitle,
        operation: () => auth.signInWithCredential(credential));
  }

  Future<void> linkWithCredential(
      String errorTitle, AuthCredential credential) async {
    //print('linking with credential at PhoneNoVerifyService');
    await handleAsyncError(
        title: errorTitle,
        operation: () => auth.currentUser!.linkWithCredential(credential));
  }

  Future<bool> signOut() async {
    try {
      await handleAsyncError(
        title: 'Sign out failed',
        operation: () => auth.signOut(),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteUser({
    String errorTitle = 'Account deletion failed',
  }) async {
    final user = auth.currentUser;

    if (user == null) {
      return false; // No user to delete
    }

    try {
      await handleAsyncError(
        title: errorTitle,
        operation: () => user.delete(),
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}

@riverpod
PhoneNoVerifyService phoneNoVerifyService(Ref ref) {
  return PhoneNoVerifyService(auth: FirebaseAuth.instance, ref: ref);
}
