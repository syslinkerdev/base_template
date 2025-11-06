import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:common/widgets/scrollable_button_row.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/user_with_order_details.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/today_providers.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/user_with_order_card.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/admin_filter_dropdown.dart';

/// Arguments to navigate into the UsersWithOrdersList screen
class UsersWithOrdersListArgs {
  final String? adminUid;
  final AdminOrderFilter? orderFilter;

  UsersWithOrdersListArgs({this.adminUid, this.orderFilter});
}

/// Displays list of users and their orders (filtered by admin & order state)
class UsersWithOrdersList extends HookConsumerWidget {
  const UsersWithOrdersList({super.key, this.adminUid, this.orderFilter});

  final String? adminUid;
  final AdminOrderFilter? orderFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // --- State Setup ---
    final adminListAsync = ref.watch(ToDaysProgressStreamProvider());
    final selectedAdmin = useState<String?>(adminUid);
    final selectedFilter = useState<AdminOrderFilter?>(
      orderFilter ?? AdminOrderFilter.whoOrdered,
    );

    final String effectiveAdminUid =
        selectedAdmin.value ?? ref.read(appStateXProvider).uId;
    final AdminOrderFilter effectiveFilter = selectedFilter.value!;

    // --- Watch Filtered Users ---
    final filteredUsersAsync = ref.watch(
      filteredAdminUsersWithOrdersStreamProvider(
        adminUid: effectiveAdminUid,
        filter: effectiveFilter,
      ),
    );

    return ScaffoldX(
      wantLeading: true,
      title: 'Users & Orders',
      body: RefreshIndicator(
        onRefresh: () async => _refresh(
            ref: ref, adminUid: effectiveAdminUid, filter: effectiveFilter),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AdminHeader(
                adminListAsync: adminListAsync,
                selectedAdmin: selectedAdmin,
                selectedFilter: selectedFilter,
              ),
              if (filteredUsersAsync.isLoading)
                const LinearProgressIndicator(minHeight: 2)
              else
                gapH2,
              Expanded(
                child: _UsersListBody(
                  state: filteredUsersAsync,
                  filter: effectiveFilter,
                  onRetry: () => _refresh(
                      ref: ref,
                      adminUid: effectiveAdminUid,
                      filter: effectiveFilter),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Refresh helper ---
  static Future<void> _refresh(
          {required WidgetRef ref,
          required String adminUid,
          required AdminOrderFilter filter}) async =>
      await ref.refresh(filteredAdminUsersWithOrdersStreamProvider(
              adminUid: adminUid, filter: filter)
          .future);
}

/// --- Admin header section with dropdown + filter buttons ---
class _AdminHeader extends StatelessWidget {
  const _AdminHeader({
    required this.adminListAsync,
    required this.selectedAdmin,
    required this.selectedFilter,
  });

  final AsyncValue<List<AdminCount>> adminListAsync;
  final ValueNotifier<String?> selectedAdmin;
  final ValueNotifier<AdminOrderFilter?> selectedFilter;

  @override
  Widget build(BuildContext context) {
    return adminListAsync.when(
      data: (admins) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            AdminCountFilterDropdown(
              admins: admins,
              selectedAdminUid: selectedAdmin.value,
              onChanged: (admin) => selectedAdmin.value = admin.uId,
            ),
            ScrollableButtonRow(
              items: adminOrderFilterLabels,
              initialSelectedId: selectedFilter.value?.name,
              onSelect: (iconLabel) =>
                  selectedFilter.value = filterFromId(iconLabel.id),
            ),
          ],
        ),
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
    required this.state,
    required this.filter,
    required this.onRetry,
  });

  final AsyncValue<List<UserWithOrder>> state;
  final AdminOrderFilter filter;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return state.when(
      data: (usersAndOrders) {
        if (usersAndOrders.isEmpty) {
          return _EmptyState(filter: filter);
        }

        return SingleChildScrollView(
          child: DynamicList<UserWithOrder>(
            physics: const NeverScrollableScrollPhysics(),
            items: usersAndOrders,
            listSeparatorBuilder: (_, __) => gapH6,
            onSelect: (uo) {
              if (uo.order.isNotNull) {
                AppRoute.usersWithOrdersDetails.push(context,
                    extra: UsersWithOrdersDetailsArgs(userWithOrder: uo));
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
  const _EmptyState({required this.filter});
  final AdminOrderFilter filter;

  @override
  Widget build(BuildContext context) {
    final bool isWhoOrdered = filter == AdminOrderFilter.whoOrdered;
    final icon =
        isWhoOrdered ? Icons.shopping_cart_outlined : Icons.person_off_outlined;
    final title = isWhoOrdered
        ? 'No orders found for today!'
        : 'All clients have ordered!';
    final subtitle = isWhoOrdered
        ? 'Looks like no clients placed an order.'
        : 'No one skipped ordering today.';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: context.sizeOfHeight * 0.12, color: appColors.sc.grey650),
          gapH20,
          Text(title,
              style: TextStyles.h7(context), textAlign: TextAlign.center),
          gapH8,
          Text(subtitle,
              style: TextStyles.h8(context), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
