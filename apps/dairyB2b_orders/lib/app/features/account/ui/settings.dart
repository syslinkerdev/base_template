import 'package:auth/auth.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';

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
              _SettingSubtitles(
                  title: 'Account information',
                  onPressed: () => AppRoute.editAccount.push(context, extra: {
                        'avatar': user.avatar,
                        'fName': user.firstName,
                        'lName': user.lastName,
                        'phone': user.phoneNumber,
                        'hPin': user.hashedPassword,
                        'uid': user.uid,
                        'role': user.role
                      })),
              ContainerX(
                  margin: EdgeInsets.zero,
                  child: SpacedColumn(
                      divider: Divider(
                          color: appColors.ms.greyTransparent80(context)),
                      children: [
                        _DataShowTile(
                            title: 'Avatar',
                            trailingWidget: SizedBox(
                                width: context.sizeOfWidth * 0.07,
                                height: context.sizeOfWidth * 0.07,
                                child:
                                    CircularImageAvatar(image: user.avatar))),
                        _DataShowTile(
                            title: 'First Name', trailing: user.firstName),
                        _DataShowTile(
                            title: 'Last Name', trailing: user.lastName),
                        _DataShowTile(
                            title: 'Phone',
                            trailing: '${user.phoneNumber.phoneNoFormat}'),
                      ])),
              _SettingSubtitles(
                  title: 'Shop information',
                  onPressed: () => AppRoute.editShop.push(context, extra: {
                        'name': user.shopName,
                        'address': user.shopAddress,
                        'hPin': user.hashedPassword,
                        'uid': user.uid
                      })),
              ContainerX(
                margin: EdgeInsets.zero,
                child: (user.shopName.isNotEmpty &&
                        user.shopAddress.street.isNotEmpty)
                    ? SpacedColumn(
                        divider: Divider(
                          color: appColors.ms.greyTransparent80(context),
                        ),
                        children: [
                          _DataShowTile(
                            title: 'Shop Name',
                            trailing: user.shopName,
                          ),
                          _DataShowTile(
                            title: 'Shop Address',
                            trailing: user.shopAddress.street.length <= 16
                                ? '${user.shopAddress.buildingNumber}/${user.shopAddress.street}'
                                : user.shopAddress.buildingNumber,
                          ),
                        ],
                      )
                    : SpacedColumn(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('⚠️ Please add your shop details to continue.',
                              style: TextStyles.h10(context)),
                          gapH8,
                          ButtonX(
                              label: 'Add Shop Details',
                              icon: Icons.edit_location_alt,
                              iconFirst: true,
                              onPressed: () =>
                                  AppRoute.editShop.push(context, extra: {
                                    'name': user.shopName,
                                    'address': user.shopAddress,
                                    'hPin': user.hashedPassword,
                                    'uid': user.uid
                                  })),
                        ],
                      ),
              ),
              _SettingSubtitles(
                  title: 'Pin',
                  onPressed: () => AppRoute.updatePin.push(context,
                      extra: {'hPin': user.hashedPassword, 'uid': user.uid})),
              const ContainerX(
                  margin: EdgeInsets.zero,
                  child: _DataShowTile(title: 'Pin', trailing: '****')),
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
              SpacedColumn(defaultHeight: 12.0, children: [
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
                          content: 'Are you sure you want to logout?',
                          cancelBtnText: 'Cancel',
                          confirmBtnText: 'Log Out',
                          onConfirm: (dialogCtx) async {
                            await ref.read(cartProvider.notifier).clearCart();
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
                            //print('📕 Closing access code dialog');
                            dialogCtx.close(true);
                          },
                        )),
                if (user.role == Role.client) ...[
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
                        AppRoute.accessCodeVerification.push(
                          context,
                          extra: AccessCodeVerificationArgs(
                            phoneNo: user.phoneNumber.replaceAll('+91', ''),
                            user: user,
                            forDeleteAccount: (ref) async {
                              await ref.read(cartProvider.notifier).clearCart();
                              if (context.mounted) {
                                AppRoute.softDelete.go(
                                  context,
                                  extra: SoftDeleteArgs(
                                    user: user,
                                    afterSoftDeleteProcess: (refA) => refA
                                        .read(appStateXProvider.notifier)
                                        .resetToInitial(),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                        dialogCtx.close(true);
                      },
                    ),
                  ),
                ],
                if (user.role != Role.client) ...[
                  ButtonX.containerButton(
                    context: context,
                    label: 'Open Management',
                    icon: Icons.open_in_new,
                    iconFirst: true,
                    loading: false,
                    noAsyncLoading: true,
                    onPressed: () async {
                      try {
                        await AppLauncherService.openManagementApp();
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
                ],
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class _DataShowTile extends StatelessWidget {
  final String title;

  final String? trailing;
  final Widget? trailingWidget;

  const _DataShowTile({
    required this.title,
    this.trailing,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.h8Bold(context),
        ),
        if (trailingWidget != null && trailing != null) ...[
          const Text('Error:Use one')
        ],
        if (trailingWidget != null && trailing == null) ...[trailingWidget!],
        if (trailingWidget == null && trailing != null)
          Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
            trailing!,
            style: TextStyles.h10Gray(context),
          ),
      ],
    );
  }
}

class _SettingSubtitles extends StatelessWidget {
  final String title;

  final void Function()? onPressed;

  const _SettingSubtitles({
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.h9Bold(context),
        ),
        IconButton(
            icon: Icon(
              Icons.edit_square,
              color: appColors.ms.textBlack80(context),
            ),
            onPressed: onPressed),
      ],
    );
  }
}
