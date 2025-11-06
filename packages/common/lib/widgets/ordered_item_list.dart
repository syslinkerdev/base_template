import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderedItemList extends HookConsumerWidget {
  const OrderedItemList({
    super.key,
    required this.items,
    required this.headerLabel,
    required this.headerIcon,
    required this.headerColor,
  });
  final List<CartItem> items;
  final String headerLabel;
  final IconData headerIcon;
  final Color headerColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compactMode = useState(true);

    return ContainerX(
      margin: EdgeInsets.zero,
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => compactMode.value = !compactMode.value,
            child: ColorBgIconHeader(
              label: headerLabel,
              icon: headerIcon,
              color: headerColor,
              trailing: Tooltip(
                message: compactMode.value
                    ? "Show full details"
                    : "Show compact view",
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    compactMode.value ? Icons.view_list : Icons.view_agenda,
                    key: ValueKey(compactMode.value),
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          DynamicList<CartItem>(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
            listSeparatorBuilder: (context, index) =>
                compactMode.value ? SizedBox.shrink() : DashDivider(),
            onSelect: (_) {},
            items: items,
            itemBuilder: (context, item, isSelected) {
              final priceEach = (item.unitPrice ?? 0) - item.discount;
              final totalPrice = priceEach * (item.adjQty ?? item.origQty);

              return CartCardShortVersion(
                searchKey: item.searchKey.shortKey,
                priceEach: priceEach,
                origLabel: item.origLabel ?? "N/A",
                adjLabel: item.adjLabel,
                totalPrice: totalPrice,
                compactMode: compactMode.value,
                name: item.productName,
                unitLabel: item.unitLabel,
              );
            },
          ),
        ],
      ),
    );
  }
}
