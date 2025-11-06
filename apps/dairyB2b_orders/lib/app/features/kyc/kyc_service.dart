import 'dart:math';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyc_service.g.dart';

final superuserNameHolder = StateProvider<String>((ref) => "no user");

@riverpod
KycService kycService(Ref ref) {
  return KycService(ref: ref);
}

class KycService {
  KycService({required this.ref});
  final Ref ref;
// createUser
  Future<String> createUser({required DataBlock3 admin}) async {
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
    final DateTime createdAt = DateTime.now();
    final Map<String, dynamic> data = UserX.empty()
        .copyWith(
          accessCode: accessCode.toString(),
          superuserUid: admin.v3,
          role: Role.client,
          createdAt: createdAt,
          phoneNumber: userPhoneNo,
          uid: currentUser.uid,
        )
        .toDocument();
    ref.read(superuserNameHolder.notifier).update((state) => admin.v2);
    //print("data : ${data.toString()}");
    await ref.read(firestoreServiceProvider).setDocument(
          collectionPath: DbPathManager.users(),
          documentId: currentUser.uid,
          data: data,
        );
    return userPhoneNo;
  }

  // updateUser
  Future<void> updateUser({required UserX client}) async {
    Random rng = Random();
    int accessCode = rng.nextInt(900000) + 100000;
    final Map<String, dynamic> data = client
        .copyWith(isGiven: false, accessCode: accessCode.toString())
        .toDocument();
    //print(data);
    await ref.read(firestoreServiceProvider).updateDocument(
        collectionPath: DbPathManager.users(),
        documentId: client.uid,
        data: data);
  }
}
