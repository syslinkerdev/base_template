import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/manage_product_provider.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/product_maker_providers.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/product_maker_edit_screen.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/mode_show_widget.dart';
import 'package:repo/repo.dart';

class ProductMakerScreenArgs {
  final ProductMakerMode mode;
  final bool secondSelection;
  const ProductMakerScreenArgs(
      {this.mode = ProductMakerMode.view, this.secondSelection = false});
}

class ProductMakerScreen extends HookConsumerWidget {
  const ProductMakerScreen(
      {super.key,
      this.mode = ProductMakerMode.view,
      this.secondSelection = false});
  final ProductMakerMode mode;
  final bool secondSelection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorX = appColors.cS(context).onPrimaryFixedVariant;
    final productMaker = ref.watch(ProductMakerXProvider(mode: mode));
    final manageProduct = ref.watch(manageProductProvider);
    final mPro = manageProduct.asData?.value;
    if (mPro == null) {
      return const Center(child: Text('null  -- empty list - Ghost'));
    }
    print('pro maker screen cate : ${mPro.product?.category}');
    // 👇 DynamicList controllers
    final brandController = DynamicListController<Brand>(
        initialValue: nullIfEmpty<Brand>(mPro.product?.brand));
    final categoryController = DynamicListController<Category>(
        initialValue: nullIfEmpty<Category>(mPro.product?.category));
    final unitController = DynamicListController<UnitDetail>(
        initialValue: nullIfEmpty<UnitDetail>(mPro.product?.unitDetails));
    final packagingController = DynamicListController<PackagingType>();
    final productTypeController = DynamicListController<ProductType>(
        initialValue: nullIfEmpty<ProductType>(mPro.product?.productType));
    print('categoryController -- ${categoryController.value.toString()}');
    return WillPopScope(
      onWillPop: () async {
        if (secondSelection) {
          return false;
        }
        final canExit = await onExit(
            context, productMaker.value ?? ProductMakerState.empty());
        if (canExit) {
          return true;
        } else {
          return false;
        }
      },
      child: ScaffoldX(
        wantLeading: secondSelection ? false : true,
        title: 'Product Maker',
        leadingOnPressed: () async {
          final canExit = await onExit(
              context, productMaker.value ?? ProductMakerState.empty());
          if (canExit) {
            context.close();
          } else {
            return;
          }
        },
        appBarActions: [
          productMaker.maybeWhen(
            orElse: () => SizedBox.shrink(),
            data: (maker) {
              return ModeShowWidget(
                  label: maker.mode.name, color: maker.mode.color);
            },
          ),
          gapW16,
        ],
        body: productMaker.when(
          data: (makerX) {
            if (makerX.maker!.isEmpty) {
              return const Center(child: Text('null  -- empty list - Ghost'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SpacedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                defaultHeight: 12,
                children: [
                  HeadingLineFade(label: 'BRANDS'),
                  DynamicList<Brand>(
                    controller: brandController,
                    isGridView: true,
                    items: makerX.mode == ProductMakerMode.edit
                        ? [...makerX.maker!.brands, Brand.empty()]
                        : makerX.maker!.brands,
                    gridCrossAxisCount: 4,
                    itemBuilder: (context, item, isSelected) {
                      if (item.isEmpty)
                        return AddButton(isSelected: isSelected);
                      return ItemCard(
                        borderColor: isSelected ? colorX : null,
                        borderWidth: isSelected ? 2 : null,
                        item: item,
                        getImage: (b) => b.image ?? '',
                        getLabel: (b) => b.label,
                        imgHeight: 40,
                        imgWidth: 40,
                        labelStyle: TextStyles.h13Bold(context),
                      );
                    },
                    onSelect: (item) {
                      if (makerX.mode == ProductMakerMode.edit) {
                        ProductMakerEditScreen.bottomSheet<Brand>(context, item)
                            .then(
                          (_) => brandController.clear(),
                        );
                      } else {
                        return;
                      }
                    },
                  ),
                  HeadingLineFade(label: 'CATEGORIES'),
                  DynamicList<Category>(
                    controller: categoryController,
                    isGridView: true,
                    items: makerX.mode == ProductMakerMode.edit
                        ? [...makerX.maker!.categories, Category.empty()]
                        : makerX.maker!.categories,
                    gridCrossAxisCount: 4,
                    itemBuilder: (context, item, isSelected) {
                      print('isSelected $isSelected');
                      if (item.isEmpty)
                        return AddButton(isSelected: isSelected);
                      return ItemCard(
                        borderColor: isSelected ? colorX : null,
                        borderWidth: isSelected ? 2 : null,
                        item: item,
                        getImage: (b) => b.image ?? '',
                        getLabel: (b) => b.label,
                        imgHeight: 40,
                        imgWidth: 40,
                        labelStyle: TextStyles.h13Bold(context),
                      );
                    },
                    onSelect: (item) {
                      if (makerX.mode == ProductMakerMode.edit) {
                        ProductMakerEditScreen.bottomSheet<Category>(
                                context, item)
                            .then((_) => categoryController.clear());
                      } else {
                        return;
                      }
                    },
                  ),
                  HeadingLineFade(label: 'UNITS'),
                  DynamicList<UnitDetail>(
                    controller: unitController,
                    isGridView: true,
                    items: makerX.mode == ProductMakerMode.edit
                        ? [...makerX.maker!.units, UnitDetail.empty()]
                        : makerX.maker!.units,
                    gridCrossAxisCount: 4,
                    itemBuilder: (context, item, isSelected) {
                      if (item.isEmpty)
                        return AddButton(isSelected: isSelected);
                      return ItemCard(
                        borderColor: isSelected ? colorX : null,
                        borderWidth: isSelected ? 2 : null,
                        item: item,
                        getTextInPlaceOfImage: (b) =>
                            b.unitShortForm.toUpperCase(),
                        getLabel: (b) => b.unitFullForm,
                        imgHeight: 40,
                        imgWidth: 40,
                        labelStyle:
                            TextStyles.h15Bold(context)?.copyWith(fontSize: 9),
                      );
                    },
                    onSelect: (item) {
                      if (makerX.mode == ProductMakerMode.edit) {
                        ProductMakerEditScreen.bottomSheet<UnitDetail>(
                                context, item)
                            .then(
                          (_) => unitController.clear(),
                        );
                      } else {
                        return;
                      }
                    },
                  ),
                  HeadingLineFade(label: 'PRODUCT TYPES'),
                  DynamicList<ProductType>(
                    controller: productTypeController,
                    isGridView: true,
                    items: makerX.mode == ProductMakerMode.edit
                        ? [...makerX.maker!.productTypes, ProductType.empty()]
                        : makerX.maker!.productTypes,
                    gridCrossAxisCount: 4,
                    itemBuilder: (context, item, isSelected) {
                      if (item.isEmpty)
                        return AddButton(isSelected: isSelected);
                      return ItemCard(
                        borderColor: isSelected ? colorX : null,
                        borderWidth: isSelected ? 2 : null,
                        item: item,
                        getTextInPlaceOfImage: (b) => b.shortForm.toUpperCase(),
                        getLabel: (b) => b.fullForm,
                        imgHeight: 40,
                        imgWidth: 40,
                        labelStyle: TextStyles.h13Bold(context),
                      );
                    },
                    onSelect: (item) {
                      if (makerX.mode == ProductMakerMode.edit) {
                        ProductMakerEditScreen.bottomSheet<ProductType>(
                                context, item)
                            .then((_) => productTypeController.clear());
                      }
                    },
                  ),
                  HeadingLineFade(label: 'PACKAGING TYPES'),
                  DynamicList<PackagingType>(
                    controller: packagingController,
                    initialSelectedItem: findBasePackagingFromQuickAddList(
                        quickAddOptions: mPro.product?.quickAddOptions ?? [],
                        allBasePackagingList:
                            makerX.maker?.packagingTypes ?? []),
                    isGridView: true,
                    items: makerX.mode == ProductMakerMode.edit
                        ? [
                            ...makerX.maker!.packagingTypes,
                            PackagingType.empty()
                          ]
                        : makerX.maker!.packagingTypes,
                    gridCrossAxisCount: 4,
                    itemBuilder: (context, item, isSelected) {
                      if (item.isEmpty)
                        return AddButton(isSelected: isSelected);
                      return ItemCard(
                        borderColor: isSelected ? colorX : null,
                        borderWidth: isSelected ? 2 : null,
                        item: item,
                        getTextInPlaceOfImage: (b) => b.quantity.toString(),
                        getLabel: (b) => b.label,
                        imgHeight: 40,
                        imgWidth: 40,
                        labelStyle: TextStyles.h13Bold(context),
                      );
                    },
                    onSelect: (item) {
                      if (makerX.mode == ProductMakerMode.edit) {
                        ProductMakerEditScreen.bottomSheet<PackagingType>(
                                context, item)
                            .then(
                          (_) => packagingController.clear(),
                        );
                      } else {
                        return;
                      }
                    },
                  ),
                  ManagementSloganFooter(),
                ],
              ),
            );
          },
          error: (e, _) =>
              ErrorScreen(error: e, onRetry: () => refresh(ref, mode)),
          loading: () => _buildShimmerLoading(context),
        ),
        stopBottomBarHideScroll: true,
        bottomNavigationBar: productMaker.maybeWhen(
          orElse: () => null,
          data: (maker) {
            if (maker.mode == ProductMakerMode.view) {
              return ButtonX.primaryButton(
                context: context,
                label: 'Continue',
                icon: Icons.arrow_forward_ios_rounded,
                iconFirst: false,
                flex: MainAxisAlignment.spaceBetween,
                onPressed: () async {
                  try {
                    await ref
                        .watch(manageProductProvider.notifier)
                        .updateOptions(
                          brand: brandController.value,
                          category: categoryController.value,
                          unitDetail: unitController.value,
                          packaging: packagingController.value,
                          productType: productTypeController.value,
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
                  AppRoute.manageProduct.go(context);
                },
              );
            } else if (maker.isEdited == true) {
              return ButtonX.primaryButton(
                context: context,
                label: 'Publish',
                icon: Icons.rocket_launch,
                iconFirst: false,
                onPressed: () async {
                  try {
                    await ref
                        .read(ProductMakerXProvider(mode: mode).notifier)
                        .publish();
                    // Optional: Reset the provider if needed
                    ref.invalidate(ProductMakerXProvider(mode: mode));
                    ref.invalidate(fetchProductMakerProvider);
                    context.close();
                  } catch (e, _) {
                    final message = e.toString();
                    showMessageSnackbar(
                        context: context,
                        message: message,
                        maxLines: 2,
                        type: SnackBarType.error);
                  }
                },
              );
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliers = [0.06, 0.2, 0.06, 0.2, 0.06, 0.2, 0.06, 0.2];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SpacedColumn(
        children: List.generate(heightMultipliers.length, (i) {
          return ShimmerX(
            width: context.sizeOfWidth,
            height: context.sizeOfHeight * heightMultipliers[i],
          );
        }),
      ),
    );
  }

  static Future<void> refresh(WidgetRef ref, ProductMakerMode mode) async =>
      ref.refresh(ProductMakerXProvider(mode: mode).future);

  Future<bool> onExit(
      BuildContext context, ProductMakerState productMaker) async {
    if (productMaker.isNotNull &&
        productMaker.isEdited == true &&
        productMaker.mode == ProductMakerMode.edit) {
      final canExit = await DialogsX.askForConfirmation<bool>(
        context,
        title: 'Discard Changes?',
        content:
            "You have unsaved changes. Are you sure you want to leave this screen?",
        cancelBtnText: 'Cancel',
        confirmBtnText: 'Yes, Exit',
      );
      if (canExit == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key, this.isSelected = false});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final colorX = appColors.cS(context).onPrimaryFixedVariant;
    return ContainerX(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        borderColor: isSelected ? colorX : null,
        borderWidth: isSelected ? 2 : null,
        child: Icon(Icons.add_rounded, size: 50, color: colorX));
  }
}
