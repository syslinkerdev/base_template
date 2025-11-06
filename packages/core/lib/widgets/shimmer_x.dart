import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShimmerX extends HookConsumerWidget {
  final double width;
  final double height;
  final bool isCircular; // To handle circular or rectangular shape
  final Duration duration; // Animation duration
  final Color? baseColor; // Color of the base
  final Color? highlightColor; // Highlight color of the shimmer
  final AlignmentGeometry? alignment;

  const ShimmerX(
      {super.key,
      required this.width,
      required this.height,
      this.isCircular = false, // Default is rectangular
      this.duration = const Duration(seconds: 2),
      this.baseColor,
      this.highlightColor,
      this.alignment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using useAnimationController from hooks_riverpod to manage animation
    final controller = useAnimationController(
      duration: duration,
      lowerBound: -1.0,
      upperBound: 1.0,
    );
    final baseColorX = baseColor ?? ColorX.instance.ms.shimmerBase(context);
    final highlightColorX =
        highlightColor ?? ColorX.instance.ms.shimmerHighlight(context);

    // Start animation
    controller.repeat();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Align(
          alignment: alignment ?? Alignment.center,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: baseColorX,
              shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isCircular ? null : BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment(-1 - controller.value, 0),
                end: Alignment(1 - controller.value, 0),
                colors: [
                  baseColorX,
                  highlightColorX,
                  baseColorX,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }
}
