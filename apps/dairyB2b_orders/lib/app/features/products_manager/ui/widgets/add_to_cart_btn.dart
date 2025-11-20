import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

class AddToCartBtn extends HookConsumerWidget {
  const AddToCartBtn({
    super.key,
    required this.productId,
    required this.packSize,
    this.wantBg = false,
    this.size,
    this.fromPsv = false,
  });

  final String productId;
  final int packSize;
  final bool wantBg;
  final double? size;
  final bool fromPsv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double sizeX = size ?? context.sizeOfHeight * 0.042;
    final cartItems = ref.watch(cartProvider);
    final cartRead = ref.read(cartProvider.notifier);
    final cartState = cartItems.maybeWhen(
        data: (cart) => cart, orElse: () => cartItems.valueOrNull);
    final productExistsInCart = cartState?.cart
            ?.any((item) => item.productReference?.id == productId) ??
        false;
    final productQuantity = cartState?.cart
        ?.firstWhere((item) => item.productReference?.id == productId,
            orElse: () => CartItem.empty())
        .origQty;
    final itemLoadingState = cartState?.itemLoadingState?[productId] ?? false;

    return temp(
      context,
      size: sizeX,
      wantBg: wantBg,
      isLoading: itemLoadingState,
      child: productExistsInCart
          ? _buildQuantityRow(context, cartRead, (productQuantity ?? 0), sizeX)
          : _buildAddToCartButton(context, cartRead),
    );
  }

  static Widget temp(BuildContext context,
      {required double size,
      required Widget child,
      bool wantBg = false,
      bool isLoading = false}) {
    return Container(
      height: size,
      width: context.sizeOfWidth,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: wantBg ? appColors.cS(context).surfaceTint : null,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border:
            Border.all(color: appColors.cS(context).surfaceTint, width: 1.2),
      ),
      child: Stack(
        children: [
          // Your regular child widget goes here
          child,
          // Show loading indicator on top of the child if isLoading is true
          if (isLoading)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    appColors.cS(context).onPrimaryFixedVariant),
                backgroundColor: Colors.transparent,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, Cart cartRead) {
    return InkWell(
      onTap: () {
        cartRead.addItem(productId, packSize, updateFinalCart: fromPsv);
        showMessageSnackbar(
          context: context,
          duration: Durations.medium2,
          message: 'Pack Size : $packSize added',
        );
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            'Add to Cart',
            textAlign: TextAlign.center,
            style: wantBg
                ? TextStyles.h8Bold(context)
                    ?.copyWith(color: appColors.ms.whiteSwNero(context))
                : TextStyles.h14Bold(context)
                    ?.copyWith(color: appColors.cS(context).surfaceTint),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityRow(
      BuildContext context, Cart cartRead, int productQuantity, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _quantityButton(
          context,
          icon: Icons.remove,
          size: size,
          wantBg: wantBg,
          onTap: () => _handleRemoveAction(cartRead, productQuantity),
        ),
        Center(
          child: Text(
            '$productQuantity',
            style: wantBg
                ? TextStyles.h8Bold(context)?.copyWith(
                    color: appColors.ms.whiteSwNero(context),
                    fontSize: size * 0.3)
                : TextStyles.h9Bold(context)?.copyWith(
                    color: appColors.cS(context).surfaceTint,
                    fontSize: size * 0.32),
          ),
        ),
        _quantityButton(
          context,
          icon: Icons.add,
          size: size,
          wantBg: wantBg,
          onTap: () => cartRead.updateItemQuantity(
              productId, productQuantity + packSize,
              updateFinalCart: fromPsv),
        ),
      ],
    );
  }

  void _handleRemoveAction(Cart cartRead, int productQuantity) {
    if (productQuantity <= packSize) {
      cartRead.removeItem(productId, updateFinalCart: fromPsv);
    } else {
      cartRead.updateItemQuantity(productId, productQuantity - packSize,
          updateFinalCart: fromPsv);
    }
  }

  static Widget _quantityButton(BuildContext context,
      {required IconData icon,
      required void Function()? onTap,
      double? size,
      bool wantBg = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size!,
        width: size,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: icon == Icons.remove ? const Radius.circular(6) : Radius.zero,
            right: icon == Icons.add ? const Radius.circular(6) : Radius.zero,
          ),
          color: wantBg
              ? null
              : appColors.cS(context).primaryFixedDim.withValues(alpha: 0.2),
        ),
        child: Icon(
          icon,
          size: size * 0.5,
          color: wantBg
              ? appColors.ms.whiteSwNero(context)
              : appColors.cS(context).surfaceTint,
        ),
      ),
    );
  }

  /// for Cart Screen
  static Widget cartQuantityBtn(BuildContext context,
      {required int productQuantity,
      required double size,
      void Function()? onRemoveTap,
      void Function()? onAddTap}) {
    return temp(
      context,
      size: size * 1.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '$productQuantity',
              style: TextStyles.h9Bold(context)?.copyWith(
                  color: appColors.cS(context).surfaceTint,
                  fontSize: size * 0.43),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _quantityButton(context,
                  icon: Icons.remove, size: size, onTap: onRemoveTap),
              Flexible(
                child: Container(
                  height: size,
                  color: appColors
                      .cS(context)
                      .primaryFixedDim
                      .withValues(alpha: 0.2),
                ),
              ),
              _quantityButton(context,
                  icon: Icons.add, size: size, onTap: onAddTap),
            ],
          ),
        ],
      ),
    );
  }
}
