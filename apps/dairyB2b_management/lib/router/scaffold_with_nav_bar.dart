import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';

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
    final currentRoute = RouteX.getCurrentRoute(context);
    // we have to call this using AppRoute class

    // Call BottomNavVisibilityController based on the route
    _shouldShowNavBar(currentRoute);

    return PopScope(
      canPop:
          navigationShell.currentIndex == 0, // equivalent of return true/false
      onPopInvokedWithResult: (didPop, _) {
        // didPop == true → framework already popped the route
        // didPop == false → we can intercept
        if (!didPop && navigationShell.currentIndex != 0) {
          navigationShell.goBranch(0);
        }
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
                            child: ManagementNavBar(
                                navigationShell: navigationShell,
                                currentIndex: navigationShell.currentIndex),
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
      AppRoute.board.path,
      AppRoute.panel.path,
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

class ManagementNavBar extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;
  final int currentIndex;

  const ManagementNavBar({
    super.key,
    required this.navigationShell,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController =
        useTabController(initialLength: 3, initialIndex: currentIndex);
    tabController.index = currentIndex;

    return TabBar(
      controller: tabController,
      tabs: const [
        Tab(icon: Icon(Icons.workspaces), text: 'Board'),
        Tab(icon: Icon(Icons.dashboard), text: 'Panel'),
        Tab(icon: Icon(Icons.account_circle), text: 'Account'),
      ],
      onTap: (index) {
        navigationShell.goBranch(index,
            initialLocation: index == navigationShell.currentIndex);
      },
    );
  }
}
