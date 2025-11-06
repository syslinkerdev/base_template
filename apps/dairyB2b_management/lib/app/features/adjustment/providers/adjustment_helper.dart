import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';

typedef AH = AdjustmentHelper;

class AdjustmentHelper {
  static AsyncValue<AdjustmentState> _state(WidgetRef ref) =>
      ref.watch(adjustmentProvider);

  static int totalQty(WidgetRef ref) {
    return _state(ref).when(
      data: (state) =>
          state.finalCart?.fold<int>(
              0, (sum, item) => sum + (item.userSideQuantity ?? 0)) ??
          0,
      loading: () => 0,
      error: (_, __) => 0,
    );
  }

  static List<Product> finalCartList(WidgetRef ref) {
    return _state(ref).when(
      data: (state) => state.finalCart ?? [],
      loading: () => _state(ref).value?.finalCart ?? [],
      error: (_, __) => _state(ref).value?.finalCart ?? [],
    );
  }

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

  static double grandTotal(WidgetRef ref) => total(ref) - totalDiscount(ref);
}
