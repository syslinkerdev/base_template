import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

mixin CommonValidator {
  Future<void> submitUserDetails(
          {required firstName,
          required lastName,
          required BuildContext context,
          required Future<void> Function() updateUserDetails}) async =>
      await submitData(
          context: context,
          texts: [firstName, lastName],
          textErrors: ['Enter your first name!', 'Enter your last name!'],
          updateData: updateUserDetails);

  Future<void> submitShopDetails(
          {required String? shopName,
          required Address? address,
          required BuildContext context,
          required Future<void> Function() updateShopDetails}) async =>
      await submitData(
          context: context,
          texts: [
            shopName ?? '',
            address!.stateName,
            address.city,
            address.locality,
            address.pinCode,
            address.street,
            address.buildingNumber,
          ],
          textErrors: [
            'Enter your shop name!',
            'Enter your state!',
            'Enter your city!',
            'Enter your locality!',
            'Enter your pin code!',
            'Enter your street!',
            'Enter your building number!',
          ],
          updateData: updateShopDetails);

  Future<void> submitAccessCode({
    required BuildContext context,
    required String code,
    required String accessCode,
    required Future<void> Function() verifyAccessCode,
    bool showSnackbar = false,
  }) async {
    if (code.length != 6) {
      _showErrorMessage(
        context: context,
        showSnackbar: showSnackbar,
        message: 'Enter access code sent by the admin!',
      );
      return;
    }

    if (canSubmitAccessCode(code) && accessCode == code) {
      await verifyAccessCode();
    } else {
      _showErrorMessage(
        context: context,
        showSnackbar: showSnackbar,
        message:
            'The 6-digit code you entered is incorrect. Please check the message sent by the admin.',
      );
    }
  }

  Future<void> submitAccessCodeExPhoneNo({
    required BuildContext context,
    required WidgetRef ref,
    required String code,
    required String phoneNo,
    required Future<void> Function() verifyAccessCode,
    bool showSnackbar = false,
  }) async {
    // Validate phone number
    if (phoneNo.length != 10) {
      _showErrorMessage(
        context: context,
        showSnackbar: showSnackbar,
        message: 'Please enter a valid phone number.',
      );
      return;
    }
    // Validate access code
    if (canSubmitAccessCode(code) && context.mounted) {
      await verifyAccessCode();
    } else {
      _showErrorMessage(
        context: context,
        showSnackbar: showSnackbar,
        message: 'Enter access code sent by the admin!',
      );
    }
  }

  // Reusable error message display
  void _showErrorMessage({
    required BuildContext context,
    required String message,
    bool showSnackbar = false,
  }) {
    if (showSnackbar) {
      showMessageSnackbar(
          context: context,
          message: message,
          type: SnackBarType.error,
          maxLines: 3);
    } else {
      DialogsX.showErrorDialog(context, title: 'Warning', content: message);
    }
  }

  bool canSubmitAccessCode(String code) => code.isNotEmpty && code.length == 6;

  String? accessErrorText(String? code) {
    final bool showErrorText = !canSubmitAccessCode(code!);
    const String errorText = "Invalid code";
    return showErrorText ? errorText : null;
  }

  Future<void> phoneNoValidator({
    required BuildContext context,
    required String phoneNo,
    required Future<void> Function() toProceed,
    bool showSnackbar = true,
  }) async {
    if (phoneNo.containsValidValue && phoneNo.length == 10) {
      await toProceed();
    } else {
      _showErrorMessage(
        context: context,
        showSnackbar: showSnackbar,
        message: 'Please enter a valid phone number.',
      );
      return;
    }
  }

  Future<void> submitBasketName(
          {required BasketName,
          required BuildContext context,
          required Future<void> Function() updateBasketName}) async =>
      await submitData(
          context: context,
          texts: [BasketName],
          textErrors: ['Enter your smart basket name!'],
          updateData: updateBasketName);
}
