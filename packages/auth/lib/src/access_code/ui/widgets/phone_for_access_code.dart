import 'dart:async';

import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PhoneForAccessCode extends HookConsumerWidget {
  const PhoneForAccessCode(
      {super.key,
      this.phoneNoController,
      this.readOnly = false,
      required this.isDeleteAccount});
  final TextEditingController? phoneNoController;
  final bool readOnly;
  final bool isDeleteAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNoControllerX = phoneNoController ?? TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              isDeleteAccount
                  ? 'Think twice — once deleted, your account can\'t be recovered.'
                  : 'Enter your registered phone number to continue.',
              style: TextStyles.h8Gray(context)
                  ?.copyWith(fontSize: context.sizeOfHeight * 0.022)),
          if (!isDeleteAccount) ...[
            CaptionText(title: 'Phone number'),
            PhoneNumberField(
                hintText: 'Phone number',
                phoneNoController: phoneNoControllerX,
                readOnly: readOnly),
          ],
        ],
      ),
    );
  }

  static void dialog(BuildContext context,
          {required FutureOr<void> Function(BuildContext dialogCtx)
              defaultOnPressed,
          bool defaultButtonLoading = false,
          TextEditingController? phoneNoController,
          bool? readOnly,
          required String title,
          bool isDeleteAccount = false}) =>
      DialogsX.showSemiCustomDialog(
        context,
        barrierDismissible: false,
        title: title,
        noImage: true,
        content: PhoneForAccessCode(
            phoneNoController: phoneNoController,
            readOnly: readOnly ?? false,
            isDeleteAccount: isDeleteAccount),
        cancelButtonText: 'Cancel',
        defaultButtonText: 'Continue',
        cancelOnPressed: (dialogCtx) => dialogCtx.close(false),
        dialogTheme: appColors.sc.mutedRed,
        defaultButtonLoading: defaultButtonLoading,
        defaultOnPressed: (dialogCtx) async =>
            await defaultOnPressed(dialogCtx),
      );
}
