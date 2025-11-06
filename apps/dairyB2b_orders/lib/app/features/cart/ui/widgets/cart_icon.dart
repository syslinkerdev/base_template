import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_helper.dart';

class CartIcon extends ConsumerWidget {
  final double size;

  const CartIcon({super.key, this.size = 24});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartLength = CH.cartList(ref).length;
    final cartMode = CH.cartMode(ref);

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.shopping_cart,
            size: size,
          ),
          if (cartLength > 0)
            Positioned(
              right: -1,
              top: -13,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: cartMode.color,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
                child: Text(
                  '$cartLength',
                  style: TextStyles.h15Bold(context)?.copyWith(
                    color: appColors.ms.white(context),
                    fontSize: size * 0.45,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
