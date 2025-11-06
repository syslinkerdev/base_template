import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/providers/user_actions.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/clients_and_admins_view.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/common/widgets/discount_show.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_section_holder.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/widgets/shared_widgets.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/providers/filter_users_stream.dart';

class UserDetailsView extends HookConsumerWidget {
  const UserDetailsView({super.key, required this.userUid});
  final String userUid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(userStreamProvider(uid: userUid));
    final userS = userStream.valueOrNull;
    ref.listen(
        userActionsProvider, (_, next) => next.showAlertDialogOnError(context));
    return ScaffoldX(
      wantLeading: true,
      title: 'User',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userStream.isLoading)
              const LinearProgressIndicator(minHeight: 2)
            else
              gapH2,
            Expanded(child: Builder(builder: (context) {
              if (userStream.hasError) {
                return ErrorScreen(
                  error: userStream.error!,
                  onRetry: () {},
                );
              }
              if (userS == null) return LoadingScreen();
              if (userS.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_off_outlined,
                        size: context.sizeOfHeight * 0.12,
                        color: appColors.sc.grey650,
                      ),
                      gapH20,
                      Text('User not found',
                          textAlign: TextAlign.center,
                          style: TextStyles.h8Gray(context)),
                      gapH8,
                      Text('This user may have been deleted or is unavailable.',
                          textAlign: TextAlign.center,
                          style: TextStyles.h14Gray(context)),
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                child: SpacedColumn(
                  defaultHeight: 0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserCoreDetails(user: userS),
                    ShopDetails(user: userS),
                    UserMetaData(user: userS),
                    if (userS.role != Role.admin) ...[
                      AccessCodeDetails(ref: ref, user: userS),
                    ],
                    ServiceChargesDetails(user: userS, ref: ref),
                    DisSectionDetails(user: userS, ref: ref),
                    if (userS.role == Role.client)
                      UserActions(user: userS, ref: ref),
                    ManagementShortSlogan()
                  ],
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}

class UserCoreDetails extends StatelessWidget {
  const UserCoreDetails({super.key, required this.user});

  final UserX user;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ColorBgIconHeader(
              label: 'User Details',
              icon: user.role?.icon ?? Icons.person,
              color: user.role?.color ?? appColors.sc.shukraBlue,
            ),
          ),
          CircularImageAvatar(image: user.avatar),
          MetaRow(label: 'First Name', value: '${user.firstName}'),
          MetaRow(label: 'Last Name', value: '${user.lastName}'),
          MetaRow(
            label: 'Phone No.',
            value: '${user.phoneNumber}',
            trailing: const Icon(Icons.copy, size: 18),
            onTap: () =>
                Clipboard.setData(ClipboardData(text: user.phoneNumber)).then(
              (_) {
                if (context.mounted) {
                  showMessageSnackbar(
                    context: context,
                    message: 'Phone No. copied to clipboard',
                    maxLines: 2,
                  );
                }
              },
            ),
          ),
          MetaRow(label: 'Role', value: '${user.role?.label}'),
          MetaRow(label: 'Status', value: '${user.status?.label}'),
        ],
      ),
    );
  }
}

class UserMetaData extends StatelessWidget {
  const UserMetaData({
    super.key,
    required this.user,
  });

  final UserX user;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'User Metadata',
            icon: Icons.fingerprint,
            color: Colors.blueGrey,
          ),
          MetaRow(
            label: 'UID',
            value: user.uid,
            trailing: const Icon(Icons.copy, size: 18),
            onTap: () => Clipboard.setData(ClipboardData(text: user.uid)).then(
              (_) {
                if (context.mounted) {
                  showMessageSnackbar(
                    context: context,
                    message: 'ID copied to clipboard',
                    maxLines: 2,
                  );
                }
              },
            ),
          ),
          MetaRow(
            label: 'Created',
            value:
                '${DFU.moreFriendlyFormat(user.createdAt)}, ${DFU.timeOnly12h(user.createdAt)}',
          ),
          MetaRow(
            label: 'Basket Limit',
            value: user.basketLimitNo.toString(),
          ),
          MetaRow(
            label: 'Baskets',
            value: user.smartBaskets?.length.toString() ?? '-',
          ),
          MetaRow(
            label: 'Discount Sec.',
            value: user.disSection?.productDiscounts.values.length.toString() ??
                '-',
          ),
        ],
      ),
    );
  }
}

class ShopDetails extends StatelessWidget {
  const ShopDetails({
    super.key,
    required this.user,
  });

  final UserX user;

  @override
  Widget build(BuildContext context) {
    final address = user.shopAddress;

    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'Shop Details',
            icon: Icons.store_mall_directory,
            color: Colors.green,
          ),
          if (user.shopName.containsValidValue &&
              address != Address.empty()) ...[
            MetaRow(label: 'Name', value: user.shopName),
            MetaRow(label: 'Building No.', value: address.buildingNumber),
            MetaRow(label: 'Street', value: address.street),
            MetaRow(label: 'Locality', value: address.locality),
            MetaRow(label: 'City', value: address.city),
            MetaRow(label: 'State', value: address.stateName),
            MetaRow(label: 'Pin Code', value: address.pinCode),

            // Full address copyable
            MetaRow(
              label: 'Full Address',
              value: address.fullAddress,
              onTap: () {
                Clipboard.setData(ClipboardData(text: address.fullAddress));
                if (context.mounted) {
                  showMessageSnackbar(
                    context: context,
                    message: 'Full address copied to clipboard',
                    maxLines: 2,
                  );
                }
              },
              trailing: const Icon(Icons.copy, size: 18),
            ),
          ] else ...[
            Center(
              child: Text('No shop details have been added yet.',
                  style: TextStyles.h10Gray(context)),
            ),
          ],
        ],
      ),
    );
  }
}

class AccessCodeDetails extends StatelessWidget {
  const AccessCodeDetails({super.key, required this.user, required this.ref});

  final UserX user;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'Access Code',
            icon: Icons.vpn_key,
            color: Colors.amber,
          ),
          AccessCodeWidget(ref: ref, user: user),
        ],
      ),
    );
  }
}

class ServiceChargesDetails extends StatelessWidget {
  const ServiceChargesDetails(
      {super.key, required this.user, required this.ref});

  final UserX user;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final fStatus = user.status ?? UserStatus.active;

    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async => await DialogsX.showCustomDialog<double?>(context,
                    content: UpdateServiceCharges())
                .then(
              (newServiceCharges) async {
                if (newServiceCharges != null) {
                  ref
                      .read(userActionsProvider.notifier)
                      .updateUserServiceCharges(
                          userUid: user.uid, serviceCharges: newServiceCharges);
                  var pro = ref.watch(userActionsProvider);
                  if (!pro.hasError) {
                    showMessageSnackbar(
                        context: context,
                        message:
                            'Service charges for ${user.firstName} ${user.lastName} updated to ${newServiceCharges.toStringAsFixed(0)}Rs',
                        type: SnackBarType.success,
                        maxLines: 2);
                    AppRoute.clientsAndAdminsView.go(context,
                        extra: ClientsAndAdminsViewArgs(
                            initAdminId: user.role == Role.admin
                                ? user.uid
                                : user.superuserUid,
                            initUserStatus: fStatus));
                  }
                } else {
                  return;
                }
              },
            ),
            child: ColorBgIconHeader(
              label: 'Service Charges',
              icon: Icons.currency_rupee,
              color: Colors.green,
              trailing: Icon(Icons.edit_note_rounded, size: 21),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Service Charges',
                  style: TextStyles.h10Bold(context),
                ),
                Text(
                  '₹${user.serviceCharges.toString()}',
                  style: TextStyles.h10Bold(context)
                      ?.copyWith(fontFamily: 'Roboto'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UpdateServiceCharges extends HookConsumerWidget {
  const UpdateServiceCharges({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceChargesCtrl = useTextEditingController();

    final creationIcon = Icons.brush;
    return SizedBox(
      width: context.sizeOfWidth,
      child: SpacedColumn(
        mainAxisSize: MainAxisSize.max,
        children: [
          ColorBgIconHeader(
            label: 'Update Service Charges',
            icon: creationIcon,
            color: Colors.orangeAccent,
            trailing: InkWell(
              onTap: () => context.pop(),
              child: CircleAvatar(
                radius: 14,
                backgroundColor:
                    appColors.ms.whiteSwNero(context).withValues(alpha: 0.7),
                child: Icon(Icons.close_rounded,
                    size: 20, color: appColors.ms.neroSwWhite(context)),
              ),
            ),
          ),
          AppTextField(
            controller: serviceChargesCtrl,
            hintText: 'Service Charges ex: 10rs',
            isMandatory: true,
            title: 'Service Charges',
            suffixIcon: SufFixHolder(children: [
              Icon(Icons.currency_rupee,
                  size: TextStyles.h7Gray(context)?.fontSize,
                  color: appColors.ms.textBlack50(context)),
              gapW12
            ]),
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
              FilteringTextInputFormatter.digitsOnly,
            ],
            inputType: TextInputType.number,
          ),
          gapH12,
          ButtonX.primaryButton(
            context: context,
            label: 'Update',
            icon: creationIcon,
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
              if (serviceChargesCtrl.text.isNotEmpty) {
                final parsed = double.tryParse(serviceChargesCtrl.text);
                context.pop(parsed);
              } else {
                return;
              }
            },
          )
        ],
      ),
    );
  }
}

class DisSectionDetails extends StatelessWidget {
  const DisSectionDetails({super.key, required this.user, required this.ref});

  final UserX user;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final disSection = user.disSection;
    final disSecIsNull = (disSection?.id ?? '').doesNotHaveValue;
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (disSecIsNull) {
                return;
              } else {
                DialogsX.showCustomDialog(context,
                    content: DiscountListContent(disSection: disSection!));
              }
            },
            child: ColorBgIconHeader(
              label: 'Discount Section',
              icon: Icons.discount,
              color: Colors.pink.shade400,
              trailing:
                  disSecIsNull ? null : Icon(Icons.zoom_out_map, size: 21),
            ),
          ),
          if (disSecIsNull || disSection?.productDiscounts.length == 0) ...[
            Center(
              child: Column(
                children: [
                  Text('No discount section has been created yet.',
                      style: TextStyles.h10Gray(context)),
                  gapH2,
                  ButtonX(
                    label: 'Create Discount Section',
                    icon: Icons.brush,
                    iconFirst: true,
                    onPressed: () async {
                      ref
                          .watch(discountSectionHolderProvider.notifier)
                          .createDisSectionForUser(user);
                      AppRoute.discountSectionBuilderPage.push(context);
                    },
                  )
                ],
              ),
            ),
          ] else ...[
            MetaRow(label: 'Id', value: disSection?.id ?? '-'),
            MetaRow(label: 'Name', value: disSection?.name ?? '-'),
            MetaRow(
                label: 'Discount Items',
                value: disSection?.productDiscounts.length.toString() ??
                    '-'), // Inside your DisSectionDetails build method
            if (disSection?.meta != null) ...[
              InkWell(
                onTap: () => DialogsX.showCustomDialog(context,
                    content: MetaDataDialogContent(disSection: disSection!)),
                child: MetaRow(
                  label: 'Metadata',
                  value: 'View details',
                  valueUnderLine: true,
                  trailing: const Icon(Icons.info_outline,
                      size: 18, color: Colors.blue),
                ),
              ),
            ],
            SimpleDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Manage this discount section',
                    style: TextStyles.h10Gray(context)),
                ButtonX(
                  label: 'Edit',
                  icon: Icons.edit_note_rounded,
                  iconFirst: true,
                  noAsyncLoading: true,
                  gap: SizedBox.shrink(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                        color: context.colorScheme.primary, width: 1.6),
                  ),
                  backgroundColor: Colors.transparent,
                  height: context.sizeOfHeight * 0.034,
                  labelColor: context.colorScheme.primary,
                  iconColor: context.colorScheme.primary,
                  loadingIconColor: context.colorScheme.primary,
                  onPressed: () async {
                    final shouldNavigate =
                        await DialogsX.askForConfirmation<bool>(
                      context,
                      content:
                          'Are you sure you want to edit this Discount Section?',
                      cancelBtnText: 'Cancel',
                      confirmBtnText: 'Edit',
                    );
                    if (shouldNavigate == true) {
                      ref
                          .watch(discountSectionHolderProvider.notifier)
                          .editDisSectionForUser(user);
                      AppRoute.discountSectionBuilderPage.push(context);
                    }
                  },
                ),
              ],
            )
          ],
        ],
      ),
    );
  }
}

class DiscountListContent extends ConsumerWidget {
  const DiscountListContent({super.key, required this.disSection});
  final DiscountSection disSection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(discountSectionsStreamXProvider);
    final globalSection =
        ref.watch(discountSectionsStreamXProvider.notifier).globalDisSection;

    final discountsCount = sections.maybeWhen(
      data: (_) =>
          '${globalSection.nonDeleteDiscounts.length}/${disSection.productDiscounts.length}',
      orElse: () => '',
    );

    return SpacedColumn(
      children: [
        ColorBgIconHeader(
          label: 'Discounts $discountsCount',
          icon: Icons.attach_money_rounded,
          color: Colors.greenAccent,
          trailing: InkWell(
            onTap: () => context.pop(),
            child: CircleAvatar(
              radius: 14,
              backgroundColor:
                  appColors.ms.whiteSwNero(context).withValues(alpha: 0.7),
              child: Icon(
                Icons.close_rounded,
                size: 20,
                color: appColors.ms.neroSwWhite(context),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 120,
          width: context.sizeOfWidth,
          child: Scrollbar(
            thumbVisibility: true,
            radius: Radius.circular(50),
            child: Padding(
              padding: const EdgeInsets.only(right: 8), // space for scrollbar
              child: DynamicList<Discount>(
                items: disSection.productDiscounts.values.toList(),
                padding: EdgeInsets.zero,
                onSelect: (_) {},
                itemBuilder: (context, dis, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dis.productKey,
                      style: TextStyles.h8(context),
                    ),
                    Text(
                      '\u{20B9}${PriceTag.formatPrice(dis.discount)}',
                      style: TextStyles.h8(context)
                          ?.copyWith(fontFamily: 'Roboto'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MetaDataDialogContent extends StatelessWidget {
  const MetaDataDialogContent({
    super.key,
    required this.disSection,
  });

  final DiscountSection disSection;

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      children: [
        ColorBgIconHeader(
          label: 'Discount Section',
          icon: Icons.data_object_outlined,
          color: Colors.orangeAccent,
          trailing: InkWell(
            onTap: () => context.pop(),
            child: CircleAvatar(
              radius: 14,
              backgroundColor:
                  appColors.ms.whiteSwNero(context).withValues(alpha: 0.7),
              child: Icon(Icons.close_rounded,
                  size: 20, color: appColors.ms.neroSwWhite(context)),
            ),
          ),
        ),
        MetaRow(
          label: 'Created At',
          value: disSection.meta?.createdAt == null
              ? '-'
              : '${DFU.ddMMMyyyy(disSection.meta?.createdAt ?? DFU.now())}',
        ),
        MetaRow(
          label: 'Created By',
          value: disSection.meta?.createdBy ?? '-',
        ),
        MetaRow(
          label: 'Updated At',
          value: disSection.meta?.updatedAt == null
              ? '-'
              : '${DFU.ddMMMyyyy(disSection.meta?.updatedAt ?? DFU.now())}',
        ),
        MetaRow(
          label: 'Updated By',
          value: disSection.meta?.updatedBy ?? '-',
        ),
      ],
    );
  }
}

class UserActions extends StatelessWidget {
  const UserActions({super.key, required this.user, required this.ref});
  final UserX user;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final rStatus = user.status?.reverse;
    final fStatus = rStatus ?? user.status ?? UserStatus.active;
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'Actions',
            icon: Icons.settings,
            color: Colors.deepPurple.shade400,
          ),
          gapH2,
          Center(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _actionBtn(
                  context,
                  rStatus?.icon ?? Icons.abc,
                  rStatus == UserStatus.suspended
                      ? "Suspend"
                      : rStatus?.label ?? '',
                  () async {
                    final shouldNavigate =
                        await DialogsX.askForConfirmation<bool>(
                      context,
                      content:
                          'Are you sure you want to ${rStatus?.label} this User?',
                      cancelBtnText: 'No',
                      confirmBtnText: 'Yes',
                    );
                    if (shouldNavigate == true) {
                      ref.read(userActionsProvider.notifier).updateUserStatus(
                          userUid: user.uid, userStatus: fStatus);
                      var pro = ref.watch(userActionsProvider);
                      if (!pro.hasError) {
                        showMessageSnackbar(
                            context: context,
                            message:
                                '${user.firstName} ${user.lastName} has been ${rStatus?.label.toLowerCase()}',
                            type: SnackBarType.success,
                            maxLines: 2);
                        AppRoute.clientsAndAdminsView.go(context,
                            extra: ClientsAndAdminsViewArgs(
                                initAdminId: user.role == Role.admin
                                    ? user.uid
                                    : user.superuserUid,
                                initUserStatus: fStatus));
                      }
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _actionBtn(BuildContext context, IconData icon, String label,
    FutureOr<void> Function()? onPressed,
    {bool? loading = false}) {
  return SizedBox(
    width: context.sizeOfWidth / 2.5,
    child: ButtonX.primaryButton(
      context: context,
      icon: icon,
      label: label,
      labelStyle: TextStyles.h8Bold(context),
      iconSize: 20,
      loading: loading,
      onPressed: onPressed,
      noAsyncLoading: true,
    ),
  );
}

class GlobalDiscount extends StatelessWidget {
  const GlobalDiscount({
    super.key,
    required this.gDiscount,
  });

  final Discount gDiscount;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async => await DiscountShow.dialog(context, gDiscount),
            child: ColorBgIconHeader(
              label: 'Global Discount',
              icon: Icons.discount,
              color: Colors.green.shade700,
              trailing: Icon(Icons.zoom_out_map, size: 21),
            ),
          ),
          gapH2,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discount', style: TextStyles.h9Bold(context)),
              Text('₹${PriceTag.formatPrice(gDiscount.discount)}',
                  style: TextStyles.h10Bold(context)
                      ?.copyWith(fontFamily: 'Roboto')),
            ],
          ),
        ],
      ),
    );
  }
}
