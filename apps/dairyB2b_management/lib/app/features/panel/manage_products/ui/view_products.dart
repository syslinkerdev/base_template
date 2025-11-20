import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/filter_dropdown.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/view_product_card.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/manage_product_provider.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/filter_products_stream.dart';

class ViewProductsArgs {
  final Brand? initialBrand;
  final Category? initialCategory;
  final ProductStatus? initialStatus;
  final UpdatedWithin? initialUpdatedWithin;
  final ProductsViewMode mode;

  ViewProductsArgs(
      {this.initialBrand,
      this.initialCategory,
      this.initialStatus,
      this.initialUpdatedWithin,
      this.mode = ProductsViewMode.view});
}

class ViewProducts extends HookConsumerWidget {
  final Brand? initialBrand;
  final Category? initialCategory;
  final ProductStatus? initialStatus;
  final UpdatedWithin? initialUpdatedWithin;
  final ProductsViewMode mode;

  const ViewProducts(
      {super.key,
      this.initialBrand,
      this.initialCategory,
      this.initialStatus,
      this.initialUpdatedWithin,
      required this.mode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wholeProducts = ref.watch(productsStreamXProvider);

    final productMaker = ref.watch(fetchProductMakerProvider);

    final selectedBrand = useState<Brand?>(initialBrand);
    final selectedCategory = useState<Category?>(initialCategory);
    final selectedUpdatedWithin = useState<UpdatedWithinFilter>(
      updatedWithinToFilter(initialUpdatedWithin ?? UpdatedWithin.anytime),
    );
    final selectedProductStatus = useState<ProductStatusFilter>(
      productStatusToFilter(initialStatus ?? ProductStatus.activePublic),
    );
    void _initDefaults(ProductMaker maker) {
      if (selectedBrand.value == null && maker.brands.isNotEmpty) {
        selectedBrand.value = maker.brands.first;
      }
      if (selectedCategory.value == null && maker.categories.isNotEmpty) {
        selectedCategory.value = maker.categories.first;
      }
    }

    useEffect(() {
      productMaker.whenData((maker) {
        if (maker != null) _initDefaults(maker);
      });
      return null;
    }, [productMaker]);

    // Sync state with incoming initial props
    useEffect(() {
      if (initialBrand != null && initialBrand != selectedBrand.value) {
        selectedBrand.value = initialBrand;
      }
      if (initialCategory != null &&
          initialCategory != selectedCategory.value) {
        selectedCategory.value = initialCategory;
      }
      if (initialUpdatedWithin != null &&
          updatedWithinToFilter(initialUpdatedWithin!) !=
              selectedUpdatedWithin.value) {
        selectedUpdatedWithin.value =
            updatedWithinToFilter(initialUpdatedWithin!);
      }
      if (initialStatus != null &&
          productStatusToFilter(initialStatus!) !=
              selectedProductStatus.value) {
        selectedProductStatus.value = productStatusToFilter(initialStatus!);
      }
      return null;
    }, [
      initialBrand,
      initialCategory,
      initialUpdatedWithin,
      initialStatus,
    ]);

    // Setup filtered stream
    final filteredProvider = FilteredProductsStreamProvider(
      brand: selectedBrand.value ?? Brand.empty(),
      category: selectedCategory.value ?? Category.empty(),
      status: selectedProductStatus.value.value,
      updatedWithin: selectedUpdatedWithin.value.duration,
    );

    final filteredProducts = ref.watch(filteredProvider);
    final products = filteredProducts.valueOrNull;

    return ScaffoldX(
      wantLeading: true,
      title: """Products${mode == ProductsViewMode.edit ? ' - edit' : ''}""",
      appBarActions: [
        wholeProducts.maybeWhen(
          error: (error, stackTrace) {
            // print(error.toString());
            return SizedBox();
          },
          orElse: () => SizedBox(),
          data: (products) => Row(
            children: [
              Text('${products.length}', style: TextStyles.h8Gray(context)),
              Icon(Icons.inventory_2_outlined,
                  color: TextStyles.h8Gray(context)?.color,
                  size: TextStyles.h8Gray(context)?.fontSize)
            ],
          ),
        ),
        gapW16
      ],
      body: RefreshIndicator(
        onRefresh: () => refresh(ref: ref, pro: filteredProvider),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFilters(
                context: context,
                productMaker: productMaker,
                selectedBrand: selectedBrand,
                selectedCategory: selectedCategory,
                selectedUpdatedWithin: selectedUpdatedWithin,
                selectedProductStatus: selectedProductStatus,
              ),
              if (filteredProducts.isLoading)
                const LinearProgressIndicator(minHeight: 2)
              else
                gapH2,
              Expanded(child: Builder(builder: (context) {
                if (filteredProducts.hasError) {
                  return ErrorScreen(
                    error: filteredProducts.error!,
                    onRetry: () => refresh(ref: ref, pro: filteredProvider),
                  );
                }
                if (products == null)
                  return _buildShimmerLoading(context, mode);
                if (products.isEmpty) {
                  return _buildEmptyState(
                    context,
                    selectedBrand.value,
                    selectedCategory.value,
                    selectedProductStatus.value.value,
                    selectedUpdatedWithin.value,
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DynamicList<ProductWithDiscount>(
                    items: products,
                    physics: const NeverScrollableScrollPhysics(),
                    onSelect: (productWithDiscount) async {
                      await ref.watch(manageProductProvider.notifier).proUpdate(
                            product: productWithDiscount.product,
                            discount: productWithDiscount.discount,
                            mode: mode == ProductsViewMode.view
                                ? ManageProductMode.view
                                : ManageProductMode.edit,
                          );
                      if (mode == ProductsViewMode.view) {
                        AppRoute.viewProductDetails.push(context);
                      } else if (mode == ProductsViewMode.edit) {
                        AppRoute.manageProduct.go(context);
                      } else {
                        return;
                      }
                    },
                    itemBuilder: (context, item, _) => ViewProductCard(
                        ref: ref, mode: mode, productWithDiscount: item),
                  ),
                );
              })),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters({
    required BuildContext context,
    required AsyncValue<ProductMaker?> productMaker,
    required ValueNotifier<Brand?> selectedBrand,
    required ValueNotifier<Category?> selectedCategory,
    required ValueNotifier<UpdatedWithinFilter> selectedUpdatedWithin,
    required ValueNotifier<ProductStatusFilter> selectedProductStatus,
  }) {
    return productMaker.when(
      data: (maker) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              BrandFilterDropdown(
                brands: maker?.brands ?? [],
                selectedBrand: selectedBrand.value,
                onChanged: (brand) => selectedBrand.value = brand,
              ),
              CategoryFilterDropdown(
                categories: maker?.categories ?? [],
                selectedCategory: selectedCategory.value,
                onChanged: (category) => selectedCategory.value = category,
              ),
              UpdatedWithinFilterDropdown(
                updatedWithins: updatedWithinFilters,
                selectedUpdatedWithin: selectedUpdatedWithin.value,
                onChanged: (updatedWithin) =>
                    selectedUpdatedWithin.value = updatedWithin,
              ),
              ProductStatusFilterDropdown(
                productStatuses: productStatusFilters,
                selectedProductStatus: selectedProductStatus.value,
                onChanged: (status) => selectedProductStatus.value = status,
              ),
            ],
          ),
        );
      },
      loading: () => const ShimmerX(width: double.infinity, height: 48),
      error: (e, _) => ContainerX(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: appColors.sc.grey700),
            gapW8,
            Expanded(
              child: Text(
                'Failed to load Data: ${e.toString()}',
                style: TextStyles.h8(context)?.copyWith(
                  color: appColors.sc.grey700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    Brand? brand,
    Category? category,
    ProductStatus status,
    UpdatedWithinFilter updatedWithin,
  ) {
    final message = _buildNoProductsMessage(
      brand: brand,
      category: category,
      status: status,
      updatedWithin: updatedWithin,
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined,
              size: context.sizeOfHeight * 0.12, color: appColors.sc.grey650),
          gapH20,
          Text(message,
              textAlign: TextAlign.center, style: TextStyles.h8Gray(context)),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context, ProductsViewMode mode) {
    final heightMultipliersView = [0.2, 0.2, 0.2, 0.2];
    final heightMultipliersEdit = [0.08, 0.08, 0.08, 0.08];
    return SingleChildScrollView(
      child: SpacedColumn(
        children: (mode == ProductsViewMode.view
                ? heightMultipliersView
                : heightMultipliersEdit)
            .map((h) => ShimmerX(
                  width: context.sizeOfWidth,
                  height: context.sizeOfHeight * h,
                ))
            .toList(),
      ),
    );
  }

  String _buildNoProductsMessage({
    required UpdatedWithinFilter updatedWithin,
    Brand? brand,
    Category? category,
    ProductStatus? status,
  }) {
    final buffer = StringBuffer('No products found');

    if (updatedWithin.value != UpdatedWithin.anytime) {
      buffer.write(' last updated in ${updatedWithin.label}');
    }
    if (brand != null && brand.isNotEmpty) {
      buffer.write(' for ${brand.label}');
    }
    if (category != null && category.isNotEmpty) {
      buffer.write(' in ${category.label}');
    }
    if (status != null) {
      buffer.write(' with status ${status.name}');
    }

    return buffer.toString();
  }

  static Future<void> refresh({
    required WidgetRef ref,
    required FilteredProductsStreamProvider pro,
  }) async {
    await Future.wait([
      ref.refresh(pro.future),
      ref.refresh(fetchProductMakerProvider.future),
    ]);
  }
}
