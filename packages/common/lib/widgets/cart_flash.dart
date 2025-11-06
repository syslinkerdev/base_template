import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';

class CartFlash extends HookConsumerWidget {
  const CartFlash({super.key, required this.cartItems});
  final List<Product> cartItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compactMode = useState(true);

    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => compactMode.value = !compactMode.value,
            child: ColorBgIconHeader(
              label: 'Cart Flash',
              icon: Icons.flash_on,
              color: appColors.sc.warning,
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
          DynamicList<Product>(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
            onSelect: (item) {},
            items: cartItems,
            listSeparatorBuilder: (context, index) =>
                compactMode.value ? SizedBox.shrink() : DashDivider(),
            itemBuilder: (context, item, isSelected) {
              final priceEach = item.priceAfterDiscount ?? 0;
              final origLabel = item.unitDetails.formatTotalWithCount(
                  (item.userSideQuantity ?? 0).toDouble(),
                  countLabel: item.productType.shortForm);
              final totalPrice = priceEach * (item.userSideQuantity ?? 0);

              return CartCardShortVersion(
                compactMode: compactMode.value,
                searchKey: item.searchKey.shortKey,
                priceEach: priceEach,
                origLabel: origLabel,
                totalPrice: totalPrice,
                name: '${item.brand.label} ${item.name}',
                unitLabel: item.unitDetails.displayLabel,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CartCardShortVersion extends StatelessWidget {
  final String searchKey;
  final String origLabel;
  final String? adjLabel;
  final double totalPrice;
  final String? name;
  final String? unitLabel;
  final double priceEach;
  final bool compactMode;

  const CartCardShortVersion({
    super.key,
    required this.searchKey,
    required this.origLabel,
    this.adjLabel,
    required this.totalPrice,
    this.name,
    this.unitLabel,
    required this.priceEach,
    this.compactMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool showStrikethrough = adjLabel != null;
    final String origLabelX = showStrikethrough ? origLabel : '× $origLabel';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top row → Product + Qty + Total Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Product name / searchKey
              Flexible(
                flex: 1,
                child: Text(
                  searchKey,
                  style: TextStyles.h14Bold(context)
                      ?.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// Quantity + total price
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Qty column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (adjLabel != null)
                          Text(
                            '× $adjLabel',
                            style: TextStyles.h14Gray(context)?.copyWith(
                              height: 1,
                            ),
                          ),
                        Text(
                          origLabelX,
                          style: TextStyles.h15Gray(context)?.copyWith(
                            fontSize: showStrikethrough ? 10 : null,
                            height: showStrikethrough ? 0.9 : null,
                            decoration: showStrikethrough
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor:
                                showStrikethrough ? Colors.red.shade100 : null,
                            color:
                                showStrikethrough ? Colors.grey.shade600 : null,
                          ),
                        ),
                      ],
                    ),

                    /// Total price
                    Text(
                      '₹${PriceTag.formatPrice(totalPrice)}',
                      style: TextStyles.h14Bold(context)
                          ?.copyWith(fontFamily: 'Roboto'),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// Bottom row → Price each (+ optional details)
          if (!compactMode) ...[
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '$name (${unitLabel ?? ""})',
                    style: TextStyles.h13Gray(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '₹${PriceTag.formatPrice(priceEach)} ~ea.',
                  style: TextStyles.h14Gray(context)
                      ?.copyWith(fontFamily: 'Roboto'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
