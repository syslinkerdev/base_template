import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/product_shorter_v.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/add_to_cart_btn.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

class CartCard extends ConsumerWidget {
  const CartCard({
    super.key,
    required this.item,
  });

  final Product item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartRead = ref.read(cartProvider.notifier);
    final int currentQty = item.userSideQuantity ?? 0;
    final int packSize = item.packSize;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => ProductShorterV.bottomSheet(context, item),
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: FadeInImageX(imagePath: item.image),
                  ),
                  gapW8,
                  Expanded(
                    child: SpacedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.brand.label} ${item.name}',
                          style: TextStyles.h13Bold(context),
                          maxLines: 2,
                        ),
                        Text(
                          '${item.unitDetails.displayLabel} (${item.shortForm})',
                          style: TextStyles.h14Gray(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          gapW8,
          SizedBox(
              width: context.sizeOfWidth * 0.36,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.sizeOfWidth * 0.2,
                    child: AddToCartBtn.cartQuantityBtn(
                      context,
                      productQuantity: currentQty,
                      size: context.sizeOfHeight * 0.03,
                      onAddTap: () => cartRead.updateItemQuantity(
                          item.id, currentQty + packSize,
                          updateFinalCart: true),
                      onRemoveTap: () {
                        if (currentQty <= packSize) {
                          cartRead.removeItem(item.id, updateFinalCart: true);
                        } else {
                          cartRead.updateItemQuantity(
                              item.id, currentQty - packSize,
                              updateFinalCart: true);
                        }
                      },
                    ),
                  ),
                  gapW8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      PriceTag(
                          price: item.priceAfterDiscount ?? 0,
                          style: TextStyles.h10Bold(context)),
                      if (item.priceAfterDiscount != item.price)
                        PriceTag(price: item.price, cancelStyle: true),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
