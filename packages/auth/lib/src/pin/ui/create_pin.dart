import 'package:auth/src/pin/providers/pin_provider.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_assets/app_images.dart';
import 'package:core/core.dart';

class CreatePinArgs {
  final String uId;
  final void Function(WidgetRef ref) onSuccess;

  CreatePinArgs({
    required this.uId,
    required this.onSuccess,
  });
}

class CreatePin extends HookConsumerWidget with PINValidator {
  const CreatePin({super.key, required this.uId, required this.onSuccess});
  final String uId;
  final void Function(WidgetRef ref) onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createPinController = useTextEditingController(text: '');
    final showCreatePIN = useState(false);
    final showConfirmPIN = useState(false);
    final confirmPinController = useTextEditingController(text: '');
    final pin = ref.watch(pinProvider);
    return ErrorListenerWidget<void>(
      provider: pinProvider,
      child: ScaffoldX(
        title: 'Create PIN',
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!pin.isLoading) ...[
                  Align(
                    alignment: Alignment.topCenter,
                    child: sysImages.createPIN
                        .toWidget(height: context.sizeOfHeight * 0.2),
                  ),
                  gapH4,
                  PinField(
                    obscureText: showCreatePIN.value,
                    controller: createPinController,
                    title: 'Create a PIN',
                    onPinPutTap: () {
                      showCreatePIN.value = false;
                      if (confirmPinController.text.isNotEmpty) {
                        confirmPinController.text = '';
                      }
                    },
                    onEyeTap: () => showCreatePIN.value = !showCreatePIN.value,
                  ),
                  gapH24,
                  PinField(
                    obscureText: showConfirmPIN.value,
                    controller: confirmPinController,
                    title: 'Confirm PIN',
                    onPinPutTap: () {
                      if (createPinController.text.length == 4) {
                        showCreatePIN.value = true;
                      }
                    },
                    onEyeTap: () =>
                        showConfirmPIN.value = !showConfirmPIN.value,
                  ),
                ],
                if (pin.isLoading) ...[
                  sysImages.processing.toWidget(),
                ],
              ],
            ),
          ),
        ),
        floatingActionButton: ButtonX(
          label: 'Confirm PIN',
          fakeLoadingDuration: 200,
          icon: Icons.arrow_forward_rounded,
          loading: pin.isLoading,
          onPressed: () async {
            if (createPinController.text.length == 4 &&
                confirmPinController.text.length == 4) {
              showCreatePIN.value = false;
              showConfirmPIN.value = false;
            }
            await createPINValidator(
              context: context,
              createPIN: createPinController.text,
              confirmPIN: confirmPinController.text,
              toCreatePIN: () => ref.read(pinProvider.notifier).createPIN(
                  finalPIN: confirmPinController.text,
                  uId: uId,
                  onSuccess: () => onSuccess(ref)),
            );
          },
        ),
      ),
    );
  }
}
