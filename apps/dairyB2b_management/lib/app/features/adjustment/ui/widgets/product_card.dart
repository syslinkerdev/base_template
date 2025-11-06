import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/add_to_cart_btn.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/product_shorter_v.dart';

class ProductCard extends HookConsumerWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => ProductShorterV.bottomSheet(context, product),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        defaultHeight: 0,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // image
              ContainerX(
                height: context.sizeOfHeight * 0.15,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.zero,
                child:
                    FadeInImageX(imagePath: product.image, fit: BoxFit.contain),
              ),
              // unit and category
              gapH4,
              Row(
                children: [
                  batches(context, label: product.unitDetails.displayLabel),
                  gapW4,
                  batches(context, label: product.category.label)
                ],
              ),
              // Name
              Text(
                  '${product.brand.label} ${product.name} (${product.shortForm})',
                  style: TextStyles.h11Bold(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
              // Price
              PriceTag(
                price: product.price,
                style: TextStyles.h9Bold(context),
              )
            ],
          ),
          // add to cart btn
          AddToCartBtn(productId: product.id, packSize: product.packSize),
        ],
      ),
    );
  }

  Container batches(BuildContext context, {required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1.8),
      decoration: BoxDecoration(
        color: appColors.ms.greyTransparent40(context),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyles.h15Bold(context)
            ?.copyWith(fontSize: 9, color: appColors.cS(context).surfaceTint),
      ),
    );
  }
}
