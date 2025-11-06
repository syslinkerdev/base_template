import 'dart:convert';

import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_services.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_service.g.dart';

@riverpod
CartService cartService(Ref ref) {
  return CartService(ref: ref);
}

class CartService {
  CartService({required this.ref});
  final Ref ref;
  final gCache = GlobalCacheService.instance; // Local gCache (small DB)
  List<Product>? _cachedFinalCart; // Stores the last discounted cart
  List<Discount>? _cachedDiscounts; // Stores the discounts

  /// fun's

  Future<CartState> setMode(
    CartMode mode, {
    required List<CartItem> cartItems,
    String? editId,
    String? basketName,
    String? clientUid,
    String? withMessage,
  }) async {
    // Clear existing cart first
    final clearedState = await clearCart();

    // Create new state with mode and new cartItems
    final tempState = clearedState.copyWith(
      mode: mode,
      cart: cartItems,
      editId: editId,
      basketName: basketName,
      clientUid: clientUid,
      message: withMessage,
    );

    // Use loadFinalCart to update finalCart & cart prices based on cartItems
    final finalState = await loadFinalCart(tempState);
    if (finalState.cart != null && finalState.cart!.isNotEmpty) {
      await _saveCartToPreferences(
        StoredCart(
          items: finalState.cart!,
          mode: mode,
          editId: editId,
          basketName: basketName,
          clientUid: clientUid,
        ),
      );
    }
    // log('Cart cleared and mode set to: $mode');
    return finalState;
  }

  Future<CartState> quickItemsAdd(
      {required List<CartItem> cartItems,
      required CartState currentState}) async {
    final tempState = currentState.copyWith(cart: cartItems);

    final finalState = await loadFinalCart(tempState);
    if (finalState.cart != null && finalState.cart!.isNotEmpty) {
      await _saveCartToPreferences(
        StoredCart(
          items: finalState.cart!,
          mode: finalState.mode ?? tempState.mode!,
          editId: finalState.editId,
          basketName: finalState.basketName,
          clientUid: finalState.clientUid,
        ),
      );
    }
    // log('Cart cleared and mode set to: ${finalState.mode}');
    return finalState;
  }

  Future<CartState> updateBasketName(
      {required String basketName, required CartState currentState}) async {
    final tempState = currentState.copyWith(basketName: basketName);

    if (tempState.basketName != null && tempState.basketName!.isNotEmpty) {
      await _saveCartToPreferences(
        StoredCart(
          items: tempState.cart ?? currentState.cart!,
          mode: tempState.mode ?? currentState.mode!,
          editId: tempState.editId,
          basketName: tempState.basketName,
          clientUid: tempState.clientUid,
        ),
      );
    }
    // log('Cart cleared and mode set to: ${tempState.mode}, ${tempState.basketName}');
    return tempState;
  }

  Future<CartState> addItem(String id, int quantity, CartState? state,
      {bool clearAndUpdate = false, bool updateFinalCart = false}) async {
    final currentLoadingState = state?.itemLoadingState ?? {};
    await _updateItemLoadingState(currentLoadingState, id, true);

    final currentCart = state?.cart ?? [];
    final currentFinalCart = state?.finalCart ?? [];
    final existingItemIndex =
        currentCart.indexWhere((item) => item.productReference?.id == id);
    final existingFinalItemIndex =
        currentFinalCart.indexWhere((item) => item.id == id);

    List<CartItem> updatedCart = List<CartItem>.from(currentCart);
    List<Product> updatedFinalCart = List<Product>.from(currentFinalCart);
    //print('Current Cart: $currentCart');
    //print('Current Final Cart: $currentFinalCart');
    if (existingItemIndex != -1) {
      updatedCart[existingItemIndex] = updatedCart[existingItemIndex].copyWith(
        origQty: clearAndUpdate
            ? quantity
            : updatedCart[existingItemIndex].origQty + quantity,
      );

      if (updateFinalCart && existingFinalItemIndex != -1) {
        updatedFinalCart[existingFinalItemIndex] =
            updatedFinalCart[existingFinalItemIndex].copyWith(
          userSideQuantity: updatedCart[existingItemIndex].origQty,
        );
      }
    } else {
      final newItem = CartItem(
        productReference: FirebaseFirestore.instance
            .doc(DbPathManager.product(productId: id)),
        origQty: quantity,
      );
      updatedCart.add(newItem);

      if (updateFinalCart) {
        Product? productToAdd = await getProductByIdSmart(id);
        if (productToAdd != null) {
          // Apply cached discount if available
          final discount = _getUserDiscountForProduct(
            id: productToAdd.id,
            userDiscounts: _cachedDiscounts ?? [],
          );

          final discountedPrice = _calculateDiscountPrice(
            productToAdd.price,
            discount.discount.toDouble(),
          );

          updatedFinalCart.add(productToAdd.copyWith(
            userSideQuantity: newItem.origQty,
            priceAfterDiscount: discountedPrice,
          ));
        }
      }
    }
    //print('Updated Cart: $updatedCart');
    //print('Updated Final Cart: $updatedFinalCart');

    await _updateItemLoadingState(currentLoadingState, id, false);
    // log('State Before Update: ${state!.mode?.name}');
    final newState =
        await _updateCartState(updatedCart, updatedFinalCart, state);
    // log('State After Update: ${state.mode?.name}');
    return newState;
  }

  Future<CartState> updateItemQuantity(
      String id, int newQuantity, CartState? state,
      {bool updateFinalCart = false}) async {
    final currentLoadingState = state?.itemLoadingState ?? {};
    await _updateItemLoadingState(currentLoadingState, id, true);
    final currentCart = state?.cart ?? [];
    final updatedCart = currentCart.map((item) {
      return item.productReference?.id == id
          ? item.copyWith(origQty: newQuantity)
          : item;
    }).toList();
    List<Product>? updatedFinalCart = state?.finalCart;
    // log('updateFinalCart : $updateFinalCart');
    if (updateFinalCart) {
      updatedFinalCart = updatedFinalCart?.map((product) {
        return product.id == id
            ? product.copyWith(userSideQuantity: newQuantity)
            : product;
      }).toList();
    }

    await _updateItemLoadingState(currentLoadingState, id, false);
    // log('_updateCartState: ${state!.mode?.name}');
    return _updateCartState(updatedCart, updatedFinalCart ?? [], state);
  }

  Future<CartState> removeItem(String id, CartState? state,
      {bool updateFinalCart = false}) async {
    final currentLoadingState = state?.itemLoadingState ?? {};
    await _updateItemLoadingState(currentLoadingState, id, true);

    final currentCart = state?.cart ?? [];
    final updatedCart =
        currentCart.where((item) => item.productReference?.id != id).toList();

    List<Product>? updatedFinalCart = state?.finalCart;
    if (updateFinalCart) {
      updatedFinalCart =
          updatedFinalCart?.where((product) => product.id != id).toList();
    }

    await _updateItemLoadingState(currentLoadingState, id, false);
    return _updateCartState(updatedCart, updatedFinalCart ?? [], state);
  }

  Future<CartState> loadFinalCart(CartState? state) async {
    final cartItems = state?.cart ?? [];
    // Just return state if cartItems is empty
    if (cartItems.isEmpty) {
      return state?.copyWith(finalCart: []) ?? CartState.empty();
    }

    List<Product> orderProducts = [];
    List<CartItem> updatedCartItems = [];
    for (final item in cartItems) {
      final product = await getProductByIdSmart(item.productReference?.id);

      if (product != null) {
        // Add to finalCart with quantity
        orderProducts.add(product.copyWith(userSideQuantity: item.origQty));

        // Update price in cartItem
        updatedCartItems.add(item.copyWith(unitPrice: product.price));
      } else {
        // log('Product not found: ${item.productReference.id}');
      }
    }

    final discountedCart = await applyUserDiscounts(
        finalCart: orderProducts, clientUid: state?.clientUid);
    final serviceCharges = await applyUserServiceCharges(state?.clientUid);
    final cartState = state?.copyWith(
            cart: updatedCartItems, // ✅ Updated cartItems with fresh prices
            finalCart: discountedCart,
            serviceCharges: serviceCharges) ??
        CartState.empty();

    return cartState;
  }

  Future<CartState> clearCart({CartMode? mode}) async {
    await _saveCartToPreferences(
        StoredCart.empty().copyWith(mode: mode ?? CartMode.newOrder));
    _cachedFinalCart = [];
    return CartState.empty().copyWith(mode: mode ?? CartMode.newOrder);
  }

  Future<CartState> cleanCartItems(
      {CartMode? mode, required CartState currentState}) async {
    final storedCart = await loadCartFromPreferences();
    await _saveCartToPreferences(
        storedCart.copyWith(mode: mode ?? CartMode.newOrder, items: []));
    _cachedFinalCart = [];
    return currentState
        .copyWith(mode: mode ?? CartMode.newOrder, cart: [], finalCart: []);
  }

  // Helper function to manage item loading state
  Future<Map<String, bool>> _updateItemLoadingState(
      Map<String, bool> loadingState, String id, bool isLoading) async {
    loadingState[id] = isLoading;
    //print('object loadingState: $loadingState');
    return loadingState;
  }

  // Helper function to get a product by ID and gCache it
  Future<Product?> getProductByIdSmart(String? id) async {
    // Step 1: Check in global gCache
    Product? product = gCache.getProduct(id);
    if (product != null) {
      // print('[getProductByIdSmart] ✅ Found in global gCache: $id');
      return product;
    }

    // Step 2: Check in product list (local provider)
    final productList = ref
        .read(productsStreamXProvider)
        .value
        ?.where((product) => product.status == ProductStatus.activePublic)
        .toList();
    if (productList != null) {
      product = productList.firstWhere(
        (p) => p.id == id,
        orElse: () => Product.empty(),
      );
      if (product.isNotEmpty) {
        // print('[getProductByIdSmart] 📦 Found in product list: $id');
        gCache.addProduct(product); // Add to global gCache
        return product;
      }
    }

    // Step 3: Fetch from backend
    // print('[getProductByIdSmart] 🔍 Fetching from backend: $id');
    if (id == null) return null;
    final fetchedProducts = await ref
        .read(dairyB2bRepositoryProvider)
        .fetchProductsByIds(ids: [id]);

    if (fetchedProducts.isNotEmpty) {
      product = fetchedProducts.first;
      // print('[getProductByIdSmart] ✅ Found from backend: $id');
      gCache.addProduct(product); // Add to global gCache
      return product;
    }

    // print('[getProductByIdSmart] ❌ Product not found: $id');
    return null;
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
  Future<CartState> _updateCartState(
    List<CartItem> updatedCart,
    List<Product> updatedFinalCart,
    CartState? state,
  ) async {
    try {
      final storedCart = StoredCart(
        items: updatedCart,
        mode: state?.mode ?? CartMode.newOrder,
        editId: state?.editId,
      );
      await _saveCartToPreferences(storedCart);
      final newState =
          state?.copyWith(cart: updatedCart, finalCart: updatedFinalCart) ??
              CartState.empty();
      // // log('New Cart State: $newState');
      return newState;
    } catch (e) {
      //print('Error in _updateCartState: $e');
      //return the old state, or empty state, or throw an exception.
      return state ?? CartState.empty();
    }
  }

  // Helper function to save the cart list to SharedPreferences
  Future<void> _saveCartToPreferences(StoredCart storedCart) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = jsonEncode(storedCart.toJson());
      //print('stroing data : $cartJson');
      await prefs.setString(StoredCart.storedCartKey, cartJson);
    } catch (e) {
      //print('Error saving cart to preferences: $e');
    }
  }

  // Helper function to load the cart list from SharedPreferences
  Future<StoredCart> loadCartFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(StoredCart.storedCartKey);

    //print("Cart JSON: $cartJson");

    if (cartJson == null) return StoredCart.empty();

    try {
      final Map<String, dynamic> decoded = jsonDecode(cartJson);
      return StoredCart.fromJson(decoded);
    } catch (e) {
      //print('Error loading cart: $e');
      throw Exception('Failed to load cart from preferences: $e');
    }
  }

  Future<List<Product>> applyUserDiscounts({
    required List<Product> finalCart,
    String? clientUid,
  }) async {
    // //print('applyUserDiscounts');
    // Check if finalCart is unchanged; if yes, return the cached version
    if (_cachedFinalCart != null &&
        _areCartsEqual(_cachedFinalCart!, finalCart)) {
      // //print('Returning cached finalCart');
      return _cachedFinalCart!;
    }

    final userDis = clientUid == null
        ? await getUserDiscounts()
        : await getClientDiscounts(clientUid);
    // here we use getClientsDiscounts if ClientUid present in CartState
    _cachedDiscounts = userDis;
    final discountedCart = finalCart.map((product) {
      final applicableDiscount = userDis.firstWhere(
        (discount) => discount.productReference?.id == product.id,
        orElse: () => Discount.empty(),
      );
      // //print(applicableDiscount.discount);
      final discountedPrice =
          (product.price - applicableDiscount.discount.toDouble())
              .clamp(0, double.infinity);
      // //print(discountedPrice);

      return product.copyWith(priceAfterDiscount: discountedPrice.toDouble());
    }).toList();

    // gCache the updated finalCart
    _cachedFinalCart = discountedCart;
    return discountedCart;
  }

  Future<double> applyUserServiceCharges(String? clientUid) async {
    final user = await getUser(clientUid);
    return user?.serviceCharges ?? 10;
  }

// Helper function to compare two carts
  bool _areCartsEqual(List<Product> oldCart, List<Product> newCart) {
    if (oldCart.length != newCart.length) return false;

    for (int i = 0; i < oldCart.length; i++) {
      if (oldCart[i].id != newCart[i].id ||
          oldCart[i].userSideQuantity != newCart[i].userSideQuantity) {
        return false;
      }
    }
    return true;
  }

// Get current user's discounts
  Future<List<Discount>> getUserDiscounts() async {
    final user = await getUser(null); // null means current user
    return user?.disSection?.productDiscounts.values.toList() ?? [];
  }

// Get a specific client's discounts
  Future<List<Discount>> getClientDiscounts(String clientUid) async {
    final client = await getUser(clientUid); // pass client UID
    return client?.disSection?.productDiscounts.values.toList() ?? [];
  }

// Reusable getUser function
  Future<UserX?> getUser(String? clientUid) async {
    // Check cache first
    final cachedUser =
        clientUid == null ? gCache.getUser() : gCache.getClient();

    if (cachedUser != null) {
      return cachedUser;
    }

    // If not cached, fetch from backend
    final userId =
        clientUid ?? (await ref.read(appStateServiceProvider)).current.uId;

    final backEndUser = await ref
        .read(dairyB2bRepositoryProvider)
        .fetchUser(documentId: userId);

    // Cache it properly
    if (backEndUser != null) {
      if (clientUid == null) {
        gCache.setUser(backEndUser);
      } else {
        gCache.setClient(backEndUser);
      }
    }

    return backEndUser;
  }
}
