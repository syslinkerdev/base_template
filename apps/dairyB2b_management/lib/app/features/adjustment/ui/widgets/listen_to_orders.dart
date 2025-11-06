import 'package:core/core.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/order_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/today_providers.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/users_with_orders_list.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';

/// Listens to [orderProProvider] and reacts to order state changes.
/// Shows success or error messages and performs navigation when needed.
void listenToOrders(BuildContext context, WidgetRef ref) {
  ref.listen<AsyncValue>(
    orderProProvider,
    (previous, next) async {
      // Handle error dialogs first
      next.showAlertDialogOnError(context);

      // Debug logging
      if (next.isLoading) {
        print('🔄 [listenToOrders] OrderPro is loading...');
      }

      await next.maybeWhen(
        data: (_) async {
          final adjustmentData = ref.read(adjustmentProvider).value;
          if (adjustmentData == null) {
            print(
                '⚠️ [listenToOrders] adjustmentData is null, skipping UI updates.');
            return;
          }

          final mode = adjustmentData.mode ?? AdjustmentMode.newOrder;
          final user = adjustmentData.user;

          print('✅ [listenToOrders] Order action successful.');
          print('   → Mode: $mode');
          print(
              '   → User: ${user?.fullName ?? "Unknown"} (${user?.uid ?? "no uid"})');

          // ✅ Show success message
          showMessageSnackbar(
            context: context,
            message: '${mode.successMessage} ${user?.fullName ?? ""}',
            maxLines: 2,
            type: SnackBarType.success,
          );

          // ✅ Navigate for certain modes only
          const navUsersWithOrdersListModes = {
            AdjustmentMode.newOrder,
            AdjustmentMode.modify
          };

          if (navUsersWithOrdersListModes.contains(mode)) {
            final adminUid =
                user?.role == Role.client ? user?.superuserUid : user?.uid;
            final currentUserUid = await ref.read(appStateXProvider).uId;

            if (adminUid == currentUserUid) {
              print('self order is happened here :::::');
              ref.invalidate(
                  doesOrderExistForNextDayProvider(uId: currentUserUid));
            }
            if (adminUid != null && adminUid.isNotEmpty) {
              print(
                  '➡️ [listenToOrders] Navigating to UsersWithOrdersList (adminUid: $adminUid)');
              AppRoute.usersWithOrdersList.go(
                context,
                extra: UsersWithOrdersListArgs(
                  adminUid: adminUid,
                  orderFilter: AdminOrderFilter.whoOrdered,
                ),
              );
            } else {
              print(
                  '⚠️ [listenToOrders] adminUid is null or empty. Navigation skipped.');
            }
          } else if (mode == AdjustmentMode.adjustment) {
            AppRoute.ordersAdjustmentList.go(context);
          }
        },
        orElse: () {
          // Debug non-data states
          if (next.isLoading) return;
          if (next is AsyncError) {
            print('❌ [listenToOrders] Order operation failed: ${next.error}');
          } else {
            print('ℹ️ [listenToOrders] No actionable state change detected.');
          }
        },
      );
    },
  );
}
