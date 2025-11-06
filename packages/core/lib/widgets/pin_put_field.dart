import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:core/core.dart';

class PinPutField extends StatelessWidget {
  const PinPutField({
    super.key,
    required this.controller,
    required this.onCompleted,
    this.onTap,
    this.otpErrorText,
    this.length = 6,
    this.obscureText = false,
    this.inPutColor,
  });

  final int length;
  final Color? inPutColor;
  final bool obscureText;
  final String? Function(String?)? otpErrorText;
  final TextEditingController controller;
  final void Function()? onTap;
  final void Function(String value)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final colorX = ColorX.instance.cS(context).primary;

    final defaultPinTheme = PinTheme(
      height: context.sizeOfHeight * 0.063,
      width: context.sizeOfWidth * 0.13,
      textStyle: TextStyles.h7Bold(context)
          ?.copyWith(color: inPutColor ?? ColorX.instance.ms.white(context)),
      decoration: BoxDecoration(
          border: Border.all(color: colorX, width: 2),
          borderRadius: BorderRadius.circular(8)),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
        textStyle: TextStyles.h7Bold(context)?.copyWith(color: colorX),
        decoration: BoxDecoration(
          border: Border.all(color: colorX, width: 2),
          borderRadius: BorderRadius.circular(8),
        ));

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(color: colorX),
    );
    return Pinput(
      enableSuggestions: false,
      toolbarEnabled: false,
      onTap: onTap,
      obscuringWidget: Icon(
        Icons.blur_on_rounded,
        size: context.sizeOfHeight * 0.04,
        color: ColorX.instance.ms.white(context),
      ),
      validator: otpErrorText,
      length: length,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      obscureText: obscureText,
      controller: controller,
      onCompleted: onCompleted,
    );
  }
}
