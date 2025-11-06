import 'dart:async';

import 'package:auth/src/access_code/providers/access_code_provider.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';

class AccessCodeVerificationArgs {
  final String phoneNo;
  final UserX? user;
  final void Function(BuildContext context, String uId)? forForgotPIN;
  final void Function(WidgetRef ref)? forDeleteAccount;
  AccessCodeVerificationArgs(
      {required this.phoneNo,
      this.user,
      this.forForgotPIN,
      this.forDeleteAccount});
}

class AccessCodeVerification extends HookConsumerWidget with CommonValidator {
  const AccessCodeVerification(
      {super.key,
      required this.phoneNo,
      this.user,
      this.forForgotPIN,
      this.forDeleteAccount});
  final String phoneNo;
  final UserX? user;
  final void Function(BuildContext context, String uId)? forForgotPIN;
  final void Function(WidgetRef ref)? forDeleteAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFetch = ref.watch(
        FetchUserByComparisonPhoneStreamProvider(phoneNumber: '+91$phoneNo'));

    final accessCodeState = ref.watch(accessCodeProvider);

    final accessCodeController = useTextEditingController(text: '');
    return ErrorListenerWidget(
      provider: accessCodeProvider,
      child: ScaffoldX(
        title: 'Access Code Verification',
        titleCenter: true,
        usePopScope: true,
        canPop: () => false,
        onPopInvokedWithResult: (didPop, _) async {
          if (!didPop) {
            await backFun(context, ref, userFetch);
          }
        },
        body: userFetch.when(
          skipLoadingOnRefresh: false,
          data: (userData) {
            if (userData == null) {
              return Center(
                child: SpacedColumn(
                  defaultHeight: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone_android,
                      size: context.sizeOfHeight * 0.12,
                      color: appColors.sc.grey650,
                    ),
                    gapH20,
                    Text(
                      'No user found for this number',
                      style: TextStyles.h6(context),
                      textAlign: TextAlign.center,
                    ),
                    gapH8,
                    Text(
                      'You entered: $phoneNo',
                      style: TextStyles.h8Gray(context),
                      textAlign: TextAlign.center,
                    ),
                    gapH12,
                    Text(
                      'Please check the number and try again.',
                      style: TextStyles.h8Gray(context),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            final superRoleInString =
                RoleConverter.toJson(userData.role ?? Role.admin);
            return Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpacedColumn(
                        defaultHeight: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CaptionText(title: 'Phone number'),
                          PhoneNumberField(
                              hintText: 'Phone number',
                              phoneNoController: TextEditingController(
                                  text: phoneNo.replaceAll('+91', '')),
                              readOnly: true),
                          CaptionText(title: 'Access code'),
                          PinPutField(
                            otpErrorText: accessErrorText,
                            controller: accessCodeController,
                            onCompleted: (accessCode) {},
                          ),
                          gapH8,
                          AccessCodeTimer(
                            start: userData.isGiven,
                            role: superRoleInString,
                            afterTenMinFun: () async {
                              if ((userData.isGiven) == true) {
                                await ref
                                    .read(accessCodeProvider.notifier)
                                    .reSetAccessCode(uId: userData.uid)
                                    .then((_) {
                                  context.pop();
                                });
                              } else {
                                context.pop();
                              }
                            },
                          ),
                        ],
                      ),
                      SpacedColumn(
                        children: [
                          SpacedRow(
                            children: [
                              ButtonX.outlineButton(
                                  context: context,
                                  noAsyncLoading: true,
                                  label: forForgotPIN != null
                                      ? 'Don\'t Reset'
                                      : 'Go back',
                                  onPressed: () async =>
                                      await backFun(context, ref, userFetch)),
                              ButtonX.primaryButton(
                                context: context,
                                label: forForgotPIN != null
                                    ? 'Reset PIN'
                                    : 'Delete',
                                onPressed: userData.isGiven
                                    ? () async {
                                        if (!context.mounted) return;
                                        await submitAccessCode(
                                          context: context,
                                          code: userData.accessCode,
                                          accessCode: accessCodeController.text,
                                          verifyAccessCode: () async {
                                            if (forForgotPIN != null &&
                                                forDeleteAccount == null) {
                                              if (!accessCodeState.hasError) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  forForgotPIN!(
                                                      context, userData.uid);
                                                });
                                                await ref
                                                    .read(accessCodeProvider
                                                        .notifier)
                                                    .reSetAccessCode(
                                                        uId: userData.uid);
                                              }
                                            } else if (forForgotPIN == null &&
                                                forDeleteAccount != null) {
                                              if (!accessCodeState.hasError) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  forDeleteAccount!(ref);
                                                });
                                                await ref
                                                    .read(accessCodeProvider
                                                        .notifier)
                                                    .reSetAccessCode(
                                                        uId: userData.uid);
                                              }
                                            }
                                          },
                                        );
                                      }
                                    : null,
                              ),
                            ],
                          ),
                          Text(
                            'Note: Please contact the $superRoleInString via call or message to get the access code.',
                            textAlign: TextAlign.center,
                            style: TextStyles.h12Gray(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: accessCodeState.isLoading
                      ? Container(
                          key: const ValueKey('loader'),
                          width: double.infinity,
                          height: double.infinity,
                          color: appColors.ms.transparent80(context),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
              ],
            );
          },
          loading: () => LoadingScreen(),
          error: (error, stackTrace) {
            debugPrintStack(stackTrace: stackTrace);
            return ErrorScreen(
                error: error,
                onRetry: () => ref.watch(
                    FetchUserByComparisonPhoneStreamProvider(
                            phoneNumber: phoneNo)
                        .future));
          },
        ),
      ),
    );
  }

  Future<void> backFun(
      BuildContext context, WidgetRef ref, AsyncValue<UserX?> userFetch) async {
    final confirmExit = await DialogsX.askForConfirmation(context,
        title: "Exit App?",
        content: "Are you sure you want to go back?",
        cancelBtnText: 'No',
        confirmBtnText: 'Yes');
    if (confirmExit) {
      if ((userFetch.value?.isGiven) == true) {
        await ref
            .read(accessCodeProvider.notifier)
            .reSetAccessCode(uId: userFetch.value?.uid ?? user?.uid ?? '')
            .then((_) {
          context.pop();
        });
      } else {
        context.pop();
      }
    }
  }
}

class AccessCodeTimer extends HookWidget {
  const AccessCodeTimer(
      {super.key,
      required this.afterTenMinFun,
      required this.start,
      required this.role});
  final void Function() afterTenMinFun;
  final bool start;
  final String role;

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
                'Call Your $role and get access code!',
                textAlign: TextAlign.end,
                style: TextStyles.h8Bold(context),
              ),
      ],
    );
  }
}
