import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepX extends StatelessWidget {
  const StepX({
    super.key,
    required this.isFirst,
    required this.isLast,
    this.label,
    this.afterLine = false,
    this.beforeLine = false,
    this.point = false,
    this.width,
    this.onTap,
    this.seedColor,
  });
  final bool isFirst;
  final bool isLast;
  final bool afterLine;
  final bool beforeLine;
  final bool point;
  final String? label;
  final double? width;
  final VoidCallback? onTap; // Callback to notify step tap
  final Color? seedColor;

  @override
  Widget build(BuildContext context) {
    final Color seed = seedColor ?? context.colorScheme.inversePrimary;
    final Color inactive = getInactiveStepperColor(seed);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: TimelineTile(
          axis: TimelineAxis.horizontal,
          isFirst: isFirst,
          isLast: isLast,
          alignment: TimelineAlign.center,
          lineXY: 0.6,
          afterLineStyle: LineStyle(color: afterLine ? seed : inactive),
          beforeLineStyle: LineStyle(color: beforeLine ? seed : inactive),
          indicatorStyle: IndicatorStyle(
            color: point ? seed : inactive,
            iconStyle: IconStyle(
              fontSize: 14,
              iconData: point ? Icons.circle_outlined : Icons.circle_rounded,
              color: appColors.sc.whiteS,
            ),
          ),
          startChild: label == null
              ? null
              : Text(
                  label!,
                  style: TextStyles.h8(context)
                      ?.copyWith(color: point ? seed : inactive),
                ),
        ),
      ),
    );
  }
}

Color getInactiveStepperColor(Color color) {
  const grayBase = Color(0xFFB0B0B0); // light-medium neutral gray

  return Color.alphaBlend(
    grayBase.withValues(alpha: 0.6), // adjust opacity for how gray it feels
    color,
  );
}
