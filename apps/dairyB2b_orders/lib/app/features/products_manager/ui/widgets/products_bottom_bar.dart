import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:dairyB2b_orders/router/app_route_paths.dart';

class ProductsBottomBar extends StatelessWidget {
  const ProductsBottomBar({
    super.key,
    required this.cartCount,
    required this.cartLength,
  });

  final int cartCount;
  final int cartLength;

  @override
  Widget build(BuildContext context) {
    final colorX = appColors.cS(context).surfaceTint;

    return InkWell(
      onTap: () => AppRoute.pushSubCart(context),
      child: Container(
          height: context.sizeOfHeight * 0.06,
          width: context.sizeOfWidth,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorX,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: colorX, width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$cartLength | $cartCount Items Count',
                style: TextStyles.h9Bold(context)
                    ?.copyWith(color: appColors.ms.white(context)),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      color: appColors.ms.white(context)),
                  Text(
                    'View Cart',
                    style: TextStyles.h8Bold(context)
                        ?.copyWith(color: appColors.ms.white(context)),
                  )
                ],
              )
            ],
          )),
    );
  }
}
