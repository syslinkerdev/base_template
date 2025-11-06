import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/kyc/kyc_service.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyc_provider.g.dart';

final userXHolder = StateProvider<UserX>((ref) => UserX.empty());

@riverpod
class AdminEnroll extends _$AdminEnroll {
  @override
  FutureOr<void> build() {}

  Future<void> atAccessCode({required UserX userData}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      ref.read(userXHolder.notifier).update((_) => userData);
      stepper.nextPage();
    });
  }

  Future<void> reSetAccessCode({required String uId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      Random rng = Random();
      int accessCode = rng.nextInt(900000) + 100000;
      //print(accessCode);
      // Update User with the Access Code and isGiven to false
      await ref.read(firestoreServiceProvider).updateDocument(
        collectionPath: DbPathManager.users(),
        documentId: uId,
        data: {
          DbStandardFields.accessCode: accessCode.toString(),
          DbStandardFields.isGiven: false
        },
      );
    });
  }

  Future<void> updateUser({required UserX admin}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final isOk = await _validate(admin);
      if (isOk == true) {
        await ref.read(adminEnrollServiceProvider).updateUser(admin: admin);
        ref.read(appStateXProvider.notifier).markKycCompleted(uId: admin.uid);
      }
    });
  }
 
  Future<bool> _validate(UserX admin) async {
    if (admin.avatar.doesNotHaveValue) {
      return _setError('Selfie missing', 'Provide selfie!');
    }
    if (!(await isValidProfilePhoto(admin.avatar))) {
      return _setError('Invalid photo', 'Invalid photo, Provide selfie!');
    }
    if (admin.firstName.doesNotHaveValue) {
      return _setError('Field missing', 'Enter first name!');
    }
    if (admin.lastName.doesNotHaveValue) {
      return _setError('Field missing', 'Enter last name!');
    }
    //print('Successfully completed validation!');
    return true;
  }

  bool _setError(String title, String exception) {
    state = AsyncValue.error(
      convertToAppException(title: title, exception: exception),
      StackTrace.current,
    );
    return false;
  }
}
