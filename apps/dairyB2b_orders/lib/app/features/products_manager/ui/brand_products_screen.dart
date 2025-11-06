import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_helper.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/product_list.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/products_bottom_bar.dart';
import 'package:core/core.dart';

class BrandProductsScreen extends HookConsumerWidget {
  const BrandProductsScreen({super.key, this.brand});
  final Brand? brand;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = CH.cartCount(ref);
    final cartLength = CH.cartList(ref).length;
    return ScaffoldX(
        title: brand?.label,
        wantLeading: true,
        appToolbarHeight: -1,
        // appBarActions: [AnyWereSearchBtn()],
        bottomNavigationBar: cartCount == 0
            ? null
            : ProductsBottomBar(cartLength: cartLength, cartCount: cartCount),
        body: ProductList(
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 22),
            initBrand: brand?.id));
  }
}
