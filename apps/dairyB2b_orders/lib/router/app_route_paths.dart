import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';

extension AppRoute on RouteX {
  // Static route definitions with hierarchy
  static final RouteX initial = RouteX(pageName: '/', name: 'initial');
  static final RouteX phoneNoVerification =
      RouteX(pageName: 'phoneNoVerification');
  static final RouteX otp = RouteX(pageName: 'otp');
  static final RouteX logIn = RouteX(pageName: 'logIn');
  static final RouteX forgotPin = RouteX(pageName: 'forgotPin');
  static final RouteX kyc = RouteX(pageName: 'kyc');
  static final RouteX createPIN = RouteX(pageName: 'createPIN');
  static final RouteX adminEnroll = RouteX(pageName: 'adminEnroll');
  static final RouteX welcome = RouteX(pageName: 'welcome');
  static final RouteX accessCodeVerification =
      RouteX(pageName: 'accessCodeVerification');
  static final RouteX deleteAccount = RouteX(pageName: 'deleteAccount');
  static final RouteX softDelete = RouteX(pageName: 'softDelete');
  // static final RouteX comingSoon = RouteX(pageName: 'comingSoon');
  static final RouteX suspended = RouteX(pageName: 'suspended');

  // features
  static final RouteX home = RouteX(pageName: 'home');
  static final RouteX smartBasket =
      RouteX(pageName: 'smartBasket', parent: home);
  static final RouteX smartBasketDetails =
      RouteX(pageName: 'smartBasketDetails', parent: smartBasket);
  static final RouteX products = RouteX(pageName: 'products', parent: home);
  static final RouteX brandProducts =
      RouteX(pageName: 'brandProducts', parent: products);
  static final RouteX history = RouteX(pageName: 'history');
  static final RouteX historyDetail =
      RouteX(pageName: 'historyDetail', parent: history);
  static final RouteX cart = RouteX(pageName: 'cart');
  static final RouteX account = RouteX(pageName: 'account');

  // Account children routes
  static final RouteX settings = RouteX(pageName: 'settings', parent: account);
  static final RouteX yourAdmin =
      RouteX(pageName: 'yourAdmin', parent: account);
  static final RouteX aboutApp = RouteX(pageName: 'aboutApp', parent: account);
  static final RouteX discounts =
      RouteX(pageName: 'discounts', parent: account);

  // Settings children routes
  static final RouteX editAccount =
      RouteX(pageName: 'editAccount', parent: settings);
  static final RouteX editShop = RouteX(pageName: 'editShop', parent: settings);
  static final RouteX updatePin =
      RouteX(pageName: 'updatePin', parent: settings);
  static final RouteX confirmPin =
      RouteX(pageName: 'confirmPin', parent: settings);
  // Example of parameterized route
  static final RouteX userProfileRoute =
      RouteX.matched(pageName: 'profile', paramsKey: 'id', parent: settings);

  // children of App
  static RouteX knowYourColors =
      RouteX(pageName: 'knowYourColors', parent: home);

  /// Get Cart like sub
  static void pushSubCart(BuildContext context) async {
    StatefulNavigationShell.of(context).goBranch(1);
    if (context.mounted) {
      await ProviderScope.containerOf(context)
          .read(cartProvider.notifier)
          .loadFinalCart();
    }
  }
}
