import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class SmartBasketCard extends StatelessWidget {
  const SmartBasketCard(
      {super.key, required this.smartBasket, this.forDetailsPage = false});
  final SmartBasket smartBasket;
  final bool forDetailsPage;
  @override
  Widget build(BuildContext context) {
    final total = smartBasket.items.fold<double>(
      0,
      (sum, item) {
        final price = (item.unitPrice ?? 0);
        final qty = item.origQty;
        // debugPrint(
        //     'Item: ${item.productName}, unitPrice: $price, qty: $qty, total: ${price * qty}');
        return sum + (price * qty);
      },
    );

    return ContainerX(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.sizeOfWidth * 0.1,
                  height: context.sizeOfHeight * 0.05,
                  decoration: BoxDecoration(
                      color: appColors.cS(context).inversePrimary,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "B-${smartBasket.createdAt?.day ?? ''}",
                      style: TextStyles.h10Bold(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                gapW8,
                Expanded(
                  child: Text(smartBasket.basketName,
                      style: TextStyles.h9Bold(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start),
                ),
              ],
            ),
            SimpleDivider(),

            // ✅ Items Preview
            if (!forDetailsPage) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in smartBasket.items.take(2))
                      Text(
                        "• ${item.productName}",
                        style: TextStyles.h13Bold(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (smartBasket.items.length > 2)
                      Text(
                        "+ ${smartBasket.items.length - 2} more…",
                        style: TextStyles.h13(context)?.copyWith(
                          color: appColors.ms.textBlack50(context),
                        ),
                      ),
                  ],
                ),
              ),
            ],

            // date and icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Basket Created on ${smartBasket.createdAt != null ? DFU.moreFriendlyFormat(smartBasket.createdAt!) : 'Unknown date'}",
                    style: TextStyles.h13Bold(context)
                        ?.copyWith(color: appColors.ms.textBlack50(context)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹${PriceTag.formatPrice(total)}', //127 + 160 +
                      style: TextStyles.h11Bold(context)
                          ?.copyWith(fontFamily: 'Roboto'),
                    ),
                    gapW2,
                    if (!forDetailsPage)
                      Icon(
                        Icons.arrow_forward_ios,
                        size: context.sizeOfHeight * 0.017,
                        color: appColors.sc.grey500,
                      ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
