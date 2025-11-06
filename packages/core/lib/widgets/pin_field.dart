import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PinField extends StatelessWidget {
  const PinField({
    super.key,
    required this.controller,
    required this.title,
    this.onCompleted,
    this.onEyeTap,
    this.obscureText = true,
    this.onPinPutTap,
  });

  final TextEditingController controller;
  final String title;
  final void Function(String)? onCompleted;
  final void Function()? onEyeTap;
  final bool obscureText;
  final void Function()? onPinPutTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CaptionText(title: title),
        gapH8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const IconContainer(icon: Icons.key_sharp),
                gapW8,
                PinPutField(
                  onTap: onPinPutTap,
                  obscureText: obscureText,
                  length: 4,
                  controller: controller,
                  onCompleted: onCompleted,
                ),
              ],
            ),
            gapW8,
            InkWell(
              onTap: onEyeTap,
              child: IconContainer(
                disableRotations: true,
                icon: obscureText
                    ? Icons.visibility_off_sharp
                    : Icons.visibility_sharp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
