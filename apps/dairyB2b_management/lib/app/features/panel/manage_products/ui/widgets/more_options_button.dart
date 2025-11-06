import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MoreOptionsButton<T> extends StatelessWidget {
  const MoreOptionsButton(
      {super.key,
      required this.items,
      required this.onSelected,
      required this.labelBuilder,
      this.iconBuilder,
      this.icon = const Icon(Icons.more_vert, size: 20),
      this.tooltip,
      this.offsetY = 25});

  final List<T> items;
  final void Function(T) onSelected;
  final String Function(T) labelBuilder;
  final IconData? Function(T)? iconBuilder;
  final Widget icon;
  final String? tooltip;
  final double offsetY;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      tooltip: tooltip,
      offset: Offset(0, offsetY),
      onSelected: onSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (context) {
        return items.map(
          (item) {
            final label = labelBuilder(item);
            final iconData = iconBuilder?.call(item);

            return PopupMenuItem<T>(
              value: item,
              height: 30,
              child: Row(
                children: [
                  if (iconData != null) ...[
                    Icon(iconData, size: 16),
                    gapW8,
                  ],
                  Text(label),
                ],
              ),
            );
          },
        ).toList();
      },
      child: icon,
    );
  }
}

class MoreOptionsItem {
  final String value;
  final String label;
  final IconData? icon;

  MoreOptionsItem({
    required this.value,
    required this.label,
    this.icon,
  });
}
