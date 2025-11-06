import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:core/core.dart';

class PinPutShow extends StatelessWidget {
  const PinPutShow({
    super.key,
    this.length = 6,
    this.obscureText = false,
    this.onLastIconTap,
    this.lastIcon,
    this.pinInputHeight,
    this.pinInputWidth,
    this.lastIconSize,
    required this.controller,
  });

  final int length;
  final bool obscureText;
  final void Function()? onLastIconTap;
  final IconData? lastIcon;
  final double? pinInputHeight;
  final double? pinInputWidth;
  final double? lastIconSize;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colorX = ColorX.instance.cS(context).surfaceTint;

    final defaultPinTheme = PinTheme(
      height: pinInputHeight ?? context.sizeOfHeight * 0.063,
      width: pinInputWidth ?? context.sizeOfWidth * 0.13,
      textStyle: TextStyles.h7Bold(context)?.copyWith(),
      decoration: BoxDecoration(
        border: Border.all(color: colorX, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: colorX, width: 2),
      borderRadius: BorderRadius.circular(8),
      color: colorX,
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: colorX,
      ),
    );
    return InkWell(
      onTap: onLastIconTap,
      child: Row(
        children: [
          Pinput(
            enableSuggestions: false,
            toolbarEnabled: false,
            obscuringWidget: Icon(
              Icons.blur_on_rounded,
              size: lastIconSize ?? context.sizeOfHeight * 0.04,
              color: ColorX.instance.ms.white(context),
            ),
            length: length,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            readOnly: true,
            obscureText: obscureText,
            controller: controller,

            // ↓ Removes spacing
            mainAxisAlignment: MainAxisAlignment.center,
            separatorBuilder: (index) => gapW2,
          ),
          if (lastIcon != null) ...[
            gapW4,
            InkWell(
              onTap: onLastIconTap,
              child: IconContainer(
                disableRotations: true,
                icon: lastIcon!,
                pinInputHeight: pinInputHeight,
                pinInputWidth: pinInputWidth,
                iconSize: lastIconSize,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
