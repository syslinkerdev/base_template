import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dairyB2b_orders/app/features/kyc/kyc_validator.dart';
import 'package:dairyB2b_orders/app/features/kyc/providers/kyc_provider.dart';
import 'package:core/core.dart';

class IconizeChooseAvatarPage extends ConsumerWidget with KycValidator {
  const IconizeChooseAvatarPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kyc = ref.watch(kycProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: AvatarsList(
        title: 'Select your \nAvatar . . .',
        action: (avatar) {
          return [
            ButtonX.primaryButton(
              context: context,
              label: 'Confirm',
              loading: kyc.isLoading,
              onPressed: () => toConfirmAvatar(
                  avatar: avatar,
                  context: context,
                  afterConfirmAvatar: () => ref
                      .read(kycProvider.notifier)
                      .atConfirmAvatar(avatar: avatar.image)),
            ),
          ];
        },
      ),
    );
  }
}
