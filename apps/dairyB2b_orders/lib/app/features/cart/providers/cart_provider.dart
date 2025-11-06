import 'dart:async';

import 'package:repo/repo.dart';
import 'package:models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dairyB2b_orders/app/features/cart/cart_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:table_calendar/table_calendar.dart';

part 'cart_provider.g.dart';
part 'cart_provider.freezed.dart';

@riverpod
class Cart extends _$Cart {
  @override
  FutureOr<CartState> build() async {
    //print('build called...............');
    final storedCart =
        await ref.read(cartServiceProvider).loadCartFromPreferences();
    return CartState(
      cart: storedCart.items,
      finalCart: state.value?.finalCart ?? [],
      itemLoadingState: state.value?.itemLoadingState,
      mode: state.value?.mode ?? storedCart.mode,
      editId: storedCart.editId,
      basketName: storedCart.basketName,
      clientUid: storedCart.clientUid,
    );
  }

  /// Mode Set Function
  Future<void> setMode(CartMode mode,
      {required List<CartItem> cartItems,
      String? editId,
      String? basketName,
      String? clientUid,
      String? withMessage}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await ref
        .read(cartServiceProvider)
        .setMode(mode,
            cartItems: cartItems,
            editId: editId,
            basketName: basketName,
            clientUid: clientUid,
            withMessage: withMessage));
    // log('Cart cleared and mode set to: $mode  cart_provider');
  }

  Future<void> quickItemsAdd({
    required List<CartItem> cartItems,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () async => await ref.read(cartServiceProvider).quickItemsAdd(
              cartItems: cartItems,
              currentState: state.value ?? CartState.empty(),
            ));
  }

  Future<void> validateSession(DateTime orderStart, DateTime orderEnd) async {
    final storedCart =
        await ref.read(cartServiceProvider).loadCartFromPreferences();
    final mode = storedCart.mode;
    final editId = storedCart.editId;

    if (editId == null) {
      // log('✅ No edit ID → No validation needed.');
      return;
    }

    try {
      final order = await ref
          .read(dairyB2bRepositoryProvider)
          .fetchOrderById(orderId: editId);

      final now = DateTime.now();

      switch (mode) {
        case CartMode.edit:
          if (order == null) {
            // log('❌ Order not found → Clearing cart. mode edit');
            await setMode(CartMode.newOrder, cartItems: []);
            return;
          }
          if (!isSameDay(order.createdAt, now)) {
            // log('❌ Edit mode → Order is not today → Clearing cart.');
            await setMode(
              CartMode.newOrder,
              cartItems: [],
              withMessage:
                  'Your previous order is from another day. Please create a new order.',
            );
            return;
          }

          final canEdit = now.isAfter(orderStart) && now.isBefore(orderEnd);
          if (!canEdit) {
            // log('❌ Edit mode → Out of time window → Clearing cart.');
            await setMode(
              CartMode.newOrder,
              cartItems: [],
              withMessage:
                  'The edit time window for today\'s order has closed. Please create a new order.',
            );
            return;
          }

          // log('✅ Edit mode → Valid time window → Continue.');
          break;
        case CartMode.basket:
        case CartMode.editBasket:
        case CartMode.newOrder:
          // No validation needed
          // log('✅ Mode $mode → No validation needed.');
          break;
      }
    } catch (e, _) {
      // log('❌ Error validating session: $e\n$st');
      await setMode(
        CartMode.newOrder,
        cartItems: [],
        withMessage: 'Something went wrong. Please start a new order.',
      );
    }
  }

  /// Add an item to the cart
  Future<void> addItem(String productId, int quantity,
      {bool clearAndUpdate = false, bool updateFinalCart = false}) async {
    state = await AsyncValue.guard(() async => ref
        .read(cartServiceProvider)
        .addItem(productId, quantity, state.value,
            clearAndUpdate: clearAndUpdate, updateFinalCart: updateFinalCart));
  }

  /// Update the quantity of an item in the cart
  Future<void> updateItemQuantity(String productId, int newQuantity,
      {bool updateFinalCart = false}) async {
    state = await AsyncValue.guard(() async => ref
        .read(cartServiceProvider)
        .updateItemQuantity(productId, newQuantity, state.value,
            updateFinalCart: updateFinalCart));
    // log('state.value: ${state.value} updateItemQuantity cart_provider');
  }

  /// Remove an item from the cart
  Future<void> removeItem(String productId,
      {bool updateFinalCart = false}) async {
    state = await AsyncValue.guard(() async => ref
        .read(cartServiceProvider)
        .removeItem(productId, state.value, updateFinalCart: updateFinalCart));
  }

  Future<void> loadFinalCart() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () async => ref.read(cartServiceProvider).loadFinalCart(state.value));
  }

  /// Clear the cart
  Future<void> clearCart({CartMode? mode}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => ref
        .read(cartServiceProvider)
        .clearCart(mode: mode ?? CartMode.newOrder));
  }

  /// Clean the cart items
  Future<void> cleanCartItems({CartMode? mode}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => ref
        .read(cartServiceProvider)
        .cleanCartItems(
            mode: mode ?? CartMode.newOrder,
            currentState: state.value ?? CartState.empty()));
  }

  void clearMessage() {
    final current = state.value;
    if (current != null && current.message != null) {
      state = AsyncValue.data(current.copyWith(message: null));
      // log('Cart message cleared.');
    }
  }

  /// To update basketName for text controller
  Future<void> updateBasketName(String basketName) async {
    state = await AsyncValue.guard(() async => ref
        .read(cartServiceProvider)
        .updateBasketName(
            basketName: basketName,
            currentState: state.value ?? CartState.empty()));
  }
}

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    List<CartItem>? cart,
    List<Product>? finalCart,
    Map<String, bool>? itemLoadingState,
    CartMode? mode,
    String? message,
    String? editId,
    String? basketName,
    String? clientUid,
    double? serviceCharges,
  }) = _CartState;

  factory CartState.empty() {
    return CartState(
      cart: [],
      finalCart: [],
      itemLoadingState: null,
      mode: CartMode.newOrder,
      message: null,
      editId: null,
      basketName: null,
      clientUid: null,
      serviceCharges: 0.0,
    );
  }
}
