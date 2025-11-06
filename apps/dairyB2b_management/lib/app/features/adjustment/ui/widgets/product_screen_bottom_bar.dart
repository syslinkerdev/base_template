import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_helper.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/add_to_cart_btn.dart';

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

  bool _isProductInCart(List<Product> cartItems) {
    return cartItems.any((item) => item.id == widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    _showViewCart.value = _isProductInCart(AH.finalCartList(ref));
    final adjustmentRead = ref.read(adjustmentProvider.notifier);

    return ValueListenableBuilder<bool>(
      valueListenable: _showViewCart,
      builder: (context, isViewCartVisible, child) {
        return Row(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isViewCartVisible
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: appColors.ms.greyTransparent80(context),
                          width: 1,
                        ),
                        padding: EdgeInsets.zero,
                        minimumSize: Size(40, context.sizeOfHeight * 0.06),
                      ),
                      onPressed: () =>
                          adjustmentRead.removeItem(widget.product.id),
                      child: Icon(
                        Icons.delete_sweep,
                        size: context.sizeOfHeight * 0.03,
                        color: appColors.ms.black(context),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
            if (isViewCartVisible) gapW4,
            Expanded(
              // flex: 1,
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
