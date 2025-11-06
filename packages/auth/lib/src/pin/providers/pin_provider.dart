import 'package:auth/src/pin/pin_service.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pin_provider.g.dart';

@riverpod
class Pin extends _$Pin {
  @override
  FutureOr<void> build() {}

  Future<void> createPIN({
    required String finalPIN,
    required String uId,
    required void Function() onSuccess,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => ref
        .read(pinServiceProvider)
        .createPIN(finalPIN: finalPIN, uId: uId, onSuccess: onSuccess));
  }

  Future<void> updatePIN(
      {required String finalPIN, required String uId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await ref
        .read(pinServiceProvider)
        .createPIN(finalPIN: finalPIN, uId: uId));
  }

  Future<void> checkPIN(
      {required String currentPIN,
      required String currentPinHash,
      required BuildContext context}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(pinServiceProvider);
      final result = await service.checkPIN(
          currentPIN: currentPIN, currentPinHash: currentPinHash);
      if (result == true) {
        if (context.mounted) {
          context.close(true);
        }
      } else {
        //print('        state = AsyncValue.error( -----------------');
        state = AsyncValue.error(
          convertToAppException(
              title: 'Invalid PIN', exception: 'Invalid PIN, Try again!'),
          StackTrace.current,
        );
      }
    });
  }

  Future<void> forgotPIN({
    required String finalPIN,
    required String uId,
    required void Function() onSuccess,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => ref
        .read(pinServiceProvider)
        .createPIN(finalPIN: finalPIN, uId: uId, onSuccess: onSuccess));
  }
}
