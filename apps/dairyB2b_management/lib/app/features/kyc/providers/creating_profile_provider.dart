import 'dart:math';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'creating_profile_provider.g.dart';

final superuserNameHolder = StateProvider<String>((ref) => "no user");

@riverpod
class CreatingProfileX extends _$CreatingProfileX {
  @override
  FutureOr<void> build() => createUser();

  // createUser
  Future<void> createUser() async {
    Random rng = Random();
    int accessCode = rng.nextInt(900000) + 100000;
    //print(accessCode);
    final currentUser =
        await ref.read(phoneNoVerifyServiceProvider).currentUser;
    //print('Current User: ${currentUser?.uid}');
    if (currentUser == null) {
      throw Exception("User is not signed in.");
    }
    final String userPhoneNo = currentUser.phoneNumber ?? "NotUser";
    //print(userPhoneNo);
    final developerData = await ref
        .read(dairyB2bRepositoryProvider)
        .fetchAppManagement(documentId: DbPathManager.appManagement());
    final DateTime createdTime = DateTime.now();
    final Map<String, dynamic> data = UserX.empty()
        .copyWith(
          accessCode: accessCode.toString(),
          superuserUid: developerData?.uid ?? '',
          role: Role.admin,
          createdAt: createdTime,
          phoneNumber: userPhoneNo,
          uid: currentUser.uid,
        )
        .toDocument();
    //print("data : ${data.toString()}");
    ref.read(superuserNameHolder.notifier).update(
        (state) => '${developerData?.firstName} ${developerData?.lastName}');

    await ref
        .read(firestoreServiceProvider)
        .setDocument(
          collectionPath: DbPathManager.users(),
          documentId: currentUser.uid,
          data: data,
        )
        .then(
          (_) => stepper.nextPage(),
        );
  }
}
