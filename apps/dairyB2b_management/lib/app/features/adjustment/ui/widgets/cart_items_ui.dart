import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/add_to_cart_btn.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/product_shorter_v.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/products_screen.dart';

class CartItemsUI extends StatelessWidget {
  const CartItemsUI(
      {super.key, required this.items, this.mode, required this.ref});
  final List<Product> items;
  final AdjustmentMode? mode;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'User Items',
            icon: Icons.shopping_basket_rounded,
            color: appColors.cS(context).onPrimaryFixedVariant,
            trailing: InkWell(
              onTap: () => DialogsX.askForConfirmation(context,
                      content:
                          'Are you sure you want to undo this user\'s order?',
                      confirmBtnText: 'Yes',
                      cancelBtnText: 'No')
                  .then(
                (value) {
                  if (value == true) {
                    ref.read(adjustmentProvider.notifier).undo();
                  }
                },
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.redAccent.shade100,
                      Colors.pinkAccent.shade700
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    Icon(Icons.undo, color: const Color(0xFFFFC1BB), size: 19),
              ),
            ),
          ),
          DynamicList<Product>(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
            items: items,
            onSelect: (item) {},
            itemBuilder: (context, item, isSelected) => CartCard(item: item),
          ),
          DashDivider(),
          gapH4,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Missed something?', style: TextStyles.h12Bold(context)),
              ButtonX(
                  onPressed: () => prosBottomSheetNav(context),
                  label: 'Add More Items',
                  icon: Icons.add,
                  iconFirst: true,
                  labelStyle: TextStyles.h14Bold(context),
                  iconSize: 18,
                  backgroundColor: mode?.color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)))
            ],
          )
        ],
      ),
    );
  }
}

class CartCard extends ConsumerWidget {
  const CartCard({
    super.key,
    required this.item,
  });

  final Product item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adjustmentRead = ref.read(adjustmentProvider.notifier);
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
                      color: currentQty == 0 ? appColors.sc.mutedRed : null,
                      onAddTap: () => adjustmentRead.updateItemQuantity(
                          item.id, currentQty + packSize),
                      onRemoveTap: () {
                        if (currentQty <= packSize) {
                          adjustmentRead.removeItem(item.id);
                        } else {
                          adjustmentRead.updateItemQuantity(
                              item.id, currentQty - packSize);
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
