import 'dart:io';
import 'dart:math';

import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyc_service.g.dart';

@riverpod
AdminEnrollService adminEnrollService(Ref ref) {
  return AdminEnrollService(ref: ref);
}

class AdminEnrollService {
  AdminEnrollService({required this.ref});
  final Ref ref;

  // adminFormSubmit
  Future<void> updateUser({required UserX admin}) async {
    Random rng = Random();
    int accessCode = rng.nextInt(900000) + 100000;
    final String finalAdminAvatar = await ref
        .read(firestoreServiceProvider)
        .uploadImage(
            imageFile: File(admin.avatar),
            destinationStoragePath:
                '${StoragePathManger.avatar(name: admin.uid)}');

    final Map<String, dynamic> data = await admin
        .copyWith(
            isGiven: false,
            accessCode: accessCode.toString(),
            avatar: finalAdminAvatar)
        .toDocument();
    //print(data);

    await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.users(),
          documentId: admin.uid,
          data: data,
        );
  }
}
