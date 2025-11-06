import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/products_screen.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';

class BrandsCategoriesWidget extends ConsumerWidget {
  const BrandsCategoriesWidget({
    super.key,
    required this.productMaker,
  });
  final ProductMaker productMaker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        HeadingLineFade(label: 'SHOP BY BRANDS'),
        SizedBox(
          height: 103,
          child: DynamicList<Brand>(
            items: productMaker.brands,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, item, isSelected) => ItemCard(
                item: item,
                getImage: (b) => b.image ?? '',
                getLabel: (b) => b.label,
                width: context.sizeOfWidth * 0.26,
                imgHeight: 50,
                imgWidth: 50),
            onSelect: (item) => AppRoute.products
                .push(context, extra: ProductsScreenArgs(initBrand: item.id)),
          ),
        ),
        HeadingLineFade(label: 'SHOP BY CATEGORIES'),
        DynamicList<Category>(
          isGridView: true,
          items: productMaker.categories,
          itemBuilder: (context, item, isSelected) => ItemCard(
              item: item,
              getImage: (b) => b.image ?? '',
              getLabel: (b) => b.label),
          onSelect: (item) => AppRoute.products
              .push(context, extra: ProductsScreenArgs(initCategory: item.id)),
        ),
      ],
    );
  }
}
