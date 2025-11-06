import 'package:auth/src/pin/providers/pin_provider.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:core/core.dart';

class ForgotPinArgs {
  final String uId;
  final void Function(BuildContext ctx) onSuccess;
  ForgotPinArgs({required this.uId, required this.onSuccess});
}

class ForgotPin extends HookConsumerWidget with PINValidator {
  const ForgotPin({super.key, required this.uId, required this.onSuccess});

  final String uId;
  final void Function(BuildContext ctx) onSuccess;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newPinController = useTextEditingController(text: '');
    final confirmPinController = useTextEditingController(text: '');
    final showNewPIN = useState(false);
    final showConfirmPIN = useState(false);
    final pin = ref.watch(pinProvider);
    return ErrorListenerWidget<void>(
      provider: pinProvider,
      child: ScaffoldX(
        title: 'Forgot PIN',
        titleCenter: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: context.sizeOfWidth * 0.7,
                          child: Text(
                              'Please enter your new PIN and confirm it.',
                              style: TextStyles.h8Gray(context),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      PinField(
                        obscureText: showNewPIN.value,
                        controller: newPinController,
                        title: 'New Pin',
                        onPinPutTap: () {
                          showNewPIN.value = false;
                          if (confirmPinController.text.isNotEmpty) {
                            confirmPinController.text = '';
                          }
                        },
                        onEyeTap: () => showNewPIN.value = !showNewPIN.value,
                      ),
                      gapH24,
                      PinField(
                        obscureText: showConfirmPIN.value,
                        controller: confirmPinController,
                        title: 'confirm Pin',
                        onPinPutTap: () {
                          if (newPinController.text.length == 4) {
                            showNewPIN.value = true;
                          }
                        },
                        onEyeTap: () =>
                            showConfirmPIN.value = !showConfirmPIN.value,
                      ),
                    ],
                  ),
                ),
              ),
              ButtonX.primaryButton(
                  context: context,
                  label: 'Create New Pin',
                  loading: pin.isLoading,
                  onPressed: () => forgotPINValidator(
                      context: context,
                      newPIN: newPinController.text,
                      confirmPIN: confirmPinController.text,
                      updateNewPIN: () => ref
                          .read(pinProvider.notifier)
                          .forgotPIN(
                              finalPIN: confirmPinController.text,
                              uId: uId,
                              onSuccess: () => onSuccess(context))))
            ],
          ),
        ),
      ),
    );
  }
}
