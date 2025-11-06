import 'dart:math';
import 'package:core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'access_code_provider.g.dart';

@riverpod
class AccessCode extends _$AccessCode {
  @override
  FutureOr<void> build() {}

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
}
