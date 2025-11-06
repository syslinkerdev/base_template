import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';

part 'products_manager_provider.g.dart';
part 'products_manager_provider.freezed.dart';

@riverpod
FutureOr<ProductsManagerState> productsManager(Ref ref,
        {String? brand, String? category}) async =>
    await ref
        .read(productsManagerServiceProvider)
        .atInit(brand: brand, category: category);

@freezed
abstract class ProductsManagerState with _$ProductsManagerState {
  const factory ProductsManagerState({
    required List<Product> products,
    required List<Product> filteredProducts,
  }) = _ProductsManagerState;
}

// Service

@riverpod
ProductsManagerService productsManagerService(Ref ref) {
  return ProductsManagerService(ref: ref);
}

class ProductsManagerService {
  ProductsManagerService({required this.ref});
  final Ref ref;

  Future<ProductsManagerState> atInit({
    String? brand,
    String? category,
  }) async {
    final products = await _getProducts();
    final filteredProducts = _filterProducts(products, brand, category);
    //print('products : ${products.length}');
    //print('filteredProducts : ${filteredProducts.length}');
    return ProductsManagerState(
        products: products, filteredProducts: filteredProducts);
  }

  Future<List<Product>> _getProducts() async {
    final products = ref.read(productsStreamXProvider).value;

    List<Product> finalProducts;

    if (products == null || products.isEmpty) {
      final refreshedState = await ref.refresh(productsStreamXProvider.future);
      finalProducts = refreshedState;
    } else {
      finalProducts = products;
    }

    final activePublicProducts = finalProducts
        .where((product) => product.status == ProductStatus.activePublic)
        .toList();

    //print(
    // '✅ _getProducts: Fetched ${activePublicProducts.length} activePublic products');

    return activePublicProducts;
  }

  List<Product> _filterProducts(
    List<Product> products,
    String? brand,
    String? category,
  ) {
    return products.where((product) {
      final matchesBrand = brand == null || product.brand.id == brand;
      final matchesCategory =
          category == null || product.category.id == category;
      return matchesBrand && matchesCategory;
    }).toList();
  }
}
