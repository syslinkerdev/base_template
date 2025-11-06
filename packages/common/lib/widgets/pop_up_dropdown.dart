import 'package:core/core.dart';
import 'package:flutter/material.dart';

class PopUpDropdown<T> extends StatelessWidget {
  final String? hintText;
  final String? tooltip;
  final List<T> items;
  final T? value;
  final String Function(T) itemLabel;
  final void Function(T) onSelected;

  const PopUpDropdown({
    super.key,
    this.hintText,
    this.tooltip,
    required this.items,
    required this.value,
    required this.itemLabel,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorX = appColors.cS(context).inversePrimary;
    return PopupMenuButton<T>(
      tooltip: tooltip,
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (context) {
        return items
            .map(
              (item) => PopupMenuItem<T>(
                value: item,
                child: Text(itemLabel(item)),
              ),
            )
            .toList();
      },
      onSelected: onSelected,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6).copyWith(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border:
              Border.all(color: appColors.cS(context).surfaceTint, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value != null ? itemLabel(value!) : (hintText ?? 'Select'),
              style: TextStyles.h14Bold(context)?.copyWith(color: colorX),
            ),
            gapW8,
            Icon(Icons.keyboard_arrow_down_rounded, size: 21, color: colorX),
          ],
        ),
      ),
    );
  }
}
