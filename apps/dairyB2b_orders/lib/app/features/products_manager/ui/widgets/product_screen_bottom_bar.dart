import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_helper.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/widgets/cart_icon.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/add_to_cart_btn.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

import 'package:dairyB2b_orders/router/app_route_paths.dart';

class ProductScreenBottomBar extends ConsumerStatefulWidget {
  const ProductScreenBottomBar(
      {super.key, required this.product, this.fromPsv = false});
  final Product product;
  final bool fromPsv;

  @override
  ConsumerState<ProductScreenBottomBar> createState() =>
      _ProductScreenBottomBarState();
}

class _ProductScreenBottomBarState extends ConsumerState<ProductScreenBottomBar>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> _showViewCart = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _showViewCart.dispose();
    super.dispose();
  }

  bool _isProductInCart(List<CartItem> cartItems) {
    return cartItems.any((item) => item.productReference?.id == widget.product.id);
  }

  Widget _buildViewCartButton(BuildContext context) {
    return ButtonX(
      label: 'View Cart',
      iconAsWidget: CartIcon(
        size: context.sizeOfHeight * 0.023,
      ),
      iconFirst: true,
      height: context.sizeOfHeight * 0.06,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: appColors.ms.greyTransparent80(context),
          width: 1,
        ),
      ),
      iconColor: appColors.ms.black80(context),
      backgroundColor: appColors.shad.e30(context),
      labelStyle: TextStyles.h12Bold(context),
      labelColor: appColors.ms.black(context),
      scale: true,
      onPressed: () {
        if (widget.fromPsv) {
          context.pop();
        } else {
          AppRoute.pushSubCart(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _showViewCart.value = _isProductInCart(CH.cartList(ref));
    final cartRead = ref.read(cartProvider.notifier);

    return ValueListenableBuilder<bool>(
      valueListenable: _showViewCart,
      builder: (context, isViewCartVisible, child) {
        return Row(
          children: [
            Flexible(
              flex: isViewCartVisible ? 1 : 0,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isViewCartVisible
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(
                                color: appColors.ms.greyTransparent80(context),
                                width: 1,
                              ),
                              padding: EdgeInsets.zero,
                              minimumSize:
                                  Size(40, context.sizeOfHeight * 0.06),
                            ),
                            onPressed: () => cartRead.removeItem(
                              widget.product.id,
                              updateFinalCart: widget.fromPsv,
                            ),
                            child: Icon(
                              Icons.delete_sweep,
                              size: context.sizeOfHeight * 0.03,
                              color: appColors.ms.black(context),
                            ),
                          ),
                          Expanded(child: _buildViewCartButton(context)),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
            ),
            if (isViewCartVisible) gapW4,
            Flexible(
              flex: 1,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: AddToCartBtn(
                    size: context.sizeOfHeight * 0.06,
                    productId: widget.product.id,
                    packSize: widget.product.packSize,
                    wantBg: true,
                    fromPsv: widget.fromPsv),
              ),
            ),
          ],
        );
      },
    );
  }
}
