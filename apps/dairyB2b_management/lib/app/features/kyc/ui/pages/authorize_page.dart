import 'dart:async';

import 'package:auth/auth.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/kyc/providers/kyc_provider.dart';
import 'package:dairyB2b_management/app/features/kyc/providers/creating_profile_provider.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';

class Authorize extends HookConsumerWidget with CommonValidator {
  const Authorize({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uId = ref.read(phoneNoVerifyServiceProvider).currentUser?.uid;
    final kyc = ref.watch(adminEnrollProvider);
    final superuserName = ref.read(superuserNameHolder);
    final user = ref.watch(FetchUserStreamProvider(uId: uId ?? "Ghost"));
    final accessCodeController = useTextEditingController(text: '');
    return user.when(
      skipLoadingOnRefresh: false,
      data: (userData) => Padding(
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
                          'Please contact: $superuserName',
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
                        AuthorizeTimer(
                          afterTenMinFun: () async => await ref
                              .read(adminEnrollProvider.notifier)
                              .reSetAccessCode(uId: userData?.uid ?? 'Ghost')
                              .then(
                                (_) => showMessageSnackbar(
                                    context: context,
                                    message:
                                        'Access code has been reset. Please contact the App Management.',
                                    maxLines: 2),
                              ),
                          start: userData?.isGiven ?? false,
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
                        'Note: Please contact the App Management via call or message to get the access code.',
                        textAlign: TextAlign.center,
                        style: TextStyles.h8Gray(context),
                      ),
                      ButtonX.primaryButton(
                        context: context,
                        label: 'Submit Access Code',
                        loading: kyc.isLoading,
                        onPressed: userData?.isGiven ?? false
                            ? () => submitAccessCode(
                                context: context,
                                accessCode: userData!.accessCode,
                                code: accessCodeController.text,
                                verifyAccessCode: () => ref
                                    .read(adminEnrollProvider.notifier)
                                    .atAccessCode(userData: userData))
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

class AuthorizeTimer extends HookWidget {
  const AuthorizeTimer({
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
