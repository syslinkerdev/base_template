import 'package:core/core.dart';
import 'package:flutter/material.dart';

class filterButton extends StatelessWidget {
  const filterButton({super.key, this.isSelected = true, required this.label});
  final bool isSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6).copyWith(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(200)),
          border: Border.all(
              color: appColors
                  .cS(context)
                  .surfaceTint
                  .withValues(alpha: isSelected ? 1 : 0.5),
              width: isSelected ? 2 : 1.5)),
      child: Text(
        label,
        style: TextStyles.h14Bold(context)?.copyWith(
          color: appColors.cS(context).inversePrimary,
        ),
      ),
    );
  }
}
