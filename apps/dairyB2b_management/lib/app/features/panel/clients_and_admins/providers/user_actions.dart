import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_actions.g.dart';

@riverpod
class UserActions extends _$UserActions {
  @override
  FutureOr<void> build() {}

  Future<void> updateUserStatus({
    required String userUid,
    required UserStatus userStatus,
  }) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.users(),
          documentId: userUid,
          data: {
            DbStandardFields.status: UserStatusConverter.toJson(userStatus)
          },
        );
      },
    );
  }

  Future<void> updateUserServiceCharges({
    required String userUid,
    required double serviceCharges,
  }) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.users(),
          documentId: userUid,
          data: {DbStandardFields.serviceCharges: serviceCharges},
        );
      },
    );
  }

  Future<void> updateIsGivenForAccessCode({required String userUid}) async {
    state = await AsyncValue.guard(
      () async {
        await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.users(),
          documentId: userUid,
          data: {DbStandardFields.isGiven: true},
        );
      },
    );
  }
}
