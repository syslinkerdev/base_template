import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/account/providers/account_provider.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';

class EditShop extends HookConsumerWidget with CommonValidator {
  const EditShop({super.key, required this.shopInfo});

  final Map<String, dynamic> shopInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopController =
        useTextEditingController(text: shopInfo['name'] ?? '');
    final address = useState<Address>(shopInfo['address']);
    final account = ref.watch(accountProvider);
    ref.listen(
        accountProvider, (_, next) => next.showAlertDialogOnError(context));
    return ScaffoldX(
      titleCenter: true,
      wantLeading: true,
      title: 'Edit Shop',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SpacedColumn(
                  children: [
                    AppTextField(
                      controller: shopController,
                      hintText: 'Enter your shop name',
                      title: 'Shop name',
                    ),
                    AppAddressField(
                      address: address.value,
                      onChange: (addressX) => address.value = addressX,
                    ),
                  ],
                ),
              ),
            ),
            ButtonX.primaryButton(
              context: context,
              label: 'Save',
              loading: account.isLoading,
              onPressed: () => _handleSaveButtonPress(
                context: context,
                shopName: shopController.text,
                address: address.value,
                hPin: shopInfo['hPin'] ?? '',
                uId: shopInfo['uid'],
                ref: ref,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleSaveButtonPress({
    required BuildContext context,
    required String shopName,
    required Address address,
    required String hPin,
    required String uId,
    required WidgetRef ref,
  }) async {
    // Close keyboard and wait briefly
    await context.unfocusKeyboard();

    if (!context.mounted) return;
    submitShopDetails(
      shopName: shopName,
      address: address,
      context: context,
      updateShopDetails: () async {
        final shouldUpdate =
            await AppRoute.confirmPin.push(context, extra: hPin);
        if (shouldUpdate == true) {
          await ref
              .read(accountProvider.notifier)
              .updateShop(shopName: shopName, shopAddress: address, uid: uId);
          ref.invalidate(fetchUserProvider(documentId: uId));
          if (!context.mounted) return;
          showMessageSnackbar(
              context: context,
              message: 'Your shop info has been Updated!',
              maxLines: 2);
          StatefulNavigationShell.of(context)
              .goBranch(3, initialLocation: true);
        }
      },
    );
  }
}
