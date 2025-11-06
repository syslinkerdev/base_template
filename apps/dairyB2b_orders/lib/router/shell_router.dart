import 'package:auth/auth.dart';
import 'package:common/pages/about_app.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/features/account/ui/account.dart';
import 'package:dairyB2b_orders/app/features/account/ui/discounts_screen.dart';
import 'package:dairyB2b_orders/app/features/account/ui/settings.dart';
import 'package:dairyB2b_orders/app/features/account/ui/edit_account.dart';
import 'package:dairyB2b_orders/app/features/account/ui/edit_shop.dart';
import 'package:dairyB2b_orders/app/features/account/ui/your_admin.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/cart_screen.dart';
import 'package:dairyB2b_orders/app/features/history/history_list_screen.dart';
import 'package:dairyB2b_orders/app/features/history/history_detail_screen.dart';
import 'package:dairyB2b_orders/app/features/home/ui/home_screen.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/brand_products_screen.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/products_screen.dart';
import 'package:dairyB2b_orders/app/features/smart_basket/ui/smart_basket_details_screen.dart';
import 'package:dairyB2b_orders/app/features/smart_basket/ui/smart_basket_screen.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';

abstract class ShellRouter {
  static final shellNavKey = GlobalKey<NavigatorState>();
  static final shellBranches = <StatefulShellBranch>[
    StatefulShellBranch(
      navigatorKey: shellNavKey,
      routes: <RouteBase>[
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
                path: AppRoute.products.pageName,
                name: AppRoute.products.name,
                pageBuilder: (context, state) {
                  var inp = state.extra as ProductsScreenArgs;
                  return AppTransitions.right(state.pageKey,
                      page: ProductsScreen(
                          initBrand: inp.initBrand,
                          initCategory: inp.initCategory));
                },
                routes: [
                  GoRoute(
                    path: AppRoute.brandProducts.pageName,
                    name: AppRoute.brandProducts.name,
                    pageBuilder: (context, state) {
                      var inp = state.extra as Brand;
                      return AppTransitions.bottom(state.pageKey,
                          page: BrandProductsScreen(brand: inp));
                    },
                  ),
                ]),
            GoRoute(
                path: AppRoute.smartBasket.pageName,
                name: AppRoute.smartBasket.name,
                pageBuilder: (context, state) => AppTransitions.bottom(
                    state.pageKey,
                    page: SmartBasketScreen()),
                routes: [
                  GoRoute(
                      path: AppRoute.smartBasketDetails.pageName,
                      name: AppRoute.smartBasketDetails.name,
                      builder: (context, state) => SmartBasketDetailsScreen(
                          smartBasket: state.extra as SmartBasket))
                ])
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
            path: AppRoute.cart.path,
            name: AppRoute.cart.name,
            builder: (context, state) => CartScreen())
      ],
    ),
    StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
            path: AppRoute.history.path,
            name: AppRoute.history.name,
            builder: (context, state) => HistoryListScreen(),
            routes: [
              GoRoute(
                path: AppRoute.historyDetail.pageName,
                name: AppRoute.historyDetail.name,
                builder: (context, state) =>
                    HistoryDetailScreen(selectedDay: state.extra as DateTime),
              ),
            ]),
      ],
    ),
    StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
          path: AppRoute.account.path,
          name: AppRoute.account.name,
          builder: (_, state) => const Account(),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoute.yourAdmin.pageName,
              name: AppRoute.yourAdmin.name,
              builder: (context, state) => YourAdmin(
                adminUid: state.extra as String,
              ),
            ),
            GoRoute(
                path: AppRoute.aboutApp.pageName,
                name: AppRoute.aboutApp.name,
                builder: (context, state) => AboutApp()),
            GoRoute(
              path: AppRoute.discounts.pageName,
              name: AppRoute.discounts.name,
              builder: (context, state) =>
                  DiscountsScreen(discounts: state.extra as List<Discount>),
            ),
            GoRoute(
              path: AppRoute.settings.pageName,
              name: AppRoute.settings.name,
              builder: (_, state) => Settings(
                user: state.extra as UserX,
              ),
              routes: [
                GoRoute(
                  path: AppRoute.editAccount.pageName,
                  name: AppRoute.editAccount.name,
                  builder: (context, state) =>
                      EditAccount(profile: state.extra as Map<String, dynamic>),
                ),
                GoRoute(
                  path: AppRoute.editShop.pageName,
                  name: AppRoute.editShop.name,
                  builder: (context, state) =>
                      EditShop(shopInfo: state.extra as Map<String, dynamic>),
                ),
                GoRoute(
                  path: AppRoute.updatePin.pageName,
                  name: AppRoute.updatePin.name,
                  builder: (context, state) => UpdatePin(
                      hPinAndUid: state.extra as Map<String, dynamic>),
                ),
                GoRoute(
                  path: AppRoute.confirmPin.pageName,
                  name: AppRoute.confirmPin.name,
                  builder: (context, state) =>
                      ConfirmPin(currentPinHash: state.extra as String),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];
}
