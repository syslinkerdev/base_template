import 'dart:async';

import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/common/widgets/discount_show.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/view_products.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/quick_edit_screen.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/product_status_widget.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/manage_product_provider.dart';

class ViewProductDetails extends HookConsumerWidget {
  const ViewProductDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manageProduct = ref.watch(manageProductProvider);

    return ScaffoldX(
      wantLeading: true,
      title: 'Product',
      appBarActions: [
        manageProduct.maybeWhen(
          orElse: () => SizedBox.shrink(),
          data: (mPro) {
            if (mPro.product == null) {
              return SizedBox.shrink();
            } else {
              return ProductStatusWidget(
                  productStatus: mPro.product?.status ?? ProductStatus.draft);
            }
          },
        ),
        gapW16
      ],
      body: SingleChildScrollView(
          child: manageProduct.when(
        data: (mPro) {
          final product = mPro.product;
          final discount = mPro.discount;
          if (product != null && product.isNotEmpty) {
            return SpacedColumn(
              defaultHeight: 0,
              crossAxisAlignment: CrossAxisAlignment.start,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                ProductCoreDetails(product: product),
                ProductMetaData(product: product),
                if (discount != null &&
                    discount.isNotEmpty &&
                    discount.status != ProductStatus.deleted)
                  GlobalDiscount(gDiscount: discount),
                ProductActions(product: product, discount: discount),
              ],
            );
          } else {
            return Center(child: Text('Ghost'));
          }
        },
        error: (e, _) => ErrorScreen(error: e, onRetry: () {}),
        loading: () => LoadingScreen(),
      )),
    );
  }
}

class ProductCoreDetails extends StatelessWidget {
  const ProductCoreDetails({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductDetails(product: product),
          MetaRow(label: 'Brand', value: '${product.brand.label}'),
          MetaRow(label: 'Category', value: '${product.category.label}'),
          MetaRow(
              label: 'Type',
              value:
                  '${product.productType.fullForm} (${product.productType.shortForm})'),
          MetaRow(
              label: 'Status',
              value: '${productStatusToFilter(product.status).label}'),
          MetaRow(label: 'Search Key', value: product.searchKey),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SpacedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quick Add Options (${product.quickAddOptions.length}) :',
                    style: TextStyles.h12Bold(context)),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: product.quickAddOptions.map(
                    (e) {
                      return ContainerX(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          margin: EdgeInsetsGeometry.zero,
                          width: -1,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${e.label} = ${e.quantity}',
                                  style: TextStyles.h12(context)),
                            ],
                          ));
                    },
                  ).toList(),
                ),
                Text(
                    '${product.quickAddOptions.first.label} equal to ${product.quickAddOptions.first.quantity}',
                    style: TextStyles.h12Bold(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;

  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ProductImage(imageUrl: product.image),
        gapW8,
        Flexible(
          child: SpacedColumn(
            defaultHeight: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoChip(context, 'Name', product.name),
              _infoChip(context, 'Short Form', product.shortForm),
              _infoChip(context, 'Unit', product.unitDetails.displayLabel),
              _infoChip(context, 'Pack Size', product.packSize.toString()),
              _infoChip(
                  context, 'Price', '₹${PriceTag.formatPrice(product.price)}',
                  isPrice: true),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _infoChip(BuildContext context, String label, String value,
    {bool isPrice = false}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('${label} : ', style: TextStyles.h12Bold(context)),
      Flexible(
        child: Text(
          value,
          style: TextStyles.h12Bold(context)?.copyWith(
              fontFamily: isPrice ? 'Roboto' : null,
              fontWeight: FontWeight.w500,
              color: appColors.ms.textBlack50(context)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;

  const _ProductImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 130,
      child: InkWell(
        onTap: () => previewDialog.fullImage(
            context: context,
            imagePath: imageUrl,
            sourceType: ImageSourceType.network),
        child: Stack(
          fit: StackFit.expand,
          children: [
            FadeInImageX(imagePath: imageUrl, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    maxRadius: 14,
                    backgroundColor: appColors.ms
                        .whiteSwNero(context)
                        .withValues(alpha: 0.7),
                    child: Icon(Icons.remove_red_eye_outlined,
                        size: 18, color: appColors.ms.neroSwWhite(context)),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'Product Metadata',
            icon: Icons.fingerprint,
            color: appColors.sc.nobel,
          ),
          // Product ID with copy action
          MetaRow(
            onTap: () =>
                Clipboard.setData(ClipboardData(text: product.id)).then(
              (_) {
                if (context.mounted) {
                  showMessageSnackbar(
                    context: context,
                    message: 'Product ID copied to clipboard',
                    maxLines: 2,
                  );
                }
              },
            ),
            label: 'Product ID',
            value: product.id,
            trailing: const Icon(Icons.copy, size: 18),
          ),

          // Created At
          MetaRow(
            label: 'Created At',
            value:
                '${DFU.moreFriendlyFormat(product.createdAt)}, ${DFU.timeOnly12h(product.createdAt)}',
          ),

          // Created By
          MetaRow(
            label: 'Created By',
            value: product.createdBy.isNotEmpty ? product.createdBy : '—',
          ),

          // Updated At
          MetaRow(
            label: 'Last Updated',
            value: product.updatedAt != null
                ? '${DFU.moreFriendlyFormat(product.updatedAt!)}, ${DFU.timeOnly12h(product.updatedAt!)}'
                : '—',
          ),

          // Updated By
          MetaRow(
            label: 'Updated By',
            value: product.updatedBy?.isNotEmpty == true
                ? product.updatedBy!
                : '—',
          ),
        ],
      ),
    );
  }
}

class ProductActions extends ConsumerWidget {
  const ProductActions({
    super.key,
    required this.product,
    required this.discount,
  });
  final Product product;
  final Discount? discount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'Actions',
            icon: Icons.settings,
            color: appColors.cS(context).surfaceTint,
          ),
          gapH2,
          Center(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _actionBtn(context, Icons.edit, 'Edit', () async {
                  await ref.watch(manageProductProvider.notifier).proUpdate(
                      product: product,
                      discount: discount,
                      mode: ManageProductMode.edit);
                  AppRoute.manageProduct.go(context);
                }),
                _actionBtn(context, Icons.delete, 'Delete', () async {
                  final confirm = await DialogsX.askForConfirmation(
                    context,
                    title: 'Delete',
                    content:
                        'Are you sure you want to delete this product (${product.shortForm})?',
                    dialogTheme: appColors.sc.rejected,
                    cancelBtnText: 'No',
                    confirmBtnText: 'Yes',
                  );

                  if (confirm == true) {
                    final manager = ref.watch(manageProductProvider.notifier);
                    await manager.deleteProAndDis().then(
                      (value) {
                        if (value == null) {
                          showMessageSnackbar(
                            context: context,
                            message: 'Product ${product.searchKey} is deleted',
                            duration: Duration(seconds: 2),
                            maxLines: 2,
                            type: SnackBarType.success,
                          );
                          AppRoute.panel.go(context);
                        } else {
                          print('error : $value');
                          showMessageSnackbar(
                              context: context,
                              message: value,
                              maxLines: 2,
                              type: SnackBarType.error);
                        }
                      },
                    );
                  }
                }),
                _actionBtn(context, Icons.upgrade, 'Quick Edit', () async {
                  await ref.watch(manageProductProvider.notifier).proUpdate(
                        product: product,
                        discount: discount,
                        mode: ManageProductMode.edit,
                      );
                  var proStatus = await QuickEditScreen.bottomSheet(context);
                  if (proStatus != null) {
                    AppRoute.viewProducts.go(context,
                        extra: ViewProductsArgs(
                            initialBrand: product.brand,
                            initialCategory: product.category,
                            initialStatus: proStatus));
                    showMessageSnackbar(
                      context: context,
                      message: 'Product ${product.searchKey} is updated',
                      duration: Duration(seconds: 2),
                      maxLines: 2,
                      type: SnackBarType.success,
                    );
                  } else {
                    return;
                  }
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _actionBtn(BuildContext context, IconData icon, String label,
    FutureOr<void> Function()? onPressed) {
  return SizedBox(
    width: context.sizeOfWidth / 2.5,
    child: ButtonX.primaryButton(
      context: context,
      icon: icon,
      label: label,
      labelStyle: TextStyles.h8Bold(context),
      iconSize: 20,
      onPressed: onPressed,
    ),
  );
}

class GlobalDiscount extends StatelessWidget {
  const GlobalDiscount({
    super.key,
    required this.gDiscount,
  });

  final Discount gDiscount;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async => await DiscountShow.dialog(context, gDiscount),
            child: ColorBgIconHeader(
              label: 'Global Discount',
              icon: Icons.discount,
              color: Colors.green.shade700,
              trailing: Icon(Icons.zoom_out_map, size: 21),
            ),
          ),
          gapH2,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discount', style: TextStyles.h9Bold(context)),
              Text('₹${PriceTag.formatPrice(gDiscount.discount)}',
                  style: TextStyles.h10Bold(context)
                      ?.copyWith(fontFamily: 'Roboto')),
            ],
          ),
        ],
      ),
    );
  }
}
