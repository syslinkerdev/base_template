import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class OtpField extends StatelessWidget with SignInValidator {
  const OtpField(
      {super.key,
      required this.otpController,
      this.onCompleted,
      this.numberToShow});
  final String? numberToShow;
  final void Function(String)? onCompleted;
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Enter the 6-digit code sent to\n+91 - ${numberToShow ?? 'your number'}",
            style: TextStyles.h7(context)
                ?.copyWith(fontSize: context.sizeOfHeight * 0.023)),
        gapH16,
        PinPutField(
          controller: otpController,
          onCompleted: onCompleted,
          otpErrorText: otpErrorText,
        ),
      ],
    );
  }
}
