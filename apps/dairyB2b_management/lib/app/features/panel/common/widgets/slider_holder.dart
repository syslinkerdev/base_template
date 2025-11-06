import 'package:flutter/material.dart';

class SliderHolder extends StatelessWidget {
  const SliderHolder(
      {super.key, this.leading, required this.slider, this.trailing});
  final Widget? leading;
  final Slider slider;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Leading
        if (leading != null) leading!,
        // Slider
        Expanded(child: slider),
        // Trailing
        if (trailing != null) trailing!,
      ],
    );
  }
}
