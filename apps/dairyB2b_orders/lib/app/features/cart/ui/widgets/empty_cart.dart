import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key, required this.mode});
  final CartMode mode;

  @override
  Widget build(BuildContext context) {
    final (icon, title, subtitle, buttonLabel) = switch (mode) {
      CartMode.newOrder => (
          Icons.add_shopping_cart_rounded,
          'Your cart is empty',
          'Start shopping and fill your cart.',
          'Browse Products'
        ),
      CartMode.edit => (
          Icons.edit_off_rounded,
          'Nothing to edit',
          'This order has no items yet.',
          'Go Back'
        ),
      CartMode.basket => (
          Icons.lightbulb_outline_rounded,
          'Empty Smart Basket',
          'Add items to this Smart Basket.',
          'Add Items'
        ),
      CartMode.editBasket => (
          Icons.edit_road_rounded,
          'No Basket Items',
          'This basket has no items to edit.',
          'Add Items'
        ),
    };
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 2),
      child: SpacedColumn(
        defaultHeight: 8.0,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: context.sizeOfHeight * 0.1),
          Text(title, style: TextStyles.h7Bold(context)),
          Text(subtitle,
              style: TextStyles.h9Gray(context), textAlign: TextAlign.center),
          ButtonX(
              label: buttonLabel,
              backgroundColor: mode.color,
              onPressed: () => StatefulNavigationShell.of(context)
                  .goBranch(0, initialLocation: true)),
        ],
      ),
    );
  }
}
