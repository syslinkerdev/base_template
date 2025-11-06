import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final bool disableRotations;
  final double? pinInputHeight;
  final double? pinInputWidth;

  const IconContainer({
    super.key,
    required this.icon,
    this.iconSize,
    this.disableRotations = false,
    this.pinInputHeight,
    this.pinInputWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colorX = ColorX.instance.cS(context).surfaceTint;
    return Container(
      height: pinInputHeight ?? context.sizeOfHeight * 0.063,
      width: pinInputWidth ?? context.sizeOfWidth * 0.13,
      decoration: BoxDecoration(
        color: colorX,
        border: Border.all(color: colorX, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: disableRotations
          ? Align(
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: iconSize,
                color: ColorX.instance.ms.white(context),
              ),
            )
          : Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(pi / 2),
              child: Icon(
                icon,
                size: iconSize,
                color: ColorX.instance.ms.white(context),
              ),
            ),
    );
  }
}
