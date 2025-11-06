import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/order_reports/user_select_screen.dart';

class UserOrdersDetailScreenArgs {
  final DateTime selectedDay;
  final UserX user;
  UserOrdersDetailScreenArgs({required this.selectedDay, required this.user});
}

class UserOrderDetailScreen extends HookConsumerWidget {
  const UserOrderDetailScreen(
      {super.key, required this.selectedDay, required this.user});
  final DateTime selectedDay;
  final UserX user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchOrderForDayPro =
        fetchOrderProvider(uId: user.uid, day: selectedDay);
    final order = ref.watch(fetchOrderForDayPro);
    return ScaffoldX(
      title: 'Order Details',
      wantLeading: true,
      body: order.when(
        data: (orderDetails) {
          if (orderDetails == null) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: context.sizeOfHeight * 0.15),
                  Icon(Icons.remove_shopping_cart,
                      size: context.sizeOfHeight * 0.12,
                      color: appColors.sc.grey650),
                  gapH20,
                  Text(
                    'Whoops! ${user.firstName} ${user.lastName} skipped ordering on this day (${DFU.ddMMyyyy(selectedDay)})!',
                    style: TextStyles.h7(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SpacedColumn(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                defaultHeight: 8,
                children: [
                  UserXCardForSelect(user: user),
                  HistoryOrderCard(
                      orderDetails: orderDetails, doNotWantArrow: true),
                  OrderedItemList(
                    items: orderDetails.orderedProducts,
                    headerLabel: 'Products Ordered',
                    headerIcon: Icons.local_mall,
                    headerColor: appColors.sc.liteRed,
                  ),
                  HistoryBillSummary(orderDetails: orderDetails),
                  LogsShow(logs: orderDetails.logs),
                ]),
          );
        },
        error: (error, stackTrace) => ErrorScreen(
            error: error,
            onRetry: () async => await ref.refresh(
                fetchOrderProvider(uId: user.uid, day: selectedDay).future)),
        loading: () => _buildShimmerLoading(context),
      ),
      bottomNavigationBar:
          order.isLoading || order.hasError || order.value == null
              ? null
              : ButtonX.outlineButton(
                  context: context,
                  label: 'Invoice',
                  icon: Icons.file_download_outlined,
                  onPressed: () => generateInvoicePdf(
                    context: context,
                    order: order.value!,
                    user: user,
                  ),
                ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliersView = [0.08, 0.14, 0.24, 0.2];
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SpacedColumn(
        defaultHeight: 8,
        children: heightMultipliersView
            .map((h) => ShimmerX(
                  width: context.sizeOfWidth,
                  height: context.sizeOfHeight * h,
                ))
            .toList(),
      ),
    );
  }
}
