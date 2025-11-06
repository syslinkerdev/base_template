import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueError on AsyncValue {
  Future<void> showAlertDialogOnError(
    BuildContext context, {
    bool? barrierDismissible,
    FutureOr<void> Function(BuildContext dialogCtx)? defaultOnPressed,
  }) async {
    // //print('fuck---------- ${hasError.toString()}');
    if (!isLoading && hasError) {
      // //print('AsyncValueError.showAlertDialogOnError called');
      // //print('error : ${error.toString()}');
      if (error is AppException) {
        final AppException exception = error as AppException;
        DialogsX.showErrorDialog(
          context,
          title: exception.title,
          content: exception.message,
          barrierDismissible: barrierDismissible ?? true,
          defaultOnPressed: (dialogCtx) {
            // //print('dddddddddddddddddd------');
            if (defaultOnPressed != null) {
              // //print('if (defaultOnPressed != null) {');
              defaultOnPressed(dialogCtx);
            } else {
              dialogCtx.close();
            }
          },
        );
      } else {
        DialogsX.showErrorDialog(
          context,
          title: 'Internal Error Occurred',
          content: error.toString(),
          barrierDismissible: barrierDismissible ?? true,
          defaultOnPressed:
              defaultOnPressed ?? (dialogCtx) => dialogCtx.close(),
        );
      }
    }
  }
}
