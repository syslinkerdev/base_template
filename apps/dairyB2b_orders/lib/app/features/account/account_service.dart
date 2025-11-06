import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_service.g.dart';

@riverpod
AccountService accountService(Ref ref) {
  return AccountService(ref: ref);
}

class AccountService {
  AccountService({required this.ref});
  final Ref ref;

  Future<void> updateAccount({
    required String firstName,
    required String lastName,
    required String avatar,
    required String uid,
  }) async {
    final data = {
      DbStandardFields.firstName: firstName,
      DbStandardFields.lastName: lastName,
      DbStandardFields.avatar: avatar,
    };

    await _updateDocument(uid: uid, data: data);
  }

  Future<void> updateShop({
    required String shopName,
    required Address shopAddress,
    required String uid,
  }) async {
    final data = {
      DbStandardFields.shopName: shopName,
      DbStandardFields.shopAddress: shopAddress.toJson(),
    };

    await _updateDocument(uid: uid, data: data);
  }

  Future<void> _updateDocument({
    required String uid,
    required Map<String, dynamic> data,
  }) async =>
      await ref.read(firestoreServiceProvider).updateDocument(
            collectionPath: DbPathManager.users(),
            documentId: uid,
            data: data,
          );
}
