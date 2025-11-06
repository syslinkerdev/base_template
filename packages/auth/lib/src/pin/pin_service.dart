import 'dart:convert';
import 'package:core/core.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pin_service.g.dart';

@riverpod
PINService pinService(Ref ref) {
  return PINService(ref: ref);
}

class PINService {
  PINService({required this.ref});
  final Ref ref;

  Future<void> createPIN({
    required String finalPIN,
    required String uId,
    void Function()? onSuccess,
  }) async {
    // Hash the given PIN
    final hashedPassword = _hashPIN(finalPIN);
    //print('Given PIN: $finalPIN, Hashed Password: $hashedPassword');

    // Update User with the hashed password
    await ref.read(firestoreServiceProvider).updateDocument(
      collectionPath: DbPathManager.users(),
      documentId: uId,
      data: {DbStandardFields.hashedPassword: hashedPassword},
    );

    if (onSuccess != null) {
      onSuccess();
    }
  }

  // checkPIN
  Future<bool> checkPIN({
    required String currentPIN,
    required String currentPinHash,
  }) async {
    final hashedPassword = _hashPIN(currentPIN);
    //print(
        // 'given pin: $currentPIN, hashed password: $hashedPassword, currentPINHash: $currentPinHash');
    return hashedPassword == currentPinHash;
  }

  // Private method to hash the PIN using SHA-256
  String _hashPIN(String pin) {
    final sha256PIN = sha256.convert(utf8.encode(pin));
    return sha256PIN.toString();
  }
}
