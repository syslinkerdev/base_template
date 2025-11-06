import 'package:auth/src/phone_verification/providers/phone_no_verify_provider.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'widgets/otp_buttons.dart';
import 'widgets/otp_field.dart';

class OtpInputScreenArgs {
  final bool giveOptionToChangePhoneNo;
  final void Function(WidgetRef ref) onUserNotPresent;
  final void Function(UserX user, WidgetRef ref) onUserPresent;
  final void Function(UserX deletedUser, WidgetRef ref) onDeletedUserFound;

  OtpInputScreenArgs(
      {this.giveOptionToChangePhoneNo = true,
      required this.onUserNotPresent,
      required this.onUserPresent,
      required this.onDeletedUserFound});
}

class OtpInputScreen extends HookConsumerWidget with SignInValidator {
  const OtpInputScreen(
      {super.key,
      this.giveOptionToChangePhoneNo = true,
      required this.onUserNotPresent,
      required this.onUserPresent,
      required this.onDeletedUserFound});
  final bool giveOptionToChangePhoneNo;
  final void Function(WidgetRef ref) onUserNotPresent;
  final void Function(UserX user, WidgetRef ref) onUserPresent;
  final void Function(UserX deletedUser, WidgetRef ref) onDeletedUserFound;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = useTextEditingController(text: '');
    final verifyState = ref.watch(phoneNoVerifyProvider);
    final verifyNotifier = ref.read(phoneNoVerifyProvider.notifier);
    final phoneNumber = verifyState.value?.phoneNumber;
    return ScaffoldX(
      title: 'Verify Your Phone',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            OtpField(
              otpController: otpController,
              numberToShow: phoneNumber ?? 'Unknown',
            ),
            const Spacer(),
            OtpButtons(
              onPressed: () => submitOtpCode(
                  otpCode: otpController.text,
                  verifyOtpCode: () {
                    print('object');
                    return verifyNotifier.verifyOtpCode(
                      otpCode: otpController.text,
                      onUserPresent: (user) => onUserPresent(user, ref),
                      onUserNotPresent: () => onUserNotPresent(ref),
                      onDeletedUserFound: (deletedUser) =>
                          onDeletedUserFound(deletedUser, ref),
                    );
                  }),
              resendCode: () {
                if (phoneNumber != null) {
                  verifyNotifier.verifyPhoneNumber(
                    phoneNumber: phoneNumber,
                    codeSent: (vId, _) => showMessageSnackbar(
                        context: context,
                        message: 'OTP resent to $phoneNumber'),
                  );
                }
              },
            ),
            if (verifyState.value?.otpTimedOut == true &&
                giveOptionToChangePhoneNo) ...[
              gapH20,
              Text.rich(
                TextSpan(
                  text: "Wrong number? ",
                  children: [
                    TextSpan(
                      text: "Change it",
                      style: TextStyles.h10Bold(context)?.copyWith(
                          color: appColors.cS(context).surfaceTint,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pop();
                          verifyNotifier.reset();
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
