import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:models/models.dart';

typedef CH = CartHelper;

class CartHelper {
  static AsyncValue<CartState> _state(WidgetRef ref) => ref.watch(cartProvider);

  static int cartCount(WidgetRef ref) {
    return _state(ref).when(
      data: (state) =>
          state.cart?.fold<int>(0, (sum, item) => sum + item.origQty) ?? 0,
      loading: () => 0,
      error: (_, __) => 0,
    );
  }

  // static int totalQty(WidgetRef ref) {
  //   return _state(ref).when(
  //     data: (state) =>
  //         state.cart?.fold<int>(0, (sum, item) => sum + item.origQty) ?? 0,
  //     loading: () => 0,
  //     error: (_, __) => 0,
  //   );
  // }

  static List<CartItem> cartList(WidgetRef ref) {
    return _state(ref).when(
      data: (state) => state.cart ?? [],
      loading: () => [],
      error: (_, __) => [],
    );
  }

  static CartMode cartMode(WidgetRef ref) {
    return _state(ref).when(
      data: (state) => state.mode ?? CartMode.newOrder,
      loading: () => CartMode.newOrder,
      error: (_, __) => CartMode.newOrder,
    );
  }

  // static List<Product> finalCartList(WidgetRef ref) {
  //   return _state(ref).when(
  //     data: (state) => state.finalCart ?? [],
  //     loading: () => _state(ref).value?.finalCart ?? [],
  //     error: (_, __) => _state(ref).value?.finalCart ?? [],
  //   );
  // }

  // static bool isCartEmpty(WidgetRef ref) {
  //   return _state(ref).when(
  //     data: (state) => state.cart?.isEmpty ?? true,
  //     loading: () => true,
  //     error: (_, __) => true,
  //   );
  // }

  // static bool isFinalCartEmpty(WidgetRef ref) {
  //   return _state(ref).when(
  //     data: (state) => state.finalCart?.isEmpty ?? true,
  //     loading: () => true,
  //     error: (_, __) => true,
  //   );
  // }

  static double total(WidgetRef ref) {
    return _state(ref).when(
      data: (state) {
        return state.finalCart?.fold<double>(
              0.0,
              (sum, item) => sum + (item.price * (item.userSideQuantity ?? 0)),
            ) ??
            0.0;
      },
      loading: () => 0.0,
      error: (_, __) => 0.0,
    );
  }

  static double totalDiscount(WidgetRef ref) {
    return _state(ref).when(
      data: (state) {
        return state.finalCart?.fold<double>(
              0.0,
              (sum, item) =>
                  sum +
                  ((item.price - (item.priceAfterDiscount ?? item.price)) *
                      (item.userSideQuantity ?? 0)),
            ) ??
            0.0;
      },
      loading: () => 0.0,
      error: (_, __) => 0.0,
    );
  }

  static double grandTotal(WidgetRef ref, double? serviceCharges) =>
      (total(ref) - totalDiscount(ref)) + (serviceCharges ?? 0);
}
