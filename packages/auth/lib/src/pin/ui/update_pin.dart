import 'package:auth/src/pin/pin_service.dart';
import 'package:auth/src/pin/providers/pin_provider.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:repo/repo.dart';
import 'package:core/core.dart';

class UpdatePin extends HookConsumerWidget with PINValidator {
  const UpdatePin({super.key, required this.hPinAndUid});
  final Map<String, dynamic> hPinAndUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPinController = useTextEditingController(text: '');
    final showCurrentPIN = useState(false);
    final showNewPIN = useState(false);
    final service = ref.read(pinServiceProvider);
    final newPinController = useTextEditingController(text: '');
    final pin = ref.watch(pinProvider);

    return ErrorListenerWidget<void>(
      provider: pinProvider,
      child: ScaffoldX(
        title: 'Update PIN',
        wantLeading: true,
        titleCenter: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: context.sizeOfWidth * 0.7,
                        child: Text(
                            'Please enter your existing pin and your new pin.',
                            style: TextStyles.h8Gray(context),
                            textAlign: TextAlign.center),
                      ),
                      PinField(
                        obscureText: showCurrentPIN.value,
                        controller: currentPinController,
                        title: 'Current Pin',
                        onPinPutTap: () {
                          showCurrentPIN.value = false;
                          if (newPinController.text.isNotEmpty) {
                            newPinController.text = '';
                          }
                        },
                        onEyeTap: () =>
                            showCurrentPIN.value = !showCurrentPIN.value,
                      ),
                      gapH24,
                      PinField(
                        obscureText: showNewPIN.value,
                        controller: newPinController,
                        title: 'New Pin',
                        onPinPutTap: () {
                          if (currentPinController.text.length == 4) {
                            showCurrentPIN.value = true;
                          }
                        },
                        onEyeTap: () => showNewPIN.value = !showNewPIN.value,
                      ),
                    ],
                  ),
                ),
              ),
              ButtonX.primaryButton(
                context: context,
                label: 'Change Pin',
                loading: pin.isLoading,
                onPressed: () => changePINValidator(
                  context: context,
                  currentPIN: currentPinController.text,
                  newPIN: newPinController.text,
                  checkCurrentPIN: () => service.checkPIN(
                      currentPIN: currentPinController.text,
                      currentPinHash: hPinAndUid['hPin']),
                  updateNewPIN: () => ref
                      .read(pinProvider.notifier)
                      .updatePIN(
                          finalPIN: newPinController.text,
                          uId: hPinAndUid['uid'])
                      .then(
                    (value) {
                      ref.invalidate(
                          fetchUserProvider(documentId: hPinAndUid['uid']));
                      if (context.mounted) {
                        showMessageSnackbar(
                            context: context,
                            message: 'Your PIN has been Updated!');
                        StatefulNavigationShell.of(context)
                            .goBranch(3, initialLocation: true);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
