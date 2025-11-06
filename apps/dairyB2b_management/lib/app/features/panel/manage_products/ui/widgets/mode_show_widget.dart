import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ModeShowWidget extends StatelessWidget {
  const ModeShowWidget({
    super.key,
    required this.color,
    required this.label,
    this.icon,
    this.iconSize,
    this.borderWidth,
    this.labelStyle,
  });
  final Color color;
  final String label;
  final IconData? icon;
  final double? iconSize;
  final double? borderWidth;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final labelStyleX =
        (labelStyle ?? TextStyles.h10Bold(context))?.copyWith(color: color);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: appColors.ms.transparent(context),
        borderRadius: BorderRadius.all(Radius.circular(context.sizeOfHeight)),
        border: Border.all(color: color, width: borderWidth ?? 2),
      ),
      child: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: iconSize ?? 18),
                Text(label, style: labelStyleX),
              ],
            )
          : Text(label, style: labelStyleX),
    );
  }
}
