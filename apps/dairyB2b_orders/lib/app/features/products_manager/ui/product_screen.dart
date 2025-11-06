import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:common/common.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/product_screen_bottom_bar.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/quick_add_options.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});
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
          height: context.sizeOfHeight * 0.775,
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
            gapH12,
            // Text(product.creationTime.day.toString(), style: TextStyles.h8Bold(context)),
            _ProductImage(imageUrl: product.image),
            _ProductDetails(product: product),
            QuickAddSection(product: product),
            _ProductInformation(product: product),
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
    return ContainerX(
      height: context.sizeOfHeight * 0.34,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: EdgeInsets.zero,
      noBorderAndBg: true,
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
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${product.brand.label} ${product.name}',
              style: TextStyles.h8Bold(context)),
          _ProductUnitDetails(unitDetails: product.unitDetails),
          PriceTag(price: product.price, style: TextStyles.h6Bold(context)),
          BrandProductsButton(brand: product.brand),
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

class BrandProductsButton extends StatelessWidget {
  final Brand brand;

  const BrandProductsButton({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return ButtonX(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
            color: appColors.ms.greyTransparent80(context), width: 1),
      ),
      iconColor: appColors.ms.greyTransparent80(context),
      backgroundColor: appColors.shad.e30(context),
      scale: true,
      label: 'View all ${brand.label} products',
      labelStyle: TextStyles.h11Bold(context),
      labelColor: appColors.ms.black(context),
      icon: Icons.arrow_forward_ios_rounded,
      flex: MainAxisAlignment.spaceBetween,
      onPressed: () => _handleBrandNavigation(context),
    );
  }

  void _handleBrandNavigation(BuildContext context) {
    if (RouteX.getCurrentRoute(context) == AppRoute.brandProducts.path) {
      context.close();
    } else {
      AppRoute.brandProducts.push(context, extra: brand);
    }
  }
}

class _ProductInformation extends StatelessWidget {
  final Product product;

  const _ProductInformation({required this.product});

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: EdgeInsetsGeometry.only(bottom: 4),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SimpleHeading(label: 'Highlights'),
          LabelInfo(label: 'Brand', info: product.brand.label),
          LabelInfo(
            label: 'Weight',
            info: product.unitDetails.displayLabel,
          ),
          LabelInfo(label: 'Product Type', info: product.category.label),
          const SimpleHeading(label: 'Information'),
          LabelInfo(label: 'Short Form', info: product.shortForm),
          LabelInfo(label: 'Search Key', info: product.searchKey.shortKey),
          LabelInfo(label: 'Pack Size', info: product.packSize.toString()),
          LabelInfo(label: 'Created By', info: product.createdBy),
        ],
      ),
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
        child: ProductScreenBottomBar(product: product),
      ),
    );
  }
}
