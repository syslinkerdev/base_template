import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';

class Settings extends ConsumerWidget with CommonValidator {
  const Settings({super.key, required this.user});
  final UserX user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldX(
      titleCenter: true,
      wantLeading: true,
      title: 'Settings',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SpacedColumn(
            children: [
              SpacedColumn(
                defaultHeight: 12.0,
                children: [
                  ButtonX.containerButton(
                    context: context,
                    label: 'Open Orders',
                    icon: Icons.open_in_new,
                    iconFirst: true,
                    loading: false,
                    noAsyncLoading: true,
                    onPressed: () async {
                      try {
                        await AppLauncherService.openOrdersApp();
                      } catch (e) {
                        if (context.mounted) {
                          showMessageSnackbar(
                              context: context,
                              message: e.toString(),
                              maxLines: 2);
                        }
                      }
                    },
                  ),
                  // ButtonX.containerButton(
                  //   context: context,
                  //   label: 'Notifications',
                  //   icon: Icons.notifications,
                  //   iconFirst: true,
                  //   loading: false,
                  //   noAsyncLoading: true,
                  //   onPressed: () async =>
                  //       await AppRoute.comingSoon.push(context),
                  // ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Account Management',
                        style: TextStyles.h9Bold(context),
                      ),
                    ),
                  ),
                  ButtonX.containerButton(
                    context: context,
                    label: 'Log Out',
                    icon: Icons.logout,
                    iconFirst: true,
                    noAsyncLoading: true,
                    onPressed: () => DialogsX.askForConfirmation(
                      context,
                      dialogTheme: appColors.sc.mutedRed,
                      title: 'Log Out',
                      content: 'Are you sure you want to log out?',
                      cancelBtnText: 'Cancel',
                      confirmBtnText: 'Log Out',
                      onConfirm: (dialogCtx) async {
                        GlobalCacheService.instance.clearAll();
                        ref.read(appStateXProvider.notifier).logOut();
                        showMessageSnackbar(
                          context: context,
                          message:
                              '${user.phoneNumber} logged out. Please log in again.',
                          type: SnackBarType.success,
                          maxLines: 2,
                          duration: const Duration(seconds: 2),
                        );
                      },
                    ),
                  ),
                  ButtonX.containerButton(
                    context: context,
                    label: 'Delete Account',
                    icon: Icons.delete,
                    iconFirst: true,
                    loading: false,
                    noAsyncLoading: true,
                    onPressed: () => PhoneForAccessCode.dialog(
                      context,
                      title: 'Delete Account',
                      isDeleteAccount: true,
                      defaultOnPressed: (dialogCtx) {
                        //print('🔒 AccessCode dialog confirmed for deletion');
                        AppRoute.accessCodeVerification.push(
                          context,
                          extra: AccessCodeVerificationArgs(
                            phoneNo: user.phoneNumber.replaceAll('+91', ''),
                            user: user,
                            forDeleteAccount: (ref) async {
                              if (context.mounted) {
                                //print('📤 Navigating to soft delete screen...');
                                AppRoute.softDelete.go(
                                  context,
                                  extra: SoftDeleteArgs(
                                    user: user,
                                    afterSoftDeleteProcess: (refA) {
                                      //print(
                                      // '✅ afterSoftDeleteProcess triggered');
                                      //print('➡️ resetToInitial...');
                                      refA
                                          .read(appStateXProvider.notifier)
                                          .resetToInitial();
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        );
                        //print('📕 Closing access code dialog');
                        dialogCtx.close(true);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
