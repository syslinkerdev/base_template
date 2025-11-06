import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'smart_basket_providers.g.dart';

@riverpod
class SmartBasketX extends _$SmartBasketX {
  @override
  FutureOr<void> build() {}

  Future<bool> createNewSmartBasket(UserX user) async {
    state = const AsyncValue.loading();
    try {
      if (user.basketLimitNo == user.smartBaskets?.length) {
        state = const AsyncValue.data(null);
        return false;
      } else {
        await ref
            .read(cartProvider.notifier)
            .setMode(CartMode.basket, cartItems: [], basketName: null);
        state = const AsyncValue.data(null);
        return true;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<void> deleteSmartBasket(String basketId) async {
    state = await AsyncValue.guard(() async {
      final uId = await ref.read(appStateXProvider).uId;
      final user = await ref.read(fetchUserProvider(documentId: uId)).value;

      if (user == null) {
        throw Exception('User not found');
      }

      final updatedBaskets =
          user.smartBaskets?.where((b) => b.basketId != basketId).toList();

      await ref.read(firestoreServiceProvider).updateDocument(
        collectionPath: DbPathManager.users(),
        documentId: user.uid,
        data: {
          DbStandardFields.smartBaskets:
              updatedBaskets?.map((b) => b.toDocument()).toList(),
        },
      );
      ref.invalidate(fetchUserProvider(documentId: user.uid));
    });
  }
}
