import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/products_manager/providers/products_manager_provider.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/product_card.dart';

class ProductList extends HookConsumerWidget {
  const ProductList(
      {super.key,
      this.initBrand,
      this.initCategory,
      this.padding = const EdgeInsets.all(12)});

  final String? initBrand;
  final String? initCategory;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rawProvider =
        ProductsManagerProvider(brand: initBrand, category: initCategory);
    final productsManagerState = ref.watch(rawProvider);

    return productsManagerState.when(
        data: (data) {
          return RefreshIndicator(
            onRefresh: () => _refresh(ref, rawProvider),
            child: Padding(
              padding: padding,
              child: data.filteredProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: context.sizeOfHeight * 0.12,
                            color: appColors.sc.grey650,
                          ),
                          gapH20,
                          Text(
                            'No Products Found',
                            style: TextStyles.h7(context),
                            textAlign: TextAlign.center,
                          ),
                          gapH8,
                          Text(
                            'No products match your current filters. Try adjusting the filter or search.',
                            style: TextStyles.h8(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : CustomScrollView(
                      slivers: [
                        // SliverGrid for the products
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final product = data.filteredProducts[index];
                              return ProductCard(product: product);
                            },
                            childCount: data.filteredProducts.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.54,
                          ),
                        ),
                        // SliverToBoxAdapter for the text widget
                        SliverToBoxAdapter(child: OrderSloganFooter()),
                      ],
                    ),
            ),
          );
        },
        error: (error, stackTrace) => ErrorScreen(
            error: error, onRetry: () => _refresh(ref, rawProvider)),
        loading: () => LoadingScreen());
  }

  static Future<void> _refresh(
          WidgetRef ref, ProductsManagerProvider rawProvider) =>
      ref.refresh(rawProvider.future);
}
