import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/widgets/cart_card.dart';

class CartItemsUI extends StatelessWidget {
  const CartItemsUI(
      {super.key,
      required this.cartItems,
      required this.mode,
      required this.ref});
  final List<Product> cartItems;
  final CartMode mode;
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
            color: appColors.cS(context).primary,
            trailing: InkWell(
              onTap: () => DialogsX.askForConfirmation(context,
                      content: 'Do you want to clear cart!',
                      confirmBtnText: 'Yes',
                      cancelBtnText: 'No')
                  .then(
                (value) {
                  if (value == true) {
                    ref.read(cartProvider.notifier).cleanCartItems(mode: mode);
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
                child: Icon(
                  Icons.delete_sweep,
                  color: const Color(0xFFFFC1BB),
                  size: 19,
                ),
              ),
            ),
          ),
          DynamicList<Product>(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
            items: cartItems,
            onSelect: (item) {},
            itemBuilder: (context, item, isSelected) => CartCard(item: item),
          ),
          DashDivider(),
          gapH4,
          _addMore(context, mode)
        ],
      ),
    );
  }

  Widget _addMore(BuildContext context, CartMode mode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Missed something?', style: TextStyles.h12Bold(context)),
        ButtonX(
            onPressed: () => StatefulNavigationShell.of(context)
                .goBranch(0, initialLocation: true),
            label: 'Add More Items',
            icon: Icons.add,
            backgroundColor: mode.color,
            iconFirst: true,
            labelStyle: TextStyles.h14Bold(context),
            iconSize: 18,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)))
      ],
    );
  }
}
