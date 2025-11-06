import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/panel/order_reports/user_order_detail_screen.dart';
import 'package:dairyB2b_management/app/features/panel/order_reports/user_select_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/board.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';

class UserOrdersHistory extends HookConsumerWidget {
  const UserOrdersHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFetcher = ref
        .watch(fetchUserProvider(documentId: ref.read(appStateXProvider).uId));
    final innerUser = userFetcher.when(
      data: (user) => user,
      error: (error, stackTrace) => null,
      loading: () => null,
    );
    final selectedUser = useState<UserX?>(innerUser);
    useEffect(() {
      if (innerUser != null && innerUser != selectedUser.value) {
        selectedUser.value = innerUser;
      }
      return null; // no dispose action
    }, [innerUser]);
    final last3DaysOrders = ref.watch(fetchOrderListLast3daysProvider(
        uId: selectedUser.value?.uid ?? ref.read(appStateXProvider).uId));
    String selectedUserLabel = selectedUser.value == null
        ? 'select user'.toUpperCase()
        : '${selectedUser.value?.firstName} ${selectedUser.value?.lastName}'
            .toUpperCase();
    return ScaffoldX(
      title: 'User Orders History',
      wantLeading: true,
      body: RefreshIndicator(
        onRefresh: () => _refresh(
            ref: ref,
            uId: selectedUser.value?.uid ?? ref.read(appStateXProvider).uId),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SpacedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              defaultHeight: 4,
              children: [
                ActionButtonX(
                  icon: Icons.person,
                  iconColor: Colors.orange.shade400,
                  label: selectedUserLabel,
                  wantDownArrow: true,
                  onTap: () async {
                    var selectedUserFromSheet =
                        await UserSelectScreen.bottomSheet(context,
                            selectedUser: selectedUser.value?.uid ??
                                ref.read(appStateXProvider).uId);
                    selectedUser.value = selectedUserFromSheet.isNull
                        ? selectedUser.value
                        : selectedUserFromSheet;
                  },
                ),
                HeadingLineFade(label: 'TIME MACHINE'),
                if (selectedUser.value?.createdAt != null) ...[
                  TableCalX(
                    key: ValueKey(selectedUser.value?.createdAt),
                    firstDay: selectedUser.value?.createdAt ?? DFU.now(),
                    onDaySelected: (selectedDay) {
                      if (selectedUser.value != null) {
                        AppRoute.userOrdersDetail.push(context,
                            extra: UserOrdersDetailScreenArgs(
                                selectedDay: selectedDay,
                                user: selectedUser.value!));
                      }
                    },
                  ),
                ] else ...[
                  ShimmerX(
                      width: context.sizeOfWidth,
                      height: context.sizeOfHeight * 0.4)
                ],
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
                                  'Oops, looks like this user haven\'t placed any orders in the last 3 days!',
                                  style: TextStyles.h8(context),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return RecentOrders(
                          orderList: orderList, selectedUser: selectedUser);
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
                ManagementShortSlogan()
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

  static Future<void> _refresh({
    required WidgetRef ref,
    required String uId,
  }) async =>
      await ref.refresh(fetchOrderListLast3daysProvider(uId: uId).future);
}

class RecentOrders extends StatelessWidget {
  final List<OrderX> orderList;
  final ValueNotifier<UserX?> selectedUser;
  const RecentOrders(
      {super.key, required this.orderList, required this.selectedUser});

  @override
  Widget build(BuildContext context) {
    return DynamicList<OrderX>(
      physics: NeverScrollableScrollPhysics(),
      items: orderList,
      onSelect: (mOrder) {
        if (selectedUser.value != null) {
          AppRoute.userOrdersDetail.push(context,
              extra: UserOrdersDetailScreenArgs(
                  selectedDay: mOrder.deliveryDate, user: selectedUser.value!));
        }
      },
      listSeparatorBuilder: (context, index) => gapH8,
      itemBuilder: (context, mOrder, isSelected) {
        return HistoryOrderCard(orderDetails: mOrder);
      },
    );
  }
}
