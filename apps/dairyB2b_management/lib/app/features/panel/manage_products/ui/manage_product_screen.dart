import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/product_maker_screen.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/view_products.dart';
import 'package:dairyB2b_management/app/features/panel/common/widgets/global_dis_slider.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/drop_down_x.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/mode_show_widget.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/product_maker_providers.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/manage_product_provider.dart';

class ManageProductScreen extends HookConsumerWidget {
  const ManageProductScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // debugPrint('💥 Rebuilding widget ManageProductScreen');

    final productManager = ref.watch(manageProductProvider);

    final nameCtrl = useTextEditingController();
    final priceCtrl = useTextEditingController();
    final unitQtyCtrl = useTextEditingController();
    final packSizeCtrl = useTextEditingController();
    final shortFormCtrl = useTextEditingController();
    final searchKeyCtrl = useTextEditingController();

    return ScaffoldX(
      wantLeading: true,
      title: 'Manage Product',
      appBarActions: [
        productManager.maybeWhen(
          orElse: () => SizedBox.shrink(),
          data: (maker) =>
              ModeShowWidget(label: maker.mode.name, color: maker.mode.color),
        ),
        gapW16
      ],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: productManager.when(
          data: (productData) {
            final product = productData.product;
            final discount = productData.discount;
            useEffect(() {
              if (product != null) {
                // print('cate : ${product.category.toString()}');
                nameCtrl.text = product.name;
                priceCtrl.text = formatDouble(product.price);
                packSizeCtrl.text = product.packSize.toString();
                unitQtyCtrl.text = formatDouble(product.unitDetails.value);
                shortFormCtrl.text = product.shortForm;
                searchKeyCtrl.text = product.searchKey;
              }
              if (discount != null) {
                // globDis.value = discount.discount;
              }
              return null;
            }, [productData]);

            return SpacedColumn(
              defaultHeight: 0,
              crossAxisAlignment: CrossAxisAlignment.start,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                AppTextField(
                  controller: nameCtrl,
                  title: 'Name',
                  hintText: 'e.g. Toned Milk',
                  isMandatory: true,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  onChanged: (newName) => ref
                      .read(manageProductProvider.notifier)
                      .updateFields(name: newName),
                ),
                AppTextField(
                  controller: priceCtrl,
                  title: (product?.price ?? 0) == 0
                      ? 'Price'
                      : 'Price ${PriceTag.formatPrice(product!.price)}',
                  hintText: 'e.g. 60',
                  suffixIcon: SufFixHolder(children: [
                    Icon(Icons.currency_rupee,
                        size: TextStyles.h7Gray(context)?.fontSize,
                        color: appColors.ms.textBlack50(context)),
                    gapW12
                  ]),
                  isMandatory: true,
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onChanged: (newPrice) {
                    final parsed = double.tryParse(newPrice);
                    ref
                        .read(manageProductProvider.notifier)
                        .updateFields(price: parsed ?? 0);
                  },
                ),
                AppTextField(
                  controller: unitQtyCtrl,
                  title: 'Unit Quantity',
                  hintText: 'e.g. 500',
                  suffixIcon: SufFixHolder(children: [
                    Text(
                      product?.unitDetails.unitShortForm ?? '',
                      style: TextStyles.h7Gray(context),
                    ),
                    gapW12
                  ]),
                  isMandatory: true,
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onChanged: (newUnitQty) {
                    final parsed = double.tryParse(newUnitQty);
                    ref.read(manageProductProvider.notifier).updateFields(
                          unitQty: parsed ?? 0,
                        );
                  },
                ),
                AppTextField(
                  controller: packSizeCtrl,
                  title: 'Pack Size',
                  hintText: 'e.g. 2',
                  isMandatory: true,
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onChanged: (newPackSize) {
                    final parsed = int.tryParse(newPackSize);
                    ref
                        .read(manageProductProvider.notifier)
                        .updateFields(packSize: parsed ?? 0);
                  },
                ),
                GlobalDisSlider(
                    disValue: discount?.discount,
                    onChanged: (newDiscount) => ref
                        .read(manageProductProvider.notifier)
                        .updateFields(discountValue: newDiscount)),
                DropDownX<ProductStatusFilter>(
                    title: 'Status',
                    hintText: 'Choose a product status',
                    isMandatory: true,
                    items: productStatusFilters,
                    value: productStatusToFilter(
                        product?.status ?? ProductStatus.draft),
                    itemLabel: (r) => r.label,
                    onChanged: (newStatus) => ref
                        .read(manageProductProvider.notifier)
                        .updateFields(
                            status: newStatus?.value ?? ProductStatus.draft)),
                ImageField(
                  title: 'Product Image',
                  image: product?.image ?? '',
                  onChange: (image) => ref
                      .read(manageProductProvider.notifier)
                      .updateFields(image: image),
                ),
                // Read-only auto-filled fields
                AppTextField(
                  controller: shortFormCtrl,
                  title: 'Short Form (auto)',
                  readOnly: true,
                  initialValue: product?.shortForm ?? '',
                ),
                AppTextField(
                  controller: searchKeyCtrl,
                  title: 'Search Key (auto)',
                  readOnly: true,
                  initialValue: product?.searchKey ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: InkWell(
                    onTap: () async {
                      if (product?.unitDetails.value != 0.0) {
                        ref
                            .read(manageProductProvider.notifier)
                            .updateFields(unitQty: 0.0);
                      }
                      AppRoute.productMaker.go(context,
                          extra: ProductMakerScreenArgs(
                              mode: ProductMakerMode.view,
                              secondSelection: true));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CaptionText(
                            title: 'Selected Product Details',
                            isRequired: false),
                        Icon(Icons.edit_square,
                            color: appColors.cS(context).surfaceTint)
                      ],
                    ),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1,
                  children: [
                    ItemCard<Brand>(
                      item: product?.brand ?? Brand.empty(),
                      getImage: (b) => b.image ?? '',
                      getLabel: (b) => b.label,
                      imgHeight: 40,
                      imgWidth: 40,
                      labelStyle: TextStyles.h13Bold(context),
                    ),
                    ItemCard<Category>(
                      item: product?.category ?? Category.empty(),
                      getImage: (b) => b.image ?? '',
                      getLabel: (b) => b.label,
                      imgHeight: 40,
                      imgWidth: 40,
                      labelStyle: TextStyles.h13Bold(context),
                    ),
                    ItemCard<UnitDetail>(
                      item: product?.unitDetails ?? UnitDetail.empty(),
                      getTextInPlaceOfImage: (b) =>
                          b.unitShortForm.toUpperCase(),
                      getLabel: (b) => b.unitFullForm,
                      imgHeight: 40,
                      imgWidth: 40,
                      labelStyle: TextStyles.h15Bold(context),
                    ),
                    ItemCard<PackagingType>(
                      item: (product?.quickAddOptions.isNotEmpty ?? false)
                          ? product!.quickAddOptions.first
                          : PackagingType.empty(),
                      getTextInPlaceOfImage: (b) => b.quantity.toString(),
                      getLabel: (b) =>
                          b.label.replaceFirst(RegExp(r'^\d+'), '').trim(),
                      imgHeight: 40,
                      imgWidth: 40,
                      labelStyle: TextStyles.h15Bold(context),
                    ),
                    ItemCard<ProductType>(
                      item: product?.productType ?? ProductType.empty(),
                      getTextInPlaceOfImage: (b) => b.shortForm.toUpperCase(),
                      getLabel: (b) => b.fullForm,
                      imgHeight: 40,
                      imgWidth: 40,
                      labelStyle: TextStyles.h15Bold(context),
                    ),
                  ],
                ),
                CaptionText(
                    title: 'Selected Quick Add Options', isRequired: false),
                DynamicList<PackagingType>(
                  isGridView: true,
                  items: product?.quickAddOptions ?? [],
                  gridCrossAxisCount: 4,
                  spacing: 6,
                  itemBuilder: (context, item, isSelected) {
                    return ItemCard(
                      item: item,
                      getTextInPlaceOfImage: (b) => b.quantity.toString(),
                      getLabel: (b) => b.label,
                      imgHeight: 40,
                      imgWidth: 40,
                      labelStyle: TextStyles.h15Bold(context),
                    );
                  },
                  onSelect: (PackagingType item) {},
                ),
                ManagementShortSlogan(),
              ],
            );
          },
          error: (e, _) => ErrorScreen(error: e, onRetry: () {}),
          loading: () => LoadingScreen(),
        ),
      ),
      bottomNavigationBar: productManager.maybeWhen(
        orElse: () => null,
        data: (productData) {
          return ButtonX.primaryButton(
            context: context,
            label: productData.mode == ManageProductMode.edit
                ? 'Update'
                : 'Publish',
            icon: Icons.rocket_launch,
            iconFirst: false,
            onPressed: () async {
              try {
                await ref.watch(manageProductProvider.notifier).publish().then(
                  (_) async {
                    final product = productData.product;
                    AppRoute.viewProducts.go(context,
                        extra: ViewProductsArgs(
                            initialBrand: product?.brand,
                            initialCategory: product?.category,
                            initialStatus: product?.status));
                    await ref.read(manageProductProvider.notifier).clear();
                    showMessageSnackbar(
                      context: context,
                      message: 'Product ${productData.mode.name} successfully',
                      type: SnackBarType.success,
                    );
                  },
                );
              } catch (e, _) {
                final message = e.toString();
                showMessageSnackbar(
                    context: context,
                    message: message,
                    maxLines: 2,
                    type: SnackBarType.error);
                return;
              }
            },
          );
        },
      ),
    );
  }
}
