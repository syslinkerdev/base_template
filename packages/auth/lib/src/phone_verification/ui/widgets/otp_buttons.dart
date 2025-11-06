import 'dart:async';
import 'package:auth/src/phone_verification/phone_no_verify_service.dart';
import 'package:auth/src/phone_verification/providers/phone_no_verify_provider.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OtpButtons extends ConsumerWidget {
  const OtpButtons({
    super.key,
    required this.onPressed,
    required this.resendCode,
  });

  final VoidCallback onPressed;
  final VoidCallback resendCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(phoneNoVerifyProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResendButton(resendCode: resendCode),
        const SizedBox(height: 12),
        ButtonX.primaryButton(
          context: context,
          label: "Verify & Continue",
          loading: state.value?.longLoading ?? false,
          onPressed: onPressed,
        ),
      ],
    );
  }
}

class ResendButton extends HookConsumerWidget {
  const ResendButton({super.key, required this.resendCode});
  final VoidCallback resendCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifyState = ref.watch(phoneNoVerifyProvider).value;
    final otpStart = verifyState?.otpStartTime;
    final secondsLeft = useState(0);

    useEffect(() {
      Timer? timer;
      void tick() {
        if (otpStart == null) {
          secondsLeft.value = 0;
          return;
        }
        final elapsed = DateTime.now().difference(otpStart).inSeconds;
        final remaining =
            (kOtpTimeoutSeconds - elapsed).clamp(0, kOtpTimeoutSeconds);
        secondsLeft.value = remaining;
      }

      tick(); // initial
      timer = Timer.periodic(const Duration(seconds: 1), (_) => tick());

      return () => timer?.cancel();
    }, [otpStart]);

    return ButtonX.primaryButton(
      context: context,
      onPressed: secondsLeft.value > 0 ? null : () => resendCode(),
      label: secondsLeft.value > 0
          ? 'Resend OTP after: ${secondsLeft.value} sec.'
          : 'Resend OTP',
    );
  }
}
