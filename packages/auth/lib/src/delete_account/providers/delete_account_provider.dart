import 'dart:math';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_account_provider.g.dart';

final softDeleteProcessMessageHolder =
    StateProvider<String>((ref) => 'Loading . . .');

@riverpod
class DeleteAccountX extends _$DeleteAccountX {
  @override
  FutureOr<void> build() {}

  Future<void> softDeleteUser({
    required UserX user,
    required String phoneNumber,
    required void Function() afterSoftDeleteProcess,
  }) async {
    state = const AsyncLoading();
    final messageHolder = ref.read(softDeleteProcessMessageHolder.notifier);
    state = await AsyncValue.guard(() async {
      final firestore = ref.read(firestoreServiceProvider);
      final authService = ref.read(phoneNoVerifyServiceProvider);

      final currentUid = authService.currentUser?.uid;
      //print('currentUid --- $currentUid --- user.uid --- ${user.uid}');
      messageHolder.state = '🔒 Verifying user identity...';
      if (currentUid == null || currentUid != user.uid) {
        throw convertToAppException(
          title: 'Soft delete failed',
          exception: 'Unauthorized attempt or user mismatch.',
        );
      }

      // ✅ Step 1: Move to deleted_users
      messageHolder.state = '📦 Backing up your account for recovery...';
      final deletedUser = user.copyWith(
        deletedAt: DateTime.now(),
        deletedBy: user.role,
      );
      await firestore.setDocument(
        collectionPath: DbPathManager.deletedUsers(),
        documentId: user.uid,
        data: deletedUser.toDocument(),
      );

      // ✅ Step 2: Remove from /users
      messageHolder.state = '🧹 Cleaning up active account...';
      await firestore.deleteDocument(
        collectionPath: DbPathManager.users(),
        documentId: user.uid,
      );

      // ✅ Step 3: Sign out
      messageHolder.state = '🚪 Signing out...';
      await authService.signOut();

      // ✅ Final status
      messageHolder.state = '✅ Account deleted. You can now re-register.';
      afterSoftDeleteProcess();
    });
  }

  Future<void> recoverAccount({
    required UserX deletedUser,
  }) async {
    final phoneService = ref.read(phoneNoVerifyServiceProvider);
    final firestore = ref.read(firestoreServiceProvider);

    final newUid = phoneService.currentUser?.uid;

    if (newUid == null) {
      throw convertToAppException(
        title: 'Recovery Failed',
        exception: 'No signed-in user found.',
      );
    }
    Random rng = Random();
    int accessCode = rng.nextInt(900000) + 100000;

    final recoveredUser = deletedUser.copyWith(
      uid: newUid,
      status: UserStatus.active,
      accessCode: accessCode.toString(),
      isGiven: false,
      deletedAt: null,
      deletedBy: null,
      replacedBy: null,
    );
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await firestore.setDocument(
        collectionPath: DbPathManager.users(),
        documentId: newUid,
        data: recoveredUser.toDocument(),
      );

      await firestore.deleteDocument(
        collectionPath: DbPathManager.deletedUsers(),
        documentId: deletedUser.uid,
      );
    });
  }

  Future<void> createNewAccount({
    required UserX deletedUser,
  }) async {
    await AsyncValue.guard(() async {
      final phoneService = ref.read(phoneNoVerifyServiceProvider);
      final newUid = phoneService.currentUser?.uid;
      final oldUid = deletedUser.uid;
      if (newUid == null) {
        throw convertToAppException(
          title: 'Account creation failed',
          exception: 'No signed-in user found.',
        );
      }
      // ✅ Step 1: If same user trying to re-register, delete the Firebase Auth user
      if (newUid == oldUid) {
        final isDeleted = await phoneService.deleteUser();
        if (!isDeleted) {
          throw convertToAppException(
            title: 'Account deletion failed',
            exception: 'Please re-authenticate to delete your current account.',
          );
        }
      }
    });
  }
}
