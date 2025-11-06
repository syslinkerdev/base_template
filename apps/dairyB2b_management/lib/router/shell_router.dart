import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/admins_view.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/user_details_view.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/discount_section_builder_page.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/discount_section_view.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/discount_sections.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/clients_and_admins_view.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/logs_view.dart';
import 'package:dairyB2b_management/app/features/panel/order_reports/main_order_detail_screen.dart';
import 'package:dairyB2b_management/app/features/panel/order_reports/main_orders_history.dart';
import 'package:dairyB2b_management/app/features/panel/order_reports/user_order_detail_screen.dart';
import 'package:dairyB2b_management/app/features/panel/order_reports/user_orders_history.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/actual_delivery_page.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/master_order_page.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/orders_adjustment_list.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/panel.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/rules.dart';
import 'package:dairyB2b_management/app/features/account/account.dart';
import 'package:dairyB2b_management/app/features/account/settings.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/board.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/users_with_orders_list.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/user_with_order_details.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/view_products.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/product_maker_screen.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/view_product_details.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/manage_product_screen.dart';

abstract class ShellRouter {
  static final shellNavKey = GlobalKey<NavigatorState>();
  static final shellBranches = <StatefulShellBranch>[
    StatefulShellBranch(
      navigatorKey: shellNavKey,
      routes: <RouteBase>[
        GoRoute(
          path: AppRoute.board.path,
          name: AppRoute.board.name,
          builder: (context, state) => const Board(),
          routes: <RouteBase>[
            GoRoute(
                path: AppRoute.usersWithOrdersList.pageName,
                name: AppRoute.usersWithOrdersList.name,
                builder: (context, state) {
                  var args = state.extra as UsersWithOrdersListArgs;
                  return UsersWithOrdersList(
                      adminUid: args.adminUid, orderFilter: args.orderFilter);
                },
                routes: [
                  GoRoute(
                    path: AppRoute.usersWithOrdersDetails.pageName,
                    name: AppRoute.usersWithOrdersDetails.name,
                    builder: (context, state) {
                      var args = state.extra as UsersWithOrdersDetailsArgs;
                      return UsersWithOrdersDetails(
                          userWithOrder: args.userWithOrder,
                          forActualDelivery: args.forActualDelivery);
                    },
                  ),
                ]),
            GoRoute(
              path: AppRoute.rules.pageName,
              name: AppRoute.rules.name,
              builder: (context, state) => Rules(),
            ),
            GoRoute(
              path: AppRoute.masterOrderPage.pageName,
              name: AppRoute.masterOrderPage.name,
              builder: (context, state) => MasterOrderPage(),
            ),
            GoRoute(
                path: AppRoute.actualDeliveryPage.pageName,
                name: AppRoute.actualDeliveryPage.name,
                builder: (context, state) => ActualDeliveryPage(),
                routes: [
                  GoRoute(
                    path: AppRoute.ordersAdjustmentList.pageName,
                    name: AppRoute.ordersAdjustmentList.name,
                    builder: (context, state) => OrdersAdjustmentList(),
                  ),
                ]),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
          path: AppRoute.panel.path,
          name: AppRoute.panel.name,
          builder: (context, state) => Panel(),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoute.viewProducts.pageName,
              name: AppRoute.viewProducts.name,
              builder: (context, state) {
                final args =
                    (state.extra as ViewProductsArgs? ?? ViewProductsArgs());
                return ViewProducts(
                  initialBrand: args.initialBrand,
                  initialCategory: args.initialCategory,
                  initialStatus: args.initialStatus,
                  initialUpdatedWithin: args.initialUpdatedWithin,
                  mode: args.mode,
                );
              },
            ),
            GoRoute(
              path: AppRoute.viewProductDetails.pageName,
              name: AppRoute.viewProductDetails.name,
              builder: (context, state) => ViewProductDetails(),
            ),
            GoRoute(
              path: AppRoute.productMaker.pageName,
              name: AppRoute.productMaker.name,
              builder: (context, state) {
                var args = state.extra as ProductMakerScreenArgs;
                return ProductMakerScreen(
                    mode: args.mode, secondSelection: args.secondSelection);
              },
            ),
            GoRoute(
              path: AppRoute.manageProduct.pageName,
              name: AppRoute.manageProduct.name,
              builder: (context, state) => ManageProductScreen(),
            ),
            GoRoute(
              path: AppRoute.discountSections.pageName,
              name: AppRoute.discountSections.name,
              builder: (context, state) => DiscountSections(),
            ),
            GoRoute(
              path: AppRoute.logs.pageName,
              name: AppRoute.logs.name,
              builder: (context, state) => LogsView(),
            ),
            GoRoute(
              path: AppRoute.discountSectionView.pageName,
              name: AppRoute.discountSectionView.name,
              builder: (context, state) {
                final args = (state.extra as DiscountSectionViewArgs? ??
                    DiscountSectionViewArgs());
                return DiscountSectionView(
                    initialDisSectionId: args.initialDisSectionId,
                    initialDiscountFillFilter: args.initialDiscountFillFilter);
              },
            ),
            GoRoute(
              path: AppRoute.discountSectionBuilderPage.pageName,
              name: AppRoute.discountSectionBuilderPage.name,
              builder: (context, state) => DiscountSectionBuilderPage(),
            ),
            GoRoute(
              path: AppRoute.clientsAndAdminsView.pageName,
              name: AppRoute.clientsAndAdminsView.name,
              builder: (context, state) {
                final args = (state.extra as ClientsAndAdminsViewArgs? ??
                    ClientsAndAdminsViewArgs());
                return ClientsAndAdminsView(
                  initPendingKyc: args.initPendingKyc,
                  initUserStatus: args.initUserStatus,
                  initAdminId: args.initAdminId,
                );
              },
            ),
            GoRoute(
              path: AppRoute.adminsView.pageName,
              name: AppRoute.adminsView.name,
              builder: (context, state) => AdminsView(),
            ),
            GoRoute(
              path: AppRoute.userDetailsView.pageName,
              name: AppRoute.userDetailsView.name,
              builder: (context, state) =>
                  UserDetailsView(userUid: state.extra as String),
            ),
            GoRoute(
              path: AppRoute.userOrdersHistory.pageName,
              name: AppRoute.userOrdersHistory.name,
              builder: (context, state) => UserOrdersHistory(),
              routes: [
                GoRoute(
                  path: AppRoute.userOrdersDetail.pageName,
                  name: AppRoute.userOrdersDetail.name,
                  builder: (context, state) {
                    var args = state.extra as UserOrdersDetailScreenArgs;
                    return UserOrderDetailScreen(
                        selectedDay: args.selectedDay, user: args.user);
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppRoute.masterOrdersHistory.pageName,
              name: AppRoute.masterOrdersHistory.name,
              builder: (context, state) {
                var forActualDelivery = state.extra as bool? ?? false;
                return MainOrdersHistory(forActualDelivery: forActualDelivery);
              },
              routes: [
                GoRoute(
                  path: AppRoute.mainOrdersDetail.pageName,
                  name: AppRoute.mainOrdersDetail.name,
                  builder: (context, state) {
                    var args = state.extra as MainOrderDetailScreenArgs;
                    return MainOrdersDetailScreen(
                        selectedDate: args.selectedDate,
                        forActualDelivery: args.forActualDelivery);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: <RouteBase>[
        GoRoute(
          path: AppRoute.account.path,
          name: AppRoute.account.name,
          builder: (context, state) => const Account(),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoute.settings.pageName,
              name: AppRoute.settings.name,
              builder: (context, state) => Settings(user: state.extra as UserX),
            ),
          ],
        ),
      ],
    ),
  ];
}
