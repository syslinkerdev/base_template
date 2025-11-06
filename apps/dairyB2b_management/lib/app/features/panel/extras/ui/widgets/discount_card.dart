import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class DiscountCard extends StatelessWidget {
  final Discount discount;
  final String disSectionId;
  final bool isSelected;
  final VoidCallback? onToggle;
  final bool forMultiSelection;
  const DiscountCard(
      {super.key,
      required this.discount,
      required this.disSectionId,
      required this.isSelected,
      this.onToggle,
      this.forMultiSelection = false});

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 2),
      borderColor: isSelected ? appColors.cS(context).surfaceTint : null,
      borderWidth: isSelected ? 2 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (forMultiSelection) ...[
                // ✅ Checkbox
                Checkbox(
                  value: isSelected,
                  onChanged: (_) {
                    if (onToggle != null) {
                      onToggle!();
                    }
                  },
                ),
              ],

              // Product key as title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      discount.productKey,
                      style: TextStyles.h9Bold(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (disSectionId ==
                        DiscountSectionHelpers.GlobalDiscountsDocId) ...[
                      Row(
                        children: [
                          Icon(
                            discount.status.icon,
                            size: 12,
                            color: discount.status.color,
                          ),
                          gapW2,
                          Text(
                            discount.status.label,
                            style: TextStyles.h13Gray(context)
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),

              // Discount value
              Row(
                children: [
                  const Icon(Icons.discount, size: 16, color: Colors.green),
                  gapW4,
                  Text(
                    '\u{20B9}${PriceTag.formatPrice(discount.discount)}',
                    style: TextStyles.h8Gray(context)?.copyWith(
                        fontFamily: 'Roboto', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
