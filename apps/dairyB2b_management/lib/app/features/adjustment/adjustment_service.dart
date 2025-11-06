import 'dart:developer';
import 'package:core/services/global_cache_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';

part 'adjustment_service.g.dart';

@riverpod
AdjustmentService adjustmentService(Ref ref) => AdjustmentService(ref: ref);

class AdjustmentService {
  AdjustmentService({required this.ref});
  final Ref ref;
  final gCache = GlobalCacheService.instance;

  /// Initialize AdjustmentState with order, user & refreshed cart data
  Future<AdjustmentState> init(AdjustmentState state) async =>
      await _loadAdjustment(state.copyWith(finalCart: []));

  Future<AdjustmentState> _loadAdjustment(AdjustmentState state,
      {List<CartItem>? items}) async {
    final itemsX = items ?? state.order?.orderedProducts ?? [];
    if (itemsX.isEmpty) return state;

    final products = <Product>[];

    for (final item in itemsX) {
      final product = await _getProduct(item.productReference?.id);
      if (product == null) {
        log('❌ Product not found: ${item.productReference?.id}');
        continue;
      }
      // Use adjQty if available, otherwise origQty
      final qty = item.adjQty ?? item.origQty;
      products.add(product.copyWith(userSideQuantity: qty));
    }

    final discounts =
        state.user?.disSection?.productDiscounts.values.toList() ?? [];
    final discountedCart = _applyDiscounts(products, discounts);

    return state.copyWith(finalCart: discountedCart);
  }

  Future<Product?> _getProduct(String? id) async {
    // 1️⃣ From cache
    final cached = gCache.getProduct(id);
    if (cached != null) return cached;

    // 2️⃣ From stream provider
    final list = ref.read(productsStreamXProvider).value;
    final product = list?.firstWhere(
        (p) => p.id == id && p.status == ProductStatus.activePublic,
        orElse: () => Product.empty());
    if (product != null && product.isNotEmpty) {
      gCache.addProduct(product);
      return product;
    }

    // 3️⃣ From backend
    if (id == null) return null;
    final fetched = await ref
        .read(dairyB2bRepositoryProvider)
        .fetchProductsByIds(ids: [id]);
    if (fetched.isNotEmpty) {
      gCache.addProduct(fetched.first);
      return fetched.first;
    }

    return null;
  }

  List<Product> _applyDiscounts(List<Product> cart, List<Discount> discounts) {
    return cart.map((p) {
      final dis = discounts.firstWhere(
        (d) => d.productReference?.id == p.id,
        orElse: () => Discount.empty(),
      );
      final discountedPrice =
          (p.price - dis.discount.toDouble()).clamp(0, double.infinity);
      return p.copyWith(priceAfterDiscount: discountedPrice.toDouble());
    }).toList();
  }

  Future<AdjustmentState> addItem(
      String id, int quantity, AdjustmentState? state,
      {bool clearAndUpdate = false}) async {
    final currentFinalCart = state?.finalCart ?? [];
    final existingFinalItemIndex =
        currentFinalCart.indexWhere((item) => item.id == id);

    List<Product> updatedFinalCart = List<Product>.from(currentFinalCart);
    //print('Current Cart: $currentCart');
    //print('Current Final Cart: $currentFinalCart');
    if (existingFinalItemIndex != -1) {
      if (existingFinalItemIndex != -1) {
        updatedFinalCart[existingFinalItemIndex] =
            updatedFinalCart[existingFinalItemIndex].copyWith(
          userSideQuantity: clearAndUpdate
              ? quantity
              : (updatedFinalCart[existingFinalItemIndex].userSideQuantity ??
                      0) +
                  quantity,
        );
      }
    } else {
      Product? productToAdd = await _getProduct(id);
      if (productToAdd != null) {
        // Apply cached discount if available
        final discounts =
            state?.user?.disSection?.productDiscounts.values.toList() ?? [];

        final discount = _getUserDiscountForProduct(
            id: productToAdd.id, userDiscounts: discounts);

        final discountedPrice = _calculateDiscountPrice(
            productToAdd.price, discount.discount.toDouble());

        updatedFinalCart.add(productToAdd.copyWith(
            userSideQuantity: quantity, priceAfterDiscount: discountedPrice));
      }
    } //print('Updated Final Cart: $updatedFinalCart');

    // log('State Before Update: ${state!.mode?.name}');
    final newState = await _updateCartState(updatedFinalCart, state);
    // log('State After Update: ${state.mode?.name}');
    return newState;
  }

  Future<AdjustmentState> updateItemQuantity(
      String id, int newQuantity, AdjustmentState? state) async {
    List<Product>? updatedFinalCart = state?.finalCart;
    // log('updateFinalCart : $updateFinalCart');

    updatedFinalCart = updatedFinalCart?.map((product) {
      return product.id == id
          ? product.copyWith(userSideQuantity: newQuantity)
          : product;
    }).toList();

    // log('_updateCartState: ${state!.mode?.name}');
    return _updateCartState(updatedFinalCart ?? [], state);
  }

  Future<AdjustmentState> removeItem(String id, AdjustmentState? state) async {
    List<Product>? updatedFinalCart = state?.finalCart;
    updatedFinalCart =
        updatedFinalCart?.where((product) => product.id != id).toList();

    return _updateCartState(updatedFinalCart ?? [], state);
  }

  Future<AdjustmentState> quickItemsAdd(
      {required List<CartItem> cartItems,
      required AdjustmentState currentState}) async {
    final finalState = await _loadAdjustment(currentState, items: cartItems);
    return finalState;
  }

  // Function to get the user's discount for a specific product
  Discount _getUserDiscountForProduct({
    required String id,
    required List<Discount> userDiscounts,
  }) {
    return userDiscounts.firstWhere(
      (discount) => discount.productReference?.id == id,
      orElse: () => Discount.empty(), // Returns an empty discount if not found
    );
  }

  // Function to calculate the discounted price
  double _calculateDiscountPrice(double originalPrice, double discountAmount) {
    return (originalPrice - discountAmount).clamp(0, double.infinity);
  }

  // Helper function to update the cart state
  Future<AdjustmentState> _updateCartState(
    List<Product> updatedFinalCart,
    AdjustmentState? state,
  ) async {
    try {
      final newState = state?.copyWith(finalCart: updatedFinalCart) ??
          AdjustmentState.empty();
      // // log('New Cart State: $newState');
      return newState;
    } catch (e) {
      //print('Error in _updateCartState: $e');
      //return the old state, or empty state, or throw an exception.
      return state ?? AdjustmentState.empty();
    }
  }
}
