import 'package:auth/src/phone_verification/providers/phone_no_verify_provider.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_assets/app_images.dart';

class PhoneInputScreenArgs {
  final void Function(BuildContext context) onCodeSent;
  final bool forAdmin;

  PhoneInputScreenArgs({required this.onCodeSent, this.forAdmin = false});
}

class PhoneInputScreen extends HookConsumerWidget with SignInValidator {
  const PhoneInputScreen(
      {super.key, required this.onCodeSent, this.forAdmin = false});
  final void Function(BuildContext context) onCodeSent;
  final bool forAdmin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNoController = useTextEditingController();
    final isFocused = useState(false);
    final focusNode = useFocusNode();
    final verifyState = ref.watch(phoneNoVerifyProvider);
    final isLoading = verifyState.value?.longLoading ?? false;
    final mainImage = forAdmin ? sysImages.relaxation : sysImages.welcome;

    ref.listen(phoneNoVerifyProvider,
        (_, next) => next.showAlertDialogOnError(context));

    useEffect(() {
      void listener() {
        if (focusNode.hasFocus) {
          Future.delayed(const Duration(milliseconds: 20), () {
            isFocused.value = true;
          });
        } else {
          isFocused.value = false;
        }
      }

      focusNode.addListener(listener);
      return () => focusNode.removeListener(listener);
    }, []);

    return ScaffoldX(
      appToolbarHeight: 0,
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Section
                    Expanded(
                      child: Column(
                        children: [
                          gapH32,
                          // ⬇ Fade + Collapse image smoothly
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: AnimatedOpacity(
                              opacity: isFocused.value ? 0 : 1,
                              duration: const Duration(milliseconds: 300),
                              child: isFocused.value
                                  ? const SizedBox.shrink()
                                  : mainImage.toWidget(
                                      height: context.sizeOfHeight * 0.3),
                            ),
                          ),
                          gapH16,
                          // ⬇ Smooth text alignment
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 300),
                            alignment: isFocused.value
                                ? Alignment.centerLeft
                                : Alignment.center,
                            curve: Curves.easeInOut,
                            child: Text(
                              "Welcome to ${AppEnv.companyName} 👋",
                              style: TextStyles.h5Bold(context),
                              textAlign: isFocused.value
                                  ? TextAlign.left
                                  : TextAlign.center,
                            ),
                          ),
                          gapH8,
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 300),
                            alignment: isFocused.value
                                ? Alignment.centerLeft
                                : Alignment.center,
                            curve: Curves.easeInOut,
                            child: Text(
                              "Let\'s verify your phone number to get started.",
                              style: TextStyles.h7Gray(context),
                              textAlign: isFocused.value
                                  ? TextAlign.left
                                  : TextAlign.center,
                            ),
                          ),
                          gapH24,
                          // ⬇ Input stays stable
                          PhoneNumberField(
                              labelText: 'Phone number',
                              phoneNoController: phoneNoController,
                              focusNode: focusNode),
                        ],
                      ),
                    ),

                    // Bottom Section
                    Column(
                      children: [
                        ButtonX.primaryButton(
                          context: context,
                          label: isLoading ? 'Sending...' : 'Send OTP',
                          loading: ref.watch(phoneNoVerifyProvider).isLoading,
                          onPressed: () async {
                            await context.unfocusKeyboard(milliseconds: 400);
                            submitPhoneNumber(
                              phoneNumber: phoneNoController.text,
                              verifyPhoneNumber: () async => await ref
                                  .read(phoneNoVerifyProvider.notifier)
                                  .verifyPhoneNumber(
                                    phoneNumber: phoneNoController.text,
                                    codeSent: (__, _) => onCodeSent(context),
                                  ),
                            );
                          },
                        ),
                        gapH8,
                        Text(
                          "You\'ll receive a 6-digit code via SMS to verify your number.",
                          textAlign: TextAlign.center,
                          style: TextStyles.h14Gray(context),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isLoading
                ? Container(
                    key: const ValueKey('loader'),
                    width: double.infinity,
                    height: double.infinity,
                    color: appColors.ms.transparent80(context),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink(key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }
}
