import 'dart:async';

import 'package:core/core.dart';
import 'package:core/widgets/dialogs/dialog_widget.dart';
import 'package:flutter/material.dart';

class DialogsX {
  static Future<T?> _showGeneralDialog<T>(
    BuildContext context, {
    required String barrierLabel,
    required Widget Function(BuildContext dialogContext) dialogContentBuilder,
    bool barrierDismissible = true,
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool useRootNavigator = true,
  }) async {
    return await showGeneralDialog<T>(
      context: context,
      barrierLabel: barrierLabel,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      transitionDuration: transitionDuration,
      pageBuilder: (ctx, animation, secondaryAnimation) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.all(24.0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          content: dialogContentBuilder(ctx), // Pass dialog context here
        );
      },
    );
  }

  static Future<void> showErrorDialog(
    BuildContext context, {
    String? title,
    required String content,
    FutureOr<void> Function(BuildContext dialogCtx)? defaultOnPressed,
    bool barrierDismissible = true,
  }) async {
    return _showGeneralDialog<void>(
      context,
      barrierLabel: 'ErrorDialog',
      dialogContentBuilder: (dialogCtx) => DialogWidget(
        title: title,
        content: content,
        defaultButtonText: 'OKAY',
        defaultOnPressed: () {
          if (defaultOnPressed != null) {
            defaultOnPressed(dialogCtx);
          } else {
            dialogCtx.close();
          }
        },
        dialogType: DialogType.error,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<void> showSuccessDialog(
    BuildContext context, {
    String? title,
    required String content,
    FutureOr<void> Function(BuildContext dialogCtx)? defaultOnPressed,
    bool barrierDismissible = true,
  }) async {
    return _showGeneralDialog<void>(
      context,
      barrierLabel: 'SuccessDialog',
      dialogContentBuilder: (dialogCtx) => DialogWidget(
        title: title,
        content: content,
        defaultButtonText: 'OKAY',
        defaultOnPressed: () {
          if (defaultOnPressed != null) {
            defaultOnPressed(dialogCtx);
          } else {
            dialogCtx.close();
          }
        },
        dialogType: DialogType.success,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<T?> askForConfirmation<T>(
    BuildContext context, {
    String? title,
    required String content,
    String cancelBtnText = 'Cancel',
    String confirmBtnText = 'Okay',
    bool barrierDismissible = true,
    Color? dialogTheme,
    FutureOr<void> Function(BuildContext dialogCtx)? onConfirm,
    FutureOr<void> Function(BuildContext dialogCtx)? onCancel,
  }) async {
    return _showGeneralDialog<T>(
      context,
      barrierLabel: 'ConfirmationDialog',
      dialogContentBuilder: (dialogCtx) => DialogWidget(
        dialogType: DialogType.normal,
        dialogTheme: dialogTheme,
        title: title,
        content: content,
        cancelButtonText: cancelBtnText,
        defaultButtonText: confirmBtnText,
        cancelOnPressed: () {
          if (onCancel != null) {
            onCancel(dialogCtx);
          } else {
            dialogCtx.close(false);
          }
        },
        defaultOnPressed: () {
          if (onConfirm != null) {
            onConfirm(dialogCtx);
          } else {
            dialogCtx.close(true);
          }
        },
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  // Warning dialog
  static Future<void> showWarningDialog(
    BuildContext context, {
    String? title,
    required String content,
    FutureOr<void> Function(BuildContext dialogCtx)? defaultOnPressed,
    bool barrierDismissible = true,
  }) async {
    return _showGeneralDialog<void>(
      context,
      barrierLabel: 'WarningDialog',
      dialogContentBuilder: (dialogCtx) => DialogWidget(
        title: title,
        content: content,
        defaultButtonText: 'OKAY',
        defaultOnPressed: () {
          if (defaultOnPressed != null) {
            defaultOnPressed(dialogCtx);
          } else {
            dialogCtx.close(true);
          }
        },
        dialogType: DialogType.warning,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  // Normal dialog
  static Future<void> showNormalDialog(
    BuildContext context, {
    String? title,
    required String content,
    FutureOr<void> Function(BuildContext dialogCtx)? defaultOnPressed,
    bool barrierDismissible = true,
  }) async {
    return _showGeneralDialog<void>(
      context,
      barrierLabel: 'NormalDialog',
      dialogContentBuilder: (dialogCtx) => DialogWidget(
        title: title,
        content: content,
        defaultButtonText: 'OKAY',
        defaultOnPressed: () {
          if (defaultOnPressed != null) {
            defaultOnPressed(dialogCtx);
          } else {
            dialogCtx.close();
          }
        },
        dialogType: DialogType.normal,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  // Custom dialog
  static Future<void> showSemiCustomDialog(
    BuildContext context, {
    String? title,
    required Widget content,
    String? defaultButtonText,
    String? cancelButtonText,
    FutureOr<void> Function(BuildContext dialogCtx)? defaultOnPressed,
    FutureOr<void> Function(BuildContext dialogCtx)? cancelOnPressed,
    String? imagePath,
    Color? backgroundColor,
    bool defaultButtonLoading = false,
    bool noImage = false,
    Color? dialogTheme,
    bool barrierDismissible = true,
  }) async {
    return _showGeneralDialog<void>(
      context,
      barrierLabel: 'CustomDialog',
      dialogContentBuilder: (dialogCtx) => DialogWidget(
        title: title,
        widgetContent: content,
        defaultButtonText: defaultButtonText ?? 'Okay',
        cancelButtonText: cancelButtonText ?? 'Cancel',
        defaultButtonLoading: defaultButtonLoading,
        cancelOnPressed: () {
          if (cancelOnPressed != null) {
            cancelOnPressed(dialogCtx);
          } else {
            dialogCtx.close(false);
          }
        },
        defaultOnPressed: () {
          if (defaultOnPressed != null) {
            defaultOnPressed(dialogCtx);
          } else {
            dialogCtx.close(true);
          }
        },
        dialogType: DialogType.custom,
        imagePath: imagePath,
        noImage: noImage,
        backgroundColor: backgroundColor,
        dialogTheme: dialogTheme,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  // Custom dialog
  static Future<T?> showCustomDialog<T>(
    BuildContext context, {
    bool barrierDismissible = true,
    required Widget content,
  }) async {
    return _showGeneralDialog<T>(
      context,
      barrierLabel: 'CustomDialog',
      dialogContentBuilder: (dialogCtx) => DialogWidget(
        dialogType: DialogType.custom,
        defaultOnPressed: () {},
        customDialog: true,
        widgetContent: content,
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}

enum DialogType {
  success,
  normal,
  warning,
  error,
  custom,
}

extension DialogTypeApi on DialogType {
  Color toColor() => switch (this) {
        DialogType.success => ColorX.instance.sc.success,
        DialogType.normal => ColorX.instance.sc.normal,
        DialogType.warning => ColorX.instance.sc.warning,
        DialogType.error => ColorX.instance.sc.error,
        DialogType.custom => ColorX.instance.sc.custom,
      };
}
