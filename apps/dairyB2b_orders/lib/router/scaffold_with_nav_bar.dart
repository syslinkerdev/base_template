import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/widgets/cart_icon.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';

class BottomNavVisibilityController {
  BottomNavVisibilityController._();

  static final ValueNotifier<bool> isVisible = ValueNotifier<bool>(true);

  static void hideBottomNav() => isVisible.value = false;

  static void showBottomNav() => isVisible.value = true;
}

class ScaffoldWithNavBar extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateXProvider);
    final currentRoute = RouteX.getCurrentRoute(context);
    // we have to call this using AppRoute class

    // Call BottomNavVisibilityController based on the route
    _shouldShowNavBar(currentRoute);

    return WillPopScope(
      onWillPop: () async {
        if (navigationShell.currentIndex != 0) {
          navigationShell.goBranch(0);
          return false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: BottomNavVisibilityController.isVisible.value ==
                      true
                  ? (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification) {
                        if (scrollNotification.metrics.axis == Axis.vertical) {
                          if (scrollNotification.metrics.pixels <
                              scrollNotification.metrics.maxScrollExtent) {
                            BottomNavVisibilityController.showBottomNav();
                          } else {
                            BottomNavVisibilityController.hideBottomNav();
                          }
                        }
                      }
                      return false;
                    }
                  : null,
              child: navigationShell,
            ),
            ValueListenableBuilder(
              valueListenable: BottomNavVisibilityController.isVisible,
              builder: (context, isVisible, child) {
                return Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    child: isVisible
                        ? Container(
                            color: Theme.of(context).cardColor,
                            child: OrdersNavBar(
                              navigationShell: navigationShell,
                              currentIndex: navigationShell.currentIndex,
                              uId: appState.uId,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Modified _shouldShowNavBar to trigger show/hide
  void _shouldShowNavBar(String currentLocation) {
    final showNavBarRoutes = [
      AppRoute.home.path,
      AppRoute.history.path,
      AppRoute.account.path,
      // Add more routes where nav bar should show
    ];

    // If the route is allowed, show the bottom nav
    if (showNavBarRoutes.any((route) => currentLocation == route)) {
      BottomNavVisibilityController.showBottomNav();
    } else {
      // Otherwise, hide the bottom nav
      BottomNavVisibilityController.hideBottomNav();
    }
  }
}

class OrdersNavBar extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;
  final int currentIndex;
  final String uId;

  const OrdersNavBar({
    super.key,
    required this.navigationShell,
    required this.currentIndex,
    required this.uId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController =
        useTabController(initialLength: 4, initialIndex: currentIndex);
    tabController.index = currentIndex;
    return TabBar(
      controller: tabController,
      tabs: [
        Tab(icon: Icon(Icons.home), text: 'Home'),
        Tab(icon: CartIcon(), text: 'Cart'),
        Tab(icon: Icon(Icons.history), text: 'History'),
        Tab(icon: Icon(Icons.account_circle), text: 'Account'),
      ],
      onTap: (index) async {
        navigationShell.goBranch(index,
            initialLocation: index == navigationShell.currentIndex);
        if (index == 1) {
          await ref.read(cartProvider.notifier).loadFinalCart();
        }
        if (index == 2) {
          ref.invalidate(fetchOrderListLast3daysProvider(uId: uId));
        }
      },
    );
  }
}
