import 'package:models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_management/app/features/adjustment/order_service.dart';

part 'order_provider.g.dart';

@riverpod
class OrderPro extends _$OrderPro {
  @override
  FutureOr<void> build() {}

  /// Handles order actions based on the given [mode]
  Future<void> handleOrderAction({
    required List<Product> items,
    required AdjustmentMode mode,
    required UserX user,
    OrderX? previousOrder,
  }) async {
    print('🟣 [OrderPro] handleOrderAction called with mode: $mode');
    print('📦 [OrderPro] items count: ${items.length}');
    print('👤 [OrderPro] user: ${user.uid}');

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final orderService = ref.read(orderServiceProvider);
      print('⚙️ [OrderPro] Using orderService: $orderService');

      switch (mode) {
        case AdjustmentMode.newOrder:
          print('🆕 [OrderPro] Placing new order...');
          await orderService.placeOrder(orderedProducts: items, user: user);
          break;
        case AdjustmentMode.modify:
          print('✏️ [OrderPro] Modifying order...');
          if (previousOrder == null) {
            throw Exception('Previous order must be provided for modify mode');
          }
          await orderService.modifyOrder(
              orderedProducts: items, user: user, previousOrder: previousOrder);
          break;
        case AdjustmentMode.adjustment:
          print('⚖️ [OrderPro] Adjusting order...');
          if (previousOrder == null) {
            throw Exception(
                'Previous order must be provided for adjustment mode');
          }
          await orderService.adjustOrder(
              orderedProducts: items, user: user, previousOrder: previousOrder);
          break;
      }
    });
  }

  /// Delete order
  Future<void> deleteOrder({required OrderX order}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async =>
        await ref.read(orderServiceProvider).deleteOrder(order: order));
  }
}
