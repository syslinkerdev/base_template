import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/features/account/account_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_provider.g.dart';

@riverpod
class Account extends _$Account {
  @override
  FutureOr<void> build() {}

  Future<void> updateAccount({
    required String firstName,
    required String lastName,
    required String avatar,
    required String uid,
  }) async {
    await _updateState(() async {
      final service = ref.read(accountServiceProvider);
      await service.updateAccount(
          firstName: firstName, lastName: lastName, avatar: avatar, uid: uid);
    });
  }

  Future<void> updateShop({
    required String shopName,
    required Address shopAddress,
    required String uid,
  }) async {
    await _updateState(() async {
      final service = ref.read(accountServiceProvider);
      await service.updateShop(
          shopName: shopName, shopAddress: shopAddress, uid: uid);
    });
  }

  Future<void> _updateState(Future<void> Function() updateFunction) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(updateFunction);
  }
}
