import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

mixin KycValidator {
  Future<void> toConfirmAdmin(
      {required DataBlock3 admin,
      required BuildContext context,
      required Future<void> Function() afterConfirmAdmin}) async {
    if (admin == DataBlock3.empty()) {
      DialogsX.showErrorDialog(context,
          title: 'Waring',
          content: 'You must choose one admin from the list above!');
    } else {
      await afterConfirmAdmin();
    }
  }

  Future<void> toConfirmAvatar(
      {required Avatar avatar,
      required BuildContext context,
      required Future<void> Function() afterConfirmAvatar}) async {
    if (avatar == Avatar.empty()) {
      DialogsX.showErrorDialog(context,
          title: 'Waring',
          content: 'You must choose one avatar from the list!');
    } else {
      await afterConfirmAvatar();
    }
  }
}
