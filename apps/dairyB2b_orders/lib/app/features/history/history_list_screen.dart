import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';

class HistoryListScreen extends HookConsumerWidget {
  const HistoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uId = ref.watch(appStateXProvider).uId;
    final last3DaysOrders =
        ref.watch(fetchOrderListLast3daysProvider(uId: uId));

    final didUserOrdered = ref.watch(didUserOrderProvider(uId: uId));
    return ScaffoldX(
        title: 'History',
        body: didUserOrdered.when(
          data: (didUserOrdered) {
            //print('didUserOrdered ---------- ${didUserOrdered} -----------');

            if (didUserOrdered == false) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: context.sizeOfHeight * 0.15),
                    Icon(Icons.receipt_long,
                        size: context.sizeOfHeight * 0.12,
                        color: appColors.sc.grey650),
                    gapH20,
                    Text(
                      'Oops, you haven\'t placed an\norders yet!',
                      style: TextStyles.h7(context),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => _refresh(ref: ref, uId: uId),
              child: SingleChildScrollView(
                child: SpacedColumn(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    defaultHeight: 4,
                    children: [
                      HeadingLineFade(label: 'TIME MACHINE'),
                      TimeMachine(
                          onDaySelected: (selectedDay) => AppRoute.historyDetail
                              .push(context, extra: selectedDay),
                          uid: uId),
                      HeadingLineFade(label: 'RECENT ORDERS'),
                      last3DaysOrders.when(
                          data: (orderList) {
                            if (orderList.isEmpty) {
                              return ContainerX(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(Icons.event_busy_rounded,
                                          size: context.sizeOfHeight * 0.1,
                                          color: appColors.sc.grey650),
                                      gapH20,
                                      Text(
                                        'Oops, looks like you haven\'t placed any orders in the last 3 days!',
                                        style: TextStyles.h8(context),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return RecentOrders(orderList: orderList);
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
            );
          },
          error: (error, stackTrace) => ErrorScreen(
              error: error, onRetry: () => _refresh(ref: ref, uId: uId)),
          loading: () => const LoadingScreen(),
        ));
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

  static Future<void> _refresh({
    required WidgetRef ref,
    required String uId,
  }) async =>
      await ref.refresh(fetchOrderListLast3daysProvider(uId: uId).future);
}

class RecentOrders extends StatelessWidget {
  final List<OrderX> orderList;
  const RecentOrders({super.key, required this.orderList});

  @override
  Widget build(BuildContext context) {
    return DynamicList<OrderX>(
      physics: NeverScrollableScrollPhysics(),
      items: orderList,
      onSelect: (mOrder) =>
          AppRoute.historyDetail.push(context, extra: mOrder.deliveryDate),
      listSeparatorBuilder: (context, index) => gapH8,
      itemBuilder: (context, mOrder, isSelected) {
        return HistoryOrderCard(orderDetails: mOrder);
      },
    );
  }
}

class TimeMachine extends ConsumerWidget {
  final Function(DateTime selectedDay) onDaySelected;
  final String uid;

  const TimeMachine(
      {super.key, required this.onDaySelected, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientFetcher = ref.watch(fetchUserProvider(documentId: uid));

    return clientFetcher.when(
        data: (client) {
          if (client == null) {
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
          GlobalCacheService.instance.setUser(client);
          return TableCalX(
            firstDay: client.createdAt,
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
