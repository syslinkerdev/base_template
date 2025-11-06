import 'dart:async';

import 'package:auth/auth.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/kyc/kyc_service.dart';
import 'package:dairyB2b_orders/app/features/kyc/providers/kyc_provider.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';

class AuthorizeAccessCodePage extends HookConsumerWidget with CommonValidator {
  const AuthorizeAccessCodePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uId = ref.read(phoneNoVerifyServiceProvider).currentUser?.uid;
    final kyc = ref.watch(kycProvider);
    final client = ref.watch(FetchUserStreamProvider(uId: uId ?? "Ghost"));
    final superuserName = ref.read(superuserNameHolder);
    final accessCodeController = useTextEditingController(text: '');
    return client.when(
      skipLoadingOnRefresh: false,
      data: (clientData) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Chosen admin : $superuserName',
                          textAlign: TextAlign.center,
                          style: TextStyles.h8Gray(context),
                        ),
                        gapH16,
                        PinPutField(
                          otpErrorText: accessErrorText,
                          controller: accessCodeController,
                          onCompleted: (accessCode) {},
                        ),
                        gapH16,
                        KycTimer(
                          afterTenMinFun: () async =>
                              StepperPageViewXCtr.instance.previousPage(),
                          start: clientData?.isGiven ?? false,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Enter Your Access Code.',
                        textAlign: TextAlign.center,
                        style: TextStyles.h3Bold(context),
                      ),
                      Text(
                        'Note: Please contact the chosen admin via call or message to get the access code.',
                        textAlign: TextAlign.center,
                        style: TextStyles.h8Gray(context),
                      ),
                      ButtonX.primaryButton(
                        context: context,
                        label: 'Submit Access Code',
                        loading: kyc.isLoading,
                        onPressed: clientData?.isGiven ?? false
                            ? () => submitAccessCode(
                                context: context,
                                accessCode: clientData!.accessCode,
                                code: accessCodeController.text,
                                verifyAccessCode: () => ref
                                    .read(kycProvider.notifier)
                                    .atAccessCode(clientData: clientData))
                            : null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            color: appColors.ms.textBlack50(context),
                            size: 16,
                          ),
                          gapW4,
                          Text(
                            'Most people finish this step under 5 minutes.',
                            textAlign: TextAlign.center,
                            style: TextStyles.h10Gray(context),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        debugPrintStack(stackTrace: stackTrace);
        return ErrorScreen(
            error: error,
            onRetry: () =>
                ref.watch(FetchUserStreamProvider(uId: uId ?? "Ghost").future));
      },
    );
  }
}

class KycTimer extends HookWidget {
  const KycTimer({
    super.key,
    required this.afterTenMinFun,
    required this.start,
  });
  final void Function() afterTenMinFun;
  final bool start;

  @override
  Widget build(BuildContext context) {
    final timer = useState<Timer?>(null);
    final seconds = useState<int>(600); // 10 minutes in seconds 600

    void startTimer() {
      if (start) {
        timer.value?.cancel();
        timer.value = Timer.periodic(const Duration(seconds: 1), (_) {
          if (seconds.value > 0) {
            seconds.value--;
          } else {
            timer.value?.cancel();
            afterTenMinFun();
          }
        });
      }
    }

    useEffect(() {
      startTimer();
      // Cancel the timer when the widget is disposed
      return timer.value?.cancel;
    }, [start]); // Add startAccessCodeTimer as a dependency

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        start
            ? Text(
                'Time remaining: ${seconds.value ~/ 60}:${(seconds.value % 60).toString().padLeft(2, '0')} min\'s',
                textAlign: TextAlign.end,
                style: TextStyles.h8Bold(context),
              )
            : Text(
                'Call chosen admin and get access code!',
                textAlign: TextAlign.end,
                style: TextStyles.h8Bold(context),
              ),
      ],
    );
  }
}
