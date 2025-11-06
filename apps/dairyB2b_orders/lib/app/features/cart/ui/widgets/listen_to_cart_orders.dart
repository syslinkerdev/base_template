import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/order_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/widgets/success_dialog.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';
import 'package:repo/repo.dart';

void listenToCartOrders(BuildContext context, WidgetRef ref) {
  ref.listen(
    orderProProvider,
    (_, next) async {
      // print('🔔 orderProProvider changed → next: $next');

      next.showAlertDialogOnError(context);

      await next.maybeWhen(
        data: (_) async {
          // print('✅ orderProProvider state is DATA');

          final cartState = ref.read(cartProvider).value;
          final mode = cartState?.mode ?? CartMode.newOrder;
          final hadItems = (cartState?.finalCart?.isNotEmpty ?? false);

          // print('🛒 Current cart mode: $mode');
          // print('📦 Had items before clearing? $hadItems');

          await ref.read(cartProvider.notifier).clearCart();
          // print('🗑️ Cart cleared');

          if (!hadItems) {
            // print('❌ No items → skipping dialog');
            return;
          }

          if (!context.mounted) {
            // print('⚠️ Context not mounted, returning early');
            return;
          }

          final dialogResult = await CartSuccess.dialog(context, mode: mode);
          // print('💬 Cart success dialog result: $dialogResult');

          const navToHistoryModes = {CartMode.newOrder, CartMode.edit};
          const navToSmartBasketModes = {CartMode.basket, CartMode.editBasket};

          if (!context.mounted) {
            // print('⚠️ Context not mounted after dialog, returning early');
            return;
          }

          if (dialogResult == true || dialogResult == null) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
              // print('⬅️ Popped top dialog/screen');
            }

            final uId = GlobalCacheService.instance.getUser()?.uid ?? '';
            // print('👤 User ID: $uId');

            if (navToHistoryModes.contains(mode)) {
              if (uId.isNotEmpty) {
                // print('📦 Invalidating history-related providers...');
                ref.invalidate(fetchOrderListLast3daysProvider(uId: uId));
                ref.invalidate(doesOrderExistForNextDayProvider(uId: uId));
                ref.invalidate(didUserOrderProvider(uId: uId));
              }
              if (dialogResult == true) {
                StatefulNavigationShell.of(context)
                    .goBranch(2, initialLocation: true);
                // print('➡️ Navigated to History branch');
              }
            }

            if (navToSmartBasketModes.contains(mode)) {
              if (uId.isNotEmpty) {
                // print('🧺 Invalidating user provider for Smart Basket...');
                ref.invalidate(fetchUserProvider(documentId: uId));
              }
              if (dialogResult == true) {
                AppRoute.smartBasket.go(context);
                // print('➡️ Navigated to Smart Basket');
              }
            }
          }
        },
        orElse: () {
          // print('ℹ️ orderProProvider state is NOT data');
        },
      );
    },
  );
}
