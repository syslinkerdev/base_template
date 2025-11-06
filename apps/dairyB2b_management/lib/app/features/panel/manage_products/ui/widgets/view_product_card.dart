import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/manage_product_provider.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/more_options_button.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/product_status_widget.dart';

class ViewProductCard extends StatelessWidget {
  const ViewProductCard(
      {super.key,
      required this.productWithDiscount,
      required this.ref,
      required this.mode});
  final ProductWithDiscount productWithDiscount;
  final ProductsViewMode mode;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final product = productWithDiscount.product;
    final discount = productWithDiscount.discount;
    if (mode == ProductsViewMode.view) {
      return ViewModeCard(product: product, discount: discount, ref: ref);
    } else {
      return EditModeCard(product: product, discount: discount, ref: ref);
    }
  }
}

class ViewModeCard extends StatelessWidget {
  const ViewModeCard(
      {super.key, required this.product, required this.ref, this.discount});
  final Product product;
  final Discount? discount;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: SpacedColumn(
        defaultHeight: 2,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === Top Row: Image + Name + Brand ===
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FadeInImageX(imagePath: product.image),
              ),
              gapW12,
              Expanded(
                child: SpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  defaultHeight: 2,
                  children: [
                    Text(
                      '${product.name} (${product.shortForm})',
                      style: TextStyles.h8Bold(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${product.brand.label} | ${product.category.label} | ${product.unitDetails.displayLabel}',
                      style: TextStyles.h12Gray(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ProductStatusWidget(productStatus: product.status)
                  ],
                ),
              ),
              MoreOptionsButton<MoreOptionsItem>(
                onSelected: (value) async {
                  await ref.watch(manageProductProvider.notifier).proUpdate(
                        product: product,
                        discount: discount,
                        mode: value == 'view'
                            ? ManageProductMode.view
                            : ManageProductMode.edit,
                      );
                  if (value == 'view') {
                    AppRoute.viewProductDetails.push(context);
                  } else if (value == 'edit') {
                    AppRoute.manageProduct.go(context);
                  } else {
                    return;
                  }
                  //  else if (value == 'delete') {
                  //   // handle delete
                  // }
                },
                items: [
                  MoreOptionsItem(
                      value: 'edit', label: 'Edit', icon: Icons.edit),
                  MoreOptionsItem(
                      value: 'view', label: 'View', icon: Icons.remove_red_eye),
                  // MoreOptionsItem(
                  //     value: 'delete', label: 'Delete', icon: Icons.delete),
                ],
                labelBuilder: (p0) => p0.label,
                iconBuilder: (p0) => p0.icon,
              ),
            ],
          ),
          const SimpleDivider(),
          // === Details Row ===
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 6,
                runSpacing: 2,
                children: [
                  InfoChip(
                      label: 'Price',
                      value: '₹${PriceTag.formatPrice(product.price)}',
                      isPrice: true),
                  InfoChip(label: 'Pack Size', value: '${product.packSize}'),
                  if (discount != null &&
                      discount?.status != ProductStatus.deleted)
                    InfoChip(
                        label: 'Global Dis', value: '${discount?.discount}'),
                ],
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 16, color: appColors.sc.grey500),
            ],
          ),
        ],
      ),
    );
  }
}

class EditModeCard extends StatelessWidget {
  const EditModeCard(
      {super.key, required this.product, required this.ref, this.discount});
  final Product product;
  final Discount? discount;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 45,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: FadeInImageX(imagePath: product.image),
          ),
          gapW12,
          Expanded(
            child: Text(
              '${product.searchKey}',
              style: TextStyles.h7Bold(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded,
              size: 25, color: appColors.sc.grey500),
        ],
      ),
    );
  }
}
