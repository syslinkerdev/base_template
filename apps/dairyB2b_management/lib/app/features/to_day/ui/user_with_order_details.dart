import 'dart:async';

import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/order_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/today_providers.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/user_with_order_card.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';

class UsersWithOrdersDetailsArgs {
  final UserWithOrder userWithOrder;
  final bool forActualDelivery;
  UsersWithOrdersDetailsArgs(
      {required this.userWithOrder, this.forActualDelivery = false});
}

class UsersWithOrdersDetails extends HookConsumerWidget {
  const UsersWithOrdersDetails(
      {super.key, required this.userWithOrder, this.forActualDelivery = false});
  final UserWithOrder userWithOrder;
  final bool forActualDelivery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesAsy = ref.watch(orderRulesStreamProvider);
    final now = DFU.now();
    final endTime = rulesAsy.value?.todayEffectiveOrderEnd;
    bool canIGen = endTime != null && now.isAfter(endTime);
    final order = userWithOrder.order ?? OrderX.empty();
    // final ifOrderStatusAdjusted = order.status == OrderStatus.adjusted;
    print('order.status ${order.status}');
    return ScaffoldX(
      wantLeading: true,
      title: forActualDelivery ? 'User & Adjusted Order' : 'User & Order',
      body: SingleChildScrollView(
        child: SpacedColumn(
          defaultHeight: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            UserWithOrderCard(
                userWithOrder: userWithOrder, atDetailsPage: true),
            OrderMetaData(order: order),
            if (order.orderedProducts.isNotEmpty) ...[
              OrderedItemList(
                items: order.orderedProducts,
                headerLabel: 'Products Ordered',
                headerIcon: Icons.local_mall,
                headerColor: appColors.sc.liteRed,
              ),
              OrderBillSummary(
                  order: order, userName: userWithOrder.user.lastName),
            ],
            if (forActualDelivery == false) ...[
              ContainerX(
                margin: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Facing an issue with this order?',
                          style: TextStyles.h10Bold(context)),
                    ),
                    WhatsAppButton(phoneNumber: userWithOrder.user.phoneNumber),
                    gapW6,
                    CallButton(
                        phoneNumber: userWithOrder.user.phoneNumber
                            .replaceAll(RegExp(r'^\+91'), '')),
                  ],
                ),
              ),
            ],
            TextAndButtonHolder(
              mainText: 'You can adjust this order.',
              buttonText: 'Adjust',
              buttonIcon: Icons.edit_note_rounded,
              onButtonPressed: () async {
                if (forActualDelivery == true) {
                  ref.watch(adjustmentProvider.notifier).init(
                      AdjustmentState.empty().copyWith(
                          user: userWithOrder.user,
                          order: userWithOrder.order,
                          mode: AdjustmentMode.adjustment));
                  AppRoute.adjustment.push(context);
                } else {
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
                      title: '✏️ Adjust Order',
                      content:
                          'Do you want to adjust the order for ${userWithOrder.user.fullName}?',
                      cancelBtnText: 'No',
                      confirmBtnText: 'Yes',
                    );
                    if (shouldNavigate == true) {
                      ref.watch(adjustmentProvider.notifier).init(
                          AdjustmentState.empty().copyWith(
                              user: userWithOrder.user,
                              order: userWithOrder.order,
                              mode: userWithOrder.order == null
                                  ? AdjustmentMode.newOrder
                                  : AdjustmentMode.modify));

                      AppRoute.adjustment.push(context);
                    }
                  } else {
                    final formatted = DFU.timeOnly12h(endTime);
                    showMessageSnackbar(
                        context: context,
                        message:
                            '⏳ Please wait until $formatted to adjust orders',
                        maxLines: 2);
                  }
                }
              },
            ),
            if (order.status != OrderStatus.deleted &&
                order.orderedProducts.isNotEmpty) ...[
              if (forActualDelivery == false) ...[
                TextAndButtonHolder(
                  mainText: 'Want to delete this order?',
                  buttonText: 'Delete',
                  buttonIcon: Icons.delete_forever,
                  buttonColor: appColors.sc.liteRed,
                  loading: ref.watch(orderProProvider).isLoading,
                  onButtonPressed: () async {
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
                        title: '🗑️ Delete Order',
                        content:
                            'This action will remove the order for ${userWithOrder.user.fullName}.\n\nDo you want to continue?',
                        cancelBtnText: 'No',
                        confirmBtnText: 'Yes',
                      );

                      if (shouldNavigate == true &&
                          userWithOrder.order != null) {
                        await ref
                            .watch(orderProProvider.notifier)
                            .deleteOrder(order: userWithOrder.order!);

                        final state = ref.watch(orderProProvider);
                        state.when(
                          data: (_) {
                            if (context.mounted) {
                              showMessageSnackbar(
                                context: context,
                                message: 'Order deleted successfully of ' +
                                    userWithOrder.user.fullName,
                                type: SnackBarType.success,
                              );
                              context.close();
                            }
                          },
                          loading: () {},
                          error: (e, _) {
                            if (context.mounted) {
                              showMessageSnackbar(
                                context: context,
                                message: 'Failed to delete order: $e',
                                type: SnackBarType.error,
                                maxLines: 3,
                              );
                            }
                          },
                        );
                      } else {
                        print('⚠️ Delete cancelled or no order to delete');
                      }
                    } else {
                      final formatted = DFU.timeOnly12h(endTime);
                      showMessageSnackbar(
                          context: context,
                          message:
                              '⏳ Please wait until $formatted to delete orders',
                          maxLines: 2);
                    }
                  },
                ),
              ],
            ],
            LogsShow(logs: order.logs),
          ],
        ),
      ),
    );
  }
}

class TextAndButtonHolder extends StatelessWidget {
  const TextAndButtonHolder({
    super.key,
    required this.mainText,
    required this.buttonText,
    required this.buttonIcon,
    this.onButtonPressed,
    this.buttonColor,
    this.loading,
  });
  final String mainText;
  final String buttonText;
  final IconData buttonIcon;
  final FutureOr<void> Function()? onButtonPressed;
  final Color? buttonColor;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(mainText, style: TextStyles.h10Bold(context)),
          ),
          ButtonX(
            label: buttonText,
            icon: buttonIcon,
            iconFirst: true,
            noAsyncLoading: true,
            loading: loading ?? false,
            gap: SizedBox.shrink(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                    color: buttonColor ?? context.colorScheme.primary,
                    width: 1.6)),
            height: context.sizeOfHeight * 0.034,
            labelColor: buttonColor ?? context.colorScheme.primary,
            iconColor: buttonColor ?? context.colorScheme.primary,
            loadingIconColor: buttonColor ?? context.colorScheme.primary,
            backgroundColor: Colors.transparent,
            onPressed: onButtonPressed,
          ),
        ],
      ),
    );
  }
}

class OrderMetaData extends StatelessWidget {
  const OrderMetaData({
    super.key,
    required this.order,
  });
  final OrderX order;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: EdgeInsets.zero,
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'Order Metadata',
            icon: Icons.fingerprint,
            color: appColors.sc.nobel,
          ),
          MetaRow(
            onTap: () =>
                Clipboard.setData(ClipboardData(text: order.orderId)).then(
              (_) {
                if (context.mounted) {
                  showMessageSnackbar(
                      context: context,
                      message: 'Order Id copied to clipboard',
                      maxLines: 2);
                }
              },
            ),
            label: 'Order ID',
            value: order.orderId,
            trailing: Icon(Icons.copy, size: 18),
          ),
          MetaRow(
              label: 'Delivery Date',
              value:
                  '${DFU.moreFriendlyFormat(order.deliveryDate)}, ${DFU.timeOnly12h(order.deliveryDate)}'),
          MetaRow(
              label: 'Created At',
              value:
                  '${DFU.moreFriendlyFormat(order.createdAt)}, ${DFU.timeOnly12h(order.createdAt)}'),
          MetaRow(
            label: 'Last Updated',
            value: order.updatedAt != null
                ? '${DFU.moreFriendlyFormat(order.updatedAt!)}, ${DFU.timeOnly12h(order.updatedAt!)}'
                : '—',
          ),
          MetaRow(
            label: 'Status',
            value: order.status.name,
          ),
          MetaRow(
            label: 'Items',
            value: order.orderedProducts.length == 0
                ? 'No items'
                : '${order.orderedProducts.length}',
          ),
        ],
      ),
    );
  }
}

class OrderBillSummary extends StatelessWidget {
  const OrderBillSummary(
      {super.key, required this.order, required this.userName});

  final OrderX order;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final itemsTotal = order.originalTotalPrice;
    final serviceCharges = order.serviceCharges;
    final discounts = order.originalTotalPrice - order.totalPrice;

    // 👇 Grand total formula
    final grandTotal = itemsTotal + serviceCharges - discounts;

    final formattedItems = PriceTag.formatPrice(itemsTotal);
    final formattedService = PriceTag.formatPrice(serviceCharges);
    final formattedDiscount = PriceTag.formatPrice(discounts);
    final formattedGrand = PriceTag.formatPrice(grandTotal);

    return ContainerX(
      margin: EdgeInsets.zero,
      child: SpacedColumn(
        defaultHeight: 6.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'Bill Summary',
            icon: Icons.receipt,
            color: appColors.sc.teal,
          ),
          _billRow(context, 'Items Total', '₹$formattedItems'),
          _billRow(context, 'Service Charges', '+ ₹$formattedService'),
          _billRow(context, 'Total Discounts', '− ₹$formattedDiscount'),
          const SimpleDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DashedUnderlineText(
                text: 'Grand Total',
                style: TextStyles.h12Bold(context),
              ),
              Row(
                children: [
                  // Show original + service if there was a discount
                  PriceTag(
                      price: itemsTotal + serviceCharges, cancelStyle: true),
                  gapW4,
                  Text(
                    '₹$formattedGrand',
                    style: TextStyles.h12Bold(context)
                        ?.copyWith(fontFamily: 'Roboto'),
                  ),
                ],
              ),
            ],
          ),
          const GradientSineWaveDivider(),
          Center(
            child: Text(
              'You saved ₹$formattedDiscount on this order',
              style: TextStyles.h8Bold(context)?.copyWith(
                color: appColors.sc.teal,
                fontFamily: 'Roboto',
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _billRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DashedUnderlineText(
          text: label,
          style: TextStyles.h12Bold(context),
        ),
        Text(
          value,
          style: TextStyles.h12Bold(context)?.copyWith(fontFamily: 'Roboto'),
        ),
      ],
    );
  }
}
