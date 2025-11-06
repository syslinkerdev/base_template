import 'package:flutter/material.dart';
import 'package:core/core.dart';

class CaptionText extends StatelessWidget {
  const CaptionText(
      {super.key, required this.title, this.isRequired = true, this.textColor});

  final Color? textColor;
  final String title;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    Color? textColorX = textColor ?? ColorX.instance.cS(context).onSurface;
    if (title.doesNotHaveValue) return const SizedBox.shrink();
    return RichText(
      text: TextSpan(
        style: TextStyles.h9Bold(context)?.copyWith(
            color: textColorX, fontWeight: FontWeight.w600, letterSpacing: .5),
        children: [
          TextSpan(text: title),
          if (isRequired) ...[
            TextSpan(
                text: ' *', style: TextStyle(color: ColorX.instance.sc.red)),
          ],
        ],
      ),
    );
  }
}
