import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:core/widgets/stepper_page_view_x.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_orders/app/features/kyc/kyc_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyc_provider.g.dart';

final userXHolder = StateProvider<UserX>((ref) => UserX.empty());

@riverpod
class Kyc extends _$Kyc {
  @override
  FutureOr<void> build() {}

  Future<void> atConfirmAdmin({required DataBlock3 admin}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final userPhone =
            await ref.read(kycServiceProvider).createUser(admin: admin);
        ref
            .read(userXHolder.notifier)
            .update((user) => user.copyWith(phoneNumber: userPhone));
        //print('----------------');
        stepper.nextPage();
      },
    );
  }

  Future<void> atAccessCode({required UserX clientData}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      ref.read(userXHolder.notifier).update((_) => clientData);
      stepper.nextPage();
    });
  }

  Future<void> atConfirmUserDetails({
    required String firstName,
    required String lastName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      ref.read(userXHolder.notifier).update((user) => user.copyWith(
            firstName: firstName,
            lastName: lastName,
          ));
      stepper.nextPage();
    });
  }

  Future<void> atConfirmShopDetails({
    required String shopName,
    required String stateName,
    required String city,
    required String locality,
    required String pinCode,
    required String street,
    required String buildingNumber,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final finalPlace =
          await ref.read(addressManagerProvider.notifier).addressValidator(
                shopName: shopName,
                stateName: stateName,
                city: city,
                locality: locality,
                pinCode: pinCode,
                street: street,
                buildingNumber: buildingNumber,
              );
      if (ref.watch(addressManagerProvider).hasError) {
        return;
      }
      ref.read(userXHolder.notifier).update((user) => user.copyWith(
          shopName: shopName, shopAddress: finalPlace ?? user.shopAddress));
      stepper.nextPage();
    });
  }

  Future<void> atConfirmAvatar({required String avatar}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      UserX userXUpdated = ref
          .read(userXHolder.notifier)
          .update((user) => user.copyWith(avatar: avatar));
      await ref.read(kycServiceProvider).updateUser(client: userXUpdated).then(
            (_) => ref
                .read(appStateXProvider.notifier)
                .markKycCompleted(uId: userXUpdated.uid),
          );
      stepper.nextPage();
    });
  }
}
