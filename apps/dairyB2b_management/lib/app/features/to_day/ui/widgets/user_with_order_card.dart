import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/today_providers.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';

class UserWithOrderCard extends ConsumerWidget {
  const UserWithOrderCard(
      {super.key, required this.userWithOrder, this.atDetailsPage = false});

  final UserWithOrder userWithOrder;
  final bool atDetailsPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = userWithOrder.user;
    final order = userWithOrder.order;
    final orderRules = ref.watch(orderRulesStreamProvider);
    final now = DFU.now();
    final endTime = orderRules.value?.todayEffectiveOrderEnd;
    bool canIGen = endTime != null && now.isAfter(endTime);
    final message = orderRules.when(
      data: WhatsAppHelper.buildOrderReminderMessage,
      loading: () => "⏳ Fetching order rules...",
      error: (e, s) =>
          "⚠️ Could not fetch order rules. Please confirm manually.",
    );

    return ContainerX(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ USER NAME + PHONE
          Row(
            children: [
              CircularImageAvatar(image: user.avatar, radius: 20),
              gapW12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${user.firstName} ${user.lastName}",
                            style: TextStyles.h8Bold(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        StatusTag(status: order?.status ?? OrderStatus.placed),
                      ],
                    ),
                    InkWell(
                      onTap: () => Clipboard.setData(ClipboardData(
                              text: user.phoneNumber.replaceAll('+91', '')))
                          .then(
                        (_) {
                          if (context.mounted) {
                            showMessageSnackbar(
                                context: context,
                                message: 'Phone number copied to clipboard',
                                maxLines: 2);
                          }
                        },
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${user.phoneNumber.substring(0, 3)} ${user.phoneNumber.substring(3)}',
                              style: TextStyles.h9Gray(context)),
                          Icon(
                            Icons.copy,
                            size: 18,
                            color: appColors.ms.textBlack50(context),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SimpleDivider(),

          // ✅ Order Info or Action
          if (order != null && order.isNotEmpty) ...[
            if (atDetailsPage) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "• Shop Name :",
                    style: TextStyles.h10Bold(context),
                  ),
                  Text(
                    user.shopName,
                    style: TextStyles.h10Gray(context),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "• Address : ",
                    style: TextStyles.h11Bold(context)
                        ?.copyWith(color: appColors.ms.textBlack50(context)),
                  ),
                  Expanded(
                    child: Text(
                      user.shopAddress.fullAddress,
                      style: TextStyles.h11(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              )
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "• Order ID :",
                    style: TextStyles.h10Bold(context),
                  ),
                  Text(
                    order.orderId,
                    style: TextStyles.h10Gray(context),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "• Placed on ${DFU.timeOnly12h(order.createdAt)}",
                      style: TextStyles.h11Bold(context)
                          ?.copyWith(color: appColors.ms.textBlack50(context)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₹${PriceTag.formatPrice(order.totalPrice + order.serviceCharges)}',
                        style: TextStyles.h11Bold(context)
                            ?.copyWith(fontFamily: 'Roboto'),
                      ),
                      gapW2,
                      Icon(Icons.arrow_forward_ios,
                          size: 14, color: appColors.sc.grey500),
                    ],
                  ),
                ],
              )
            ],
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: appColors.sc.mutedRed),
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Text(
                    "• NOT ORDERED",
                    style: TextStyles.h14Bold(context)
                        ?.copyWith(color: appColors.sc.liteRed),
                  ),
                ),
                Row(
                  children: [
                    WhatsAppButton(
                        phoneNumber: user.phoneNumber, message: message),
                    gapW6,
                    CallButton(
                        phoneNumber:
                            user.phoneNumber.replaceAll(RegExp(r'^\+91'), '')),
                    gapW6,
                    IconButton(
                      onPressed: () async {
                        if (endTime == null) {
                          showMessageSnackbar(
                              context: context,
                              message: '⚠️ No order end time set for today',
                              type: SnackBarType.warning);
                          return;
                        }
                        if (canIGen) {
                          final shouldNavigate =
                              await DialogsX.askForConfirmation<bool>(
                            context,
                            title: '🛍️ Create Order',
                            content:
                                'Are you sure you want to create a new order for ${user.fullName}?',
                            cancelBtnText: 'No',
                            confirmBtnText: 'Yes',
                          );
                          if (shouldNavigate == true) {
                            // print(
                            // '🛍️ Creating new order for user ${user.fullName} ${userWithOrder.user.phoneNumber}');
                            ref.watch(adjustmentProvider.notifier).init(
                                AdjustmentState.empty().copyWith(
                                    user: userWithOrder.user,
                                    order: null,
                                    mode: AdjustmentMode.newOrder));

                            AppRoute.adjustment.push(context);
                          }
                        } else {
                          final formatted = DFU.timeOnly12h(endTime);
                          showMessageSnackbar(
                              context: context,
                              message:
                                  '⏳ Please wait until $formatted to create orders',
                              maxLines: 2);
                        }
                      },
                      icon: Icon(Icons.local_mall_rounded,
                          color: appColors.ms.whiteSwNero(context)),
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.orange.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      tooltip: 'Place Order',
                    )
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class StatusTag extends StatelessWidget {
  const StatusTag({super.key, required this.status});
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('ORD : ', style: TextStyles.h14Gray(context)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
              color: status.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(status.icon, color: status.color, size: 14),
              gapW2,
              Text(status.label,
                  style: TextStyles.h14Bold(context)
                      ?.copyWith(color: status.color)),
            ],
          ),
        ),
      ],
    );
  }
}
