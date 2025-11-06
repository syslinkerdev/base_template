import 'package:auth/src/access_code/ui/widgets/phone_for_access_code.dart';
import 'package:auth/src/log_in/providers/log_in_provider.dart';
import 'package:auth/src/phone_verification/providers/phone_no_verify_provider.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';

class LogInArgs {
  final void Function(String uId, Role role) onLogInSuccess;
  final void Function(BuildContext context, String phoneNoForAccessCode)
      phoneForAccessCodePress;
  LogInArgs({
    required this.onLogInSuccess,
    required this.phoneForAccessCodePress,
  });
}

class LogIn extends HookConsumerWidget with CommonValidator, PINValidator {
  const LogIn(
      {super.key,
      required this.onLogInSuccess,
      required this.phoneForAccessCodePress});
  final void Function(String uId, Role role) onLogInSuccess;
  final void Function(BuildContext context, String phoneNoForAccessCode)
      phoneForAccessCodePress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorX = appColors.cS(context).surfaceTint;
    final verifyState = ref.watch(phoneNoVerifyProvider);
    final phoneNumber = verifyState.value?.phoneNumber;
    //print('phoneNumber -LogIn- ${phoneNumber}');
    final pinController = useTextEditingController(text: '');
    final phoneNoController = useTextEditingController(text: phoneNumber);
    final phoneNoControllerForAccessCode =
        useTextEditingController(text: phoneNumber);
    final showPIN = useState(false);

    ref.listen(
        logInXProvider, (_, next) => next.showAlertDialogOnError(context));

    return ScaffoldX(
      title: 'Log In',
      titleCenter: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SpacedColumn(
                  divider: gapH8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: context.sizeOfWidth * 0.7,
                        child: Text(
                            'Please enter your register phone number and your pin.',
                            style: TextStyles.h8Gray(context),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    CaptionText(title: 'Phone number'),
                    PhoneNumberField(
                      phoneNoController: phoneNoController,
                      readOnly: phoneNumber.containsValidValue ? true : false,
                      onTap: () {
                        if (phoneNumber.containsValidValue) {
                          showMessageSnackbar(
                            context: context,
                            message: 'Enter your PIN to continue',
                          );
                        } else {
                          return;
                        }
                      },
                    ),
                    PinField(
                      obscureText: showPIN.value,
                      controller: pinController,
                      title: 'Pin',
                      onEyeTap: () => showPIN.value = !showPIN.value,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          phoneNoControllerForAccessCode.text =
                              phoneNoController.text;
                          PhoneForAccessCode.dialog(context,
                              title: 'Forgot PIN?',
                              readOnly: phoneNumber.containsValidValue,
                              phoneNoController: phoneNoControllerForAccessCode,
                              defaultOnPressed: (dialogCtx) => phoneNoValidator(
                                    context: context,
                                    phoneNo:
                                        phoneNoControllerForAccessCode.text,
                                    toProceed: () async {
                                      phoneForAccessCodePress(dialogCtx,
                                          phoneNoControllerForAccessCode.text);
                                      dialogCtx.close(true);
                                    },
                                  ));
                        },
                        child: Text('Forgot PIN?',
                            style: TextStyles.h8Gray(context)?.copyWith(
                                color: colorX,
                                decoration: TextDecoration.underline,
                                decorationColor: colorX)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonX.primaryButton(
              context: context,
              label: 'Log In',
              loading: ref.watch(logInXProvider).isLoading,
              onPressed: () => phoneNoValidator(
                context: context,
                phoneNo: phoneNoController.text,
                toProceed: () => confirmPin(
                  context: context,
                  confirmPIN: pinController.text,
                  toConfirmPin: () async => await ref
                      .read(logInXProvider.notifier)
                      .logIn(
                          phoneNumber: phoneNoController.text,
                          userTypedPIN: pinController.text,
                          onSuccess: onLogInSuccess),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
