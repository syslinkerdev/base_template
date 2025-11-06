import 'package:models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dairyB2b_management/app/features/adjustment/adjustment_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'adjustment_provider.g.dart';
part 'adjustment_provider.freezed.dart';

@riverpod
class Adjustment extends _$Adjustment {
  @override
  FutureOr<AdjustmentState> build() => AdjustmentState.empty();

  Future<void> init(AdjustmentState aState) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () async => await ref.read(adjustmentServiceProvider).init(aState));
  }

  Future<void> undo() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async =>
        await ref.read(adjustmentServiceProvider).init(state.value!));
  }

  /// Add an item to the cart
  Future<void> addItem(String productId, int quantity,
      {bool clearAndUpdate = false}) async {
    state = await AsyncValue.guard(() async => ref
        .read(adjustmentServiceProvider)
        .addItem(productId, quantity, state.value,
            clearAndUpdate: clearAndUpdate));
  }

  /// Update the quantity of an item in the cart
  Future<void> updateItemQuantity(String productId, int newQuantity) async {
    state = await AsyncValue.guard(() async => ref
        .read(adjustmentServiceProvider)
        .updateItemQuantity(productId, newQuantity, state.value));
    // log('state.value: ${state.value} updateItemQuantity cart_provider');
  }

  /// Remove an item from the cart
  Future<void> removeItem(String productId) async {
    state = await AsyncValue.guard(() async =>
        ref.read(adjustmentServiceProvider).removeItem(productId, state.value));
  }

  Future<void> quickItemsAdd({required List<CartItem> cartItems}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () async => await ref.read(adjustmentServiceProvider).quickItemsAdd(
              cartItems: cartItems,
              currentState: state.value ?? AdjustmentState.empty(),
            ));
  }
}

@freezed
abstract class AdjustmentState with _$AdjustmentState {
  const factory AdjustmentState({
    List<Product>? finalCart,
    OrderX? order,
    UserX? user,
    AdjustmentMode? mode,
  }) = _AdjustmentState;

  factory AdjustmentState.empty() {
    return AdjustmentState(
      finalCart: [],
      order: OrderX.empty(),
      user: UserX.empty(),
      mode: AdjustmentMode.newOrder,
    );
  }
}
