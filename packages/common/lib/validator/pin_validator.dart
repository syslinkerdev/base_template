import 'package:core/core.dart';
import 'package:flutter/material.dart';

mixin PINValidator {
  bool _isPINValid(String pin) => pin.length == 4 && int.tryParse(pin) != null;

  Future<void> createPINValidator({
    required BuildContext context,
    required String createPIN,
    required String confirmPIN,
    required Future<void> Function() toCreatePIN,
  }) async {
    await _validatePIN(
      context: context,
      createPIN: createPIN,
      confirmPIN: confirmPIN,
      onValid: toCreatePIN,
    );
  }

  Future<void> changePINValidator({
    required BuildContext context,
    required String currentPIN,
    required String newPIN,
    required Future<bool> Function() checkCurrentPIN,
    required Future<void> Function() updateNewPIN,
  }) async {
    if (_isPINValid(currentPIN) && _isPINValid(newPIN)) {
      if (currentPIN == newPIN) {
        _showPINErrorDialog(
          context,
          'Invalid PIN',
          'The new PIN cannot be the same as the current PIN. Please enter a different PIN.',
        );
      } else if (await checkCurrentPIN()) {
        await updateNewPIN();
      } else {
        _showPINErrorDialog(
          context,
          'Invalid PIN',
          'The current PIN you entered is incorrect. Please try again.',
        );
      }
    } else {
      String message = _getPINErrorMessage(currentPIN, newPIN);
      _showPINErrorDialog(context, 'Incomplete PIN', message);
    }
  }

  Future<void> forgotPINValidator({
    required BuildContext context,
    required String newPIN,
    required String confirmPIN,
    required Future<void> Function() updateNewPIN,
  }) async {
    if (_isPINValid(newPIN) && _isPINValid(confirmPIN)) {
      if (newPIN != confirmPIN) {
        _showPINErrorDialog(
          context,
          'PIN Mismatch',
          'The confirmation PIN does not match the new PIN. Please try again.',
        );
        return;
      }

      await updateNewPIN();
    } else {
      String message = _getPINErrorMessageForForgot(newPIN, confirmPIN);
      _showPINErrorDialog(context, 'Invalid PIN', message);
    }
  }

  String _getPINErrorMessageForForgot(String pin1, String pin2) {
    if (!_isPINValid(pin1) && !_isPINValid(pin2)) {
      return 'Both PINs must be 4 digits long.';
    } else if (!_isPINValid(pin1)) {
      return 'New PIN must be 4 digits long.';
    } else {
      return 'Confirmation PIN must be 4 digits long.';
    }
  }

  Future<void> confirmPin({
    required BuildContext context,
    required String confirmPIN,
    required Future<void> Function() toConfirmPin,
  }) async {
    if (_isPINValid(confirmPIN)) {
      await toConfirmPin();
    } else {
      _showPINErrorDialog(
        context,
        'Incomplete PIN',
        'Please enter a 4-digit PIN in the PIN field.',
      );
    }
  }

  Future<void> _validatePIN({
    required BuildContext context,
    required String createPIN,
    required String confirmPIN,
    required Future<void> Function() onValid,
  }) async {
    if (_isPINValid(createPIN) && _isPINValid(confirmPIN)) {
      if (createPIN == confirmPIN) {
        await onValid();
      } else {
        _showPINErrorDialog(
          context,
          'PIN Mismatch',
          'The entered PINs do not match. Please re-enter your PIN and confirmation.',
        );
      }
    } else {
      String message = _getPINErrorMessage(createPIN, confirmPIN);
      _showPINErrorDialog(context, 'Incomplete PIN', message);
    }
  }

  String _getPINErrorMessage(String firstPIN, String secondPIN) {
    if (!_isPINValid(firstPIN) && !_isPINValid(secondPIN)) {
      return 'Please enter a 4-digit PIN in both the Create PIN and Confirm PIN fields.';
    } else if (!_isPINValid(firstPIN)) {
      return 'Please enter a 4-digit PIN in the Create PIN field.';
    } else {
      return 'Please enter a 4-digit PIN in the Confirm PIN field.';
    }
  }

  void _showPINErrorDialog(BuildContext context, String title, String content) {
    DialogsX.showErrorDialog(
      context,
      title: title,
      content: content,
    );
  }
}
