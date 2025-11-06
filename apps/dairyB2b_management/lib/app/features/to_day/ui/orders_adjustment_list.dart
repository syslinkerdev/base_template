import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/user_with_order_details.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/today_providers.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/user_with_order_card.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/admin_filter_dropdown.dart';

/// Displays list of users and their orders (filtered by admin & order state)
class OrdersAdjustmentList extends HookConsumerWidget {
  const OrdersAdjustmentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- State Setup ---
    final adminListAsync =
        ref.watch(ToDaysProgressStreamProvider(forActualDelivery: true));
    final selectedAdmin = useState<String?>(null);

    final effectiveAdminUid =
        selectedAdmin.value ?? ref.read(appStateXProvider).uId;

    // --- Get Admin Name Safely ---
    final adminName = _getAdminName(adminListAsync.value, selectedAdmin.value);

    // --- Watch Filtered Users ---
    final whoOrdered = AdminOrderFilter.whoOrdered;
    final filteredUsersAsync = ref.watch(
      FilteredAdminUsersWithOrdersStreamProvider(
          adminUid: effectiveAdminUid,
          filter: whoOrdered,
          forActualDelivery: true),
    );

    return ScaffoldX(
      wantLeading: true,
      title: 'Order Adjustments',
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref, effectiveAdminUid, whoOrdered),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AdminHeader(
                adminListAsync: adminListAsync,
                selectedAdmin: selectedAdmin,
              ),
              if (filteredUsersAsync.isLoading)
                const LinearProgressIndicator(minHeight: 2)
              else
                gapH2,
              Expanded(
                child: _UsersListBody(
                  ref: ref,
                  adminName: adminName,
                  state: filteredUsersAsync,
                  onRetry: () => _refresh(ref, effectiveAdminUid, whoOrdered),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Refresh Helper ---
  static Future<void> _refresh(
          WidgetRef ref, String adminUid, AdminOrderFilter filter) async =>
      await ref.refresh(
        FilteredAdminUsersWithOrdersStreamProvider(
                adminUid: adminUid, filter: filter, forActualDelivery: true)
            .future,
      );

  /// --- Helper to extract admin name safely ---
  String _getAdminName(List<AdminCount>? adminList, String? selectedAdminUid) {
    if (adminList == null || adminList.isEmpty) return 'Selected Admin';

    final admin = adminList.firstWhere(
      (element) => element.uId == selectedAdminUid,
      orElse: () => AdminCount(
        uId: '',
        name: 'Selected Admin',
        completed: 0,
        totalClients: 0,
      ),
    );

    return admin.name;
  }
}

/// --- Admin header section with dropdown + filter buttons ---
class _AdminHeader extends StatelessWidget {
  const _AdminHeader(
      {required this.adminListAsync, required this.selectedAdmin});

  final AsyncValue<List<AdminCount>> adminListAsync;
  final ValueNotifier<String?> selectedAdmin;

  @override
  Widget build(BuildContext context) {
    return adminListAsync.when(
      data: (admins) => AdminCountFilterDropdown(
        admins: admins,
        selectedAdminUid: selectedAdmin.value,
        onChanged: (admin) => selectedAdmin.value = admin.uId,
      ),
      loading: () => const ShimmerX(width: double.infinity, height: 48),
      error: (err, _) => ContainerX(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: appColors.sc.grey700),
            gapW8,
            Expanded(
              child: Text(
                'Failed to load admins: $err',
                style: TextStyles.h8(context)?.copyWith(
                  color: appColors.sc.grey700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// --- Main user orders content section ---
class _UsersListBody extends StatelessWidget {
  const _UsersListBody({
    required this.ref,
    required this.adminName,
    required this.state,
    required this.onRetry,
  });
  final WidgetRef ref;
  final String adminName;
  final AsyncValue<List<UserWithOrder>> state;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return state.when(
      data: (usersAndOrders) {
        if (usersAndOrders.isEmpty) {
          return _EmptyState(adminName: adminName);
        }

        return SingleChildScrollView(
          child: DynamicList<UserWithOrder>(
            physics: const NeverScrollableScrollPhysics(),
            items: usersAndOrders,
            listSeparatorBuilder: (_, __) => gapH6,
            onSelect: (uo) {
              if (uo.order.isNotNull) {
                if (uo.order?.status == OrderStatus.adjusted) {
                  AppRoute.usersWithOrdersDetails.push(context,
                      extra: UsersWithOrdersDetailsArgs(
                          userWithOrder: uo, forActualDelivery: true));
                } else {
                  ref.watch(adjustmentProvider.notifier).init(
                      AdjustmentState.empty().copyWith(
                          user: uo.user,
                          order: uo.order,
                          mode: AdjustmentMode.adjustment));
                  AppRoute.adjustment.push(context);
                }
              }
            },
            itemBuilder: (_, uo, __) => UserWithOrderCard(userWithOrder: uo),
          ),
        );
      },
      loading: () => _ShimmerLoading(context),
      error: (err, _) => ErrorScreen(error: err, onRetry: onRetry),
    );
  }

  Widget _ShimmerLoading(BuildContext context) {
    const heights = [0.2, 0.2, 0.2, 0.2];
    return SingleChildScrollView(
      child: SpacedColumn(
        children: heights
            .map((h) => ShimmerX(
                  width: context.sizeOfWidth,
                  height: context.sizeOfHeight * h,
                ))
            .toList(),
      ),
    );
  }
}

/// --- Empty state UI for no users/orders ---
class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.adminName});
  final String adminName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.remove_shopping_cart,
            size: context.sizeOfHeight * 0.12,
            color: appColors.sc.grey650,
          ),
          gapH20,
          Text(
            'No orders found for $adminName on ${DFU.ddMMyyyy(DFU.now())}!',
            style: TextStyles.h7(context),
            textAlign: TextAlign.center,
          ),
          gapH6,
          Text(
            'Looks like $adminName did not receive any orders to adjust.',
            style: TextStyles.h8(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
