import 'package:flutter/material.dart';
import 'package:core/core.dart';

class IconLabel {
  final String id;
  final String label;
  final IconData icon;

  IconLabel({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class ScrollableButtonRow extends StatefulWidget {
  final List<IconLabel> items;
  final String? initialSelectedId;
  final void Function(IconLabel) onSelect;

  const ScrollableButtonRow({
    super.key,
    required this.items,
    this.initialSelectedId,
    required this.onSelect,
  });

  @override
  State<ScrollableButtonRow> createState() => _ScrollableButtonRowState();
}

class _ScrollableButtonRowState extends State<ScrollableButtonRow> {
  late String? selectedId;

  @override
  void initState() {
    super.initState();
    selectedId = widget.initialSelectedId ?? widget.items.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.items.map((item) {
          final isSelected = item.id == selectedId;
          return InkWell(
            onTap: () {
              setState(() {
                selectedId = item.id;
              });
              widget.onSelect(item);
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 6).copyWith(right: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: appColors
                      .cS(context)
                      .surfaceTint
                      .withValues(alpha: isSelected ? 1 : 0.5),
                  width: isSelected ? 2 : 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColors
                          .cS(context)
                          .surfaceTint
                          .withValues(alpha: isSelected ? 0.6 : 0.2),
                    ),
                    child: Icon(
                      item.icon,
                      size: 15,
                      color: appColors.ms.neroSwWhite(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 6),
                    child: Text(
                      item.label,
                      style: TextStyles.h15Bold(context)?.copyWith(
                        color: appColors.cS(context).surfaceTint,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
