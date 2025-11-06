import 'package:auth/src/pin/providers/pin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';

class ConfirmPin extends HookConsumerWidget with PINValidator {
  const ConfirmPin({super.key, required this.currentPinHash});
  final String currentPinHash;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinController = useTextEditingController(text: '');
    final showPIN = useState(false);
    final pin = ref.watch(pinProvider);
    return ErrorListenerWidget<void>(
      provider: pinProvider,
      child: ScaffoldX(
          title: 'Confirm PIN',
          wantLeading: true,
          titleCenter: true,
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Verify your Pin', style: TextStyles.h6Bold(context)),
                gapH8,
                Text('Last step: Enter your pin to complete the change.',
                    style: TextStyles.h12Gray(context),
                    textAlign: TextAlign.center),
                gapH24,
                PinField(
                  obscureText: showPIN.value,
                  controller: pinController,
                  title: 'Pin',
                  onPinPutTap: () => showPIN.value = false,
                  onEyeTap: () => showPIN.value = !showPIN.value,
                ),
                gapH24,
                ButtonX(
                  height: context.sizeOfHeight * 0.056,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0)),
                  scale: true,
                  label: 'Done',
                  loading: pin.isLoading,
                  onPressed: () => confirmPin(
                    context: context,
                    confirmPIN: pinController.text,
                    toConfirmPin: () => ref.read(pinProvider.notifier).checkPIN(
                        currentPIN: pinController.text,
                        currentPinHash: currentPinHash,
                        context: context),
                  ),
                )
              ],
            ),
          )),
    );
  }
}


// How to use :
    // submitShopDetails(
    //   shopName: shopName,
    //   address: address,
    //   context: context,
    //   updateShopDetails: () async {
    //     final shouldUpdate =
    //         await AppRoute.confirmPin.push(context, extra: hPin);
    //     if (shouldUpdate == true) {
    //       await ref
    //           .read(accountProvider.notifier)
    //           .updateShop(shopName: shopName, shopAddress: address, uid: uId);
    //       ref.invalidate(fetchUserProvider(documentId: uId));
    //       if (!context.mounted) return;
    //       showMessageSnackbar(
    //           context: context, message: 'Your shop info has been Updated!');
    //       StatefulNavigationShell.of(context)
    //           .goBranch(3, initialLocation: true);
    //     }
    //   },
    // );