import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/panel/order_reports/main_order_detail_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/sub_widgets.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';

class MainOrdersHistory extends HookConsumerWidget {
  const MainOrdersHistory({super.key, this.forActualDelivery = false});
  final bool forActualDelivery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final last3DaysMainOrders = ref.watch(FetchMainOrderListLast3daysProvider(
        forActualDelivery: forActualDelivery));
    return ScaffoldX(
      title: forActualDelivery
          ? 'Actual Deliveries History'
          : 'Master Orders History',
      wantLeading: true,
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref: ref),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SpacedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              defaultHeight: 4,
              children: [
                HeadingLineFade(label: 'TIME MACHINE'),
                TimeMachine(
                    lastDay: forActualDelivery ? DFU.now() : DFU.nextDay(),
                    onDaySelected: (selectedDay) => AppRoute.mainOrdersDetail
                        .push(context,
                            extra: MainOrderDetailScreenArgs(
                                selectedDate: selectedDay,
                                forActualDelivery: forActualDelivery))),
                HeadingLineFade(
                    label: forActualDelivery
                        ? 'RECENT DELIVERIES'
                        : 'RECENT ORDERS'),
                last3DaysMainOrders.when(
                    data: (mainOrderList) {
                      if (mainOrderList.isEmpty) {
                        return ContainerX(
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.event_busy_rounded,
                                    size: context.sizeOfHeight * 0.1,
                                    color: appColors.sc.grey650),
                                gapH20,
                                Text(
                                  'Oops, looks like we didn\'t have placed any main orders in the last 3 days!',
                                  style: TextStyles.h8(context),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return RecentOrders(
                          mainOrderList: mainOrderList,
                          forActualDelivery: forActualDelivery);
                    },
                    error: (error, stackTrace) => ContainerX(
                          child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.nearby_error_rounded,
                                    size: context.sizeOfHeight * 0.1,
                                    color: appColors.sc.grey650),
                                gapH20,
                                Text(
                                  error.toString(),
                                  style: TextStyles.h8(context),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                    loading: () => _buildShimmerLoading(context)),
                OrderShortSlogan(),
              ]),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return SpacedColumn(
      children: List.generate(
        3,
        (_) => ShimmerX(
          width: context.sizeOfWidth,
          height: context.sizeOfHeight * 0.1,
        ),
      ),
    );
  }

  static Future<void> _refresh({required WidgetRef ref}) async =>
      await ref.refresh(FetchMainOrderListLast3daysProvider().future);
}

class RecentOrders extends StatelessWidget {
  final List<MainOrder> mainOrderList;
  final bool forActualDelivery;
  const RecentOrders(
      {super.key, required this.mainOrderList, this.forActualDelivery = false});

  @override
  Widget build(BuildContext context) {
    //print('mainOrderList ${mainOrderList.length}');
    return DynamicList<MainOrder>(
      physics: NeverScrollableScrollPhysics(),
      items: mainOrderList,
      onSelect: (mOrder) => AppRoute.mainOrdersDetail.push(context,
          extra: MainOrderDetailScreenArgs(
              selectedDate: mOrder.deliveryDate,
              forActualDelivery: forActualDelivery)),
      itemBuilder: (context, mOrder, isSelected) => ContainerX(
        padding: EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: MainOrderCard(
            mainOrder: mOrder,
            doNotWantMainBillDetails: true,
            forActualDelivery: forActualDelivery),
      ),
    );
  }
}

class TimeMachine extends ConsumerWidget {
  final Function(DateTime selectedDay) onDaySelected;
  final DateTime? lastDay;
  const TimeMachine({super.key, required this.onDaySelected, this.lastDay});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFetcher = ref
        .watch(fetchUserProvider(documentId: ref.read(appStateXProvider).uId));

    return userFetcher.when(
        data: (user) {
          if (user == null) {
            return ContainerX(
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.no_accounts,
                        size: context.sizeOfHeight * 0.1,
                        color: appColors.sc.grey650),
                    gapH20,
                    Text(
                      'Oops, it seems like you don\'t have an account yet!',
                      style: TextStyles.h8(context),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          // ✅ Cache user globally
          GlobalCacheService.instance.setUser(user);
          return TableCalX(
            firstDay: user.createdAt,
            lastDay: lastDay,
            onDaySelected: (selectedDay) => onDaySelected(selectedDay),
          );
        },
        error: (error, stackTrace) => ContainerX(
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.nearby_error_rounded,
                        size: context.sizeOfHeight * 0.1,
                        color: appColors.sc.grey650),
                    gapH20,
                    Text(
                      error.toString(),
                      style: TextStyles.h8(context),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        loading: () => ShimmerX(
            width: context.sizeOfWidth, height: context.sizeOfHeight * 0.4));
  }
}
