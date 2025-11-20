import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';

class AddToCartBtn extends HookConsumerWidget {
  const AddToCartBtn({
    super.key,
    required this.productId,
    required this.packSize,
    this.wantBg = false,
    this.size,
    this.fromPsv = false,
    this.color,
  });

  final String productId;
  final int packSize;
  final bool wantBg;
  final double? size;
  final Color? color;
  final bool fromPsv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double sizeX = size ?? context.sizeOfHeight * 0.042;
    final adjustmentRead = ref.read(adjustmentProvider.notifier);
    final adjustment = ref.watch(adjustmentProvider);
    final adjustmentState = adjustment.maybeWhen(
        data: (cart) => cart, orElse: () => adjustment.valueOrNull);
    final productExistsInCart =
        adjustmentState?.finalCart?.any((item) => item.id == productId) ??
            false;
    final productQuantity = adjustmentState?.finalCart
        ?.firstWhere((pro) => pro.id == productId,
            orElse: () => Product.empty())
        .userSideQuantity;

    return temp(
      context,
      size: sizeX,
      wantBg: wantBg,
      color: color,
      child: productExistsInCart
          ? _buildQuantityRow(
              context, (productQuantity ?? 0), sizeX, color, adjustmentRead)
          : _buildAddToCartButton(context, adjustmentRead),
    );
  }

  static Widget temp(BuildContext context,
      {required double size,
      Color? color,
      required Widget child,
      bool wantBg = false,
      bool isLoading = false}) {
    return Container(
      height: size,
      width: context.sizeOfWidth,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: wantBg ? (color ?? appColors.cS(context).surfaceTint) : null,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
            color: (color ?? appColors.cS(context).surfaceTint), width: 1.2),
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
                    (color ?? appColors.cS(context).onPrimaryFixedVariant)),
                backgroundColor: Colors.transparent,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(BuildContext context, Adjustment adjustment) {
    return InkWell(
      onTap: () {
        adjustment.addItem(productId, packSize);
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

  Widget _buildQuantityRow(BuildContext context, int productQuantity,
      double size, Color? color, Adjustment adjustmentRead) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _quantityButton(
          context,
          icon: Icons.remove,
          size: size,
          color: color,
          wantBg: wantBg,
          onTap: () => _handleRemoveAction(adjustmentRead, productQuantity),
        ),
        Center(
          child: Text(
            '$productQuantity',
            style: wantBg
                ? TextStyles.h8Bold(context)?.copyWith(
                    color: appColors.ms.whiteSwNero(context),
                    fontSize: size * 0.3)
                : TextStyles.h9Bold(context)?.copyWith(
                    color: (color ?? appColors.cS(context).surfaceTint),
                    fontSize: size * 0.32),
          ),
        ),
        _quantityButton(
          context,
          icon: Icons.add,
          size: size,
          color: color,
          wantBg: wantBg,
          onTap: () => adjustmentRead.updateItemQuantity(
              productId, productQuantity + packSize),
        ),
      ],
    );
  }

  void _handleRemoveAction(Adjustment adjustmentRead, int productQuantity) {
    if (productQuantity <= packSize) {
      adjustmentRead.removeItem(productId);
    } else {
      adjustmentRead.updateItemQuantity(productId, productQuantity - packSize);
    }
  }

  static Widget _quantityButton(BuildContext context,
      {required IconData icon,
      required void Function()? onTap,
      double? size,
      Color? color,
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
              : (color ?? appColors.cS(context).primaryFixedDim)
                  .withValues(alpha: 0.2),
        ),
        child: Icon(
          icon,
          size: size * 0.5,
          color: wantBg
              ? appColors.ms.whiteSwNero(context)
              : (color ?? appColors.cS(context).surfaceTint),
        ),
      ),
    );
  }

  /// for Cart Screen
  static Widget cartQuantityBtn(BuildContext context,
      {required int productQuantity,
      required double size,
      Color? color,
      void Function()? onRemoveTap,
      void Function()? onAddTap}) {
    return temp(
      context,
      size: size * 1.9,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '$productQuantity',
              style: TextStyles.h9Bold(context)?.copyWith(
                  color: (color ?? appColors.cS(context).surfaceTint),
                  fontSize: size * 0.43),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _quantityButton(context,
                  icon: Icons.remove,
                  size: size,
                  color: color,
                  onTap: onRemoveTap),
              Flexible(
                child: Container(
                  height: size,
                  color: (color ?? appColors.cS(context).primaryFixedDim)
                      .withValues(alpha: 0.2),
                ),
              ),
              _quantityButton(context,
                  icon: Icons.add, size: size, color: color, onTap: onAddTap),
            ],
          ),
        ],
      ),
    );
  }
}
