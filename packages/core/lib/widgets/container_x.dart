import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ContainerX extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  // If width is -1 then we sent null to the container
  final double? width;
  final Color? bg;
  final Gradient? gradient;
  final bool? noBorderAndBg;
  final double? height;
  final Color? borderColor;
  final double? borderWidth;

  const ContainerX(
      {super.key,
      required this.child,
      this.margin = const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      this.padding = const EdgeInsets.all(14),
      this.width,
      this.bg,
      this.gradient,
      this.noBorderAndBg,
      this.height,
      this.borderColor,
      this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: noBorderAndBg == true
              ? null
              : bg ?? ColorX.instance.shad.e30(context),
          gradient: gradient,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: noBorderAndBg == true
              ? null
              : Border.all(
                  color: borderColor ??
                      ColorX.instance.ms.greyTransparent20(context),
                  width: borderWidth ?? 1)),
      width: width == -1 ? null : width ?? context.sizeOfWidth,
      height: height,
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}
