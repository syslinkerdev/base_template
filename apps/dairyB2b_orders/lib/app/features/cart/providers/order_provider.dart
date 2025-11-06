import 'package:core/core.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/order_service.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_provider.g.dart';

@riverpod
class OrderPro extends _$OrderPro {
  @override
  FutureOr<void> build() {}

  Future<void> handleCartAction({
    required CartMode mode,
    required List<CartItem> cartItems,
    String? editId,
    String? basketName,
  }) async {
    state = const AsyncLoading();
    //print(
    // 'handleCartAction called with mode: $mode, editId: $editId, basketName: $basketName');
    state = await AsyncValue.guard(() async {
      final orderService = ref.read(orderServiceProvider);
      switch (mode) {
        case CartMode.newOrder:
          await placeOrder(cartItems: cartItems);
          break;

        case CartMode.edit:
          if (editId == null) {
            throw convertToAppException(
              exception: 'Missing editId for editing order.',
              title: 'Invalid Operation',
            );
          }
          await orderService.updateOrder(
              orderId: editId, updatedProducts: cartItems);

          break;

        case CartMode.basket:
          if (basketName == null || basketName.isEmpty) {
            throw convertToAppException(
              exception: 'Basket name is required for smart basket.',
              title: 'Basket Name Required',
            );
          }
          await orderService.createSmartBasket(
              cartList: cartItems, basketName: basketName);
          break;

        case CartMode.editBasket:
          if (editId == null) {
            throw convertToAppException(
              exception: 'Missing editId for editing smart basket.',
              title: 'Invalid Operation',
            );
          }
          if (basketName == null || basketName.isEmpty) {
            throw convertToAppException(
              exception: 'Basket name is required for editing smart basket.',
              title: 'Basket Name Required',
            );
          }
          await orderService.updateSmartBasket(
              basketId: editId,
              newBasketName: basketName,
              newCartList: cartItems);
          break;
      }
    });
  }

  Future<void> placeOrder({required List<CartItem> cartItems}) async {
    final userUid = await ref.read(appStateXProvider).uId;

    await _ensureNoExistingOrder(userUid);
    await _validateOrderWindow();

    await ref.read(orderServiceProvider).placeOrder(orderedProducts: cartItems);
  }

  Future<void> _ensureNoExistingOrder(String userUid) async {
    final exists = await ref
        .read(dairyB2bRepositoryProvider)
        .doesOrderExistForNextDay(uId: userUid);

    if (exists) {
      throw convertToAppException(
        exception:
            'You already have an order for today. Please edit that order instead.',
        title: 'Order Exists',
      );
    }
  }

  Future<void> _validateOrderWindow() async {
    final orderRules = await ref.watch(orderRulesStreamProvider.future);
    if (orderRules == null ||
        orderRules.orderStart == null ||
        orderRules.orderEnd == null ||
        orderRules.canEdit) {
      return;
    }
    final now = DateTime.now();
    final start = orderRules.todayEffectiveOrderStart;
    final end = orderRules.todayEffectiveOrderEnd;
    if (start == null || end == null) return;
    if (now.isBefore(start)) {
      throw _disabledError(
          'You can place orders starting from ${DFU.timeOnly12h(start)}.');
    } else if (now.isAfter(end)) {
      throw _disabledError(
          'The order window closed at ${DFU.timeOnly12h(end)}.');
    } else {
      throw _disabledError(
        'Order placing is currently disabled. Please contact support for assistance.',
      );
    }
  }

  AppException _disabledError(String msg) =>
      convertToAppException(exception: msg, title: 'Ordering Disabled');
}
