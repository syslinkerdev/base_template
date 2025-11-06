import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/quick_add_options.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/product_screen_bottom_bar.dart';

class ProductShorterV extends StatelessWidget {
  const ProductShorterV({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ScaffoldX(
      title: product.name,
      wantLeading: true,
      appToolbarHeight: -1,
      body: ProductBody(product: product),
    );
  }

  static Future<void> bottomSheet(BuildContext context, Product product) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ProductBottomSheetContent(product: product),
    );
  }
}

class _ProductBottomSheetContent extends StatelessWidget {
  final Product product;

  const _ProductBottomSheetContent({required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        const Positioned(
          top: -60,
          child: _CloseButton(),
        ),
        Container(
          width: context.sizeOfWidth,
          height: context.sizeOfHeight * 0.475,
          decoration: BoxDecoration(
            color: appColors.ms.whiteSwNero(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ProductBody(product: product),
        ),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        iconColor: WidgetStatePropertyAll(appColors.ms.whiteSwNero(context)),
        backgroundColor: WidgetStatePropertyAll(
          appColors.ms.neroSwWhite(context).withValues(alpha: 0.3),
        ),
      ),
      onPressed: () => context.pop(),
      icon: const Icon(Icons.close_rounded, weight: 10),
    );
  }
}

class ProductBody extends HookConsumerWidget {
  const ProductBody({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        _ProductContent(product: product),
        _BottomActionBar(product: product),
      ],
    );
  }
}

class _ProductContent extends StatelessWidget {
  final Product product;

  const _ProductContent({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductDetails(product: product),
            QuickAddSection(product: product, fromPsv: true),
            const OrderShortSlogan(),
            gapH16,
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;

  const _ProductImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sizeOfHeight * 0.15,
      width: context.sizeOfHeight * 0.15,
      child: FadeInImageX(imagePath: imageUrl, fit: BoxFit.cover),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;

  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: EdgeInsetsGeometry.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductImage(imageUrl: product.image),
          Flexible(
            child: SpacedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${product.brand.label} ${product.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.h8Bold(context)
                        ?.copyWith(overflow: TextOverflow.ellipsis)),
                _ProductUnitDetails(unitDetails: product.unitDetails),
                PriceTag(
                    price: product.price, style: TextStyles.h6Bold(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductUnitDetails extends StatelessWidget {
  final UnitDetail unitDetails;

  const _ProductUnitDetails({required this.unitDetails});

  @override
  Widget build(BuildContext context) {
    return Text(
      unitDetails.displayLabel,
      style: TextStyles.h10Gray(context),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final Product product;

  const _BottomActionBar({required this.product});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Theme.of(context).cardColor,
        height: context.sizeOfHeight * 0.08,
        width: context.sizeOfWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: ProductScreenBottomBar(product: product, fromPsv: true),
      ),
    );
  }
}
