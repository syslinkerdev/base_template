import 'dart:convert';

import 'package:core/core.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log_in_provider.g.dart';

@riverpod
class LogInX extends _$LogInX {
  @override
  FutureOr<void> build() {}

  /// Log in the user by verifying phone and PIN
  Future<void> logIn(
      {required String phoneNumber,
      required String userTypedPIN,
      required void Function(String uId, Role role) onSuccess}) async {
    final fullPhone = '+91$phoneNumber';
    //print('fullPhone $fullPhone');

    final user = await ref
        .read(dairyB2bRepositoryProvider)
        .fetchUserByComparisonPhone(phoneNumber: fullPhone);
    if (user == null) {
      state = AsyncValue.error(
        'This phone number is not registered.',
        StackTrace.current,
      );
      return;
    }
    GlobalCacheService.instance.setUser(user);
    final hashedInputPIN = sha256.convert(utf8.encode(userTypedPIN)).toString();
    if (user.hashedPassword == hashedInputPIN) {
      //print('roleEnum ${user.role} _______-------- user.uid ${user.uid}');
      if (user.role != null) {
        onSuccess(user.uid, user.role!);
        state = const AsyncData(null);
      } else {
        state = AsyncValue.error(
          'User role is missing. Please contact support.',
          StackTrace.current,
        );
      }
    } else {
      state = AsyncValue.error(
        'The entered PIN is incorrect. Please try again.',
        StackTrace.current,
      );
    }
  }

  /// Validate access code and navigate to forgot PIN page
  Future<void> forgotPin(
      {required BuildContext context,
      required String phoneNumber,
      required String userTypedAccessCode,
      required void Function(BuildContext context) onSuccess}) async {
    final fullPhone = '+91$phoneNumber';

    final user = await ref
        .read(dairyB2bRepositoryProvider)
        .fetchUserByComparisonPhone(phoneNumber: fullPhone);

    if (user == null) {
      state = AsyncValue.error(
        'Enter a valid registered phone number.',
        StackTrace.current,
      );
      return;
    }

    if (user.accessCode == userTypedAccessCode) {
      if (context.mounted) {
        onSuccess(context);
      }
      state = const AsyncData(null);
    } else {
      state = AsyncValue.error(
        'The 6-digit code you entered is incorrect. Please check the message sent by the admin.',
        StackTrace.current,
      );
    }
  }
}
