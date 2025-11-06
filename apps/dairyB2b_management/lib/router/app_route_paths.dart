import 'package:core/core.dart';

extension AppRoute on RouteX {
  // Static route definitions with hierarchy
  static final RouteX initial = RouteX(pageName: '/', name: 'initial');
  static final RouteX phoneNoVerification =
      RouteX(pageName: 'phoneNoVerification');
  static final RouteX otp = RouteX(pageName: 'otp');
  static final RouteX logIn = RouteX(pageName: 'logIn');
  static final RouteX forgotPin = RouteX(pageName: 'forgotPin');
  static final RouteX createPIN = RouteX(pageName: 'createPIN');
  static final RouteX kyc = RouteX(pageName: 'kyc');
  static final RouteX welcome = RouteX(pageName: 'welcome');
  static final RouteX accessCodeVerification =
      RouteX(pageName: 'accessCodeVerification');
  static final RouteX deleteAccount = RouteX(pageName: 'deleteAccount');
  static final RouteX softDelete = RouteX(pageName: 'softDelete');
  // static final RouteX comingSoon = RouteX(pageName: 'comingSoon');
  static final RouteX unauthAccess = RouteX(pageName: 'unauthAccess');
  static final RouteX suspended = RouteX(pageName: 'suspended');
  static final RouteX companyReport = RouteX(pageName: 'companyReport');
  static final RouteX productsOrdered =
      RouteX(pageName: 'productsOrdered', parent: companyReport);
  static final RouteX whoOrdered =
      RouteX(pageName: 'whoOrdered', parent: companyReport);
  static final RouteX adjustment = RouteX(pageName: 'adjustment');

  //  features
  static final RouteX board = RouteX(pageName: 'board');
  static final RouteX masterOrderPage =
      RouteX(pageName: 'masterOrderPage', parent: board);
  static final RouteX actualDeliveryPage =
      RouteX(pageName: 'actualDeliveryPage', parent: board);
  static final RouteX ordersAdjustmentList =
      RouteX(pageName: 'ordersAdjustmentList', parent: actualDeliveryPage);
  static final RouteX usersWithOrdersList =
      RouteX(pageName: 'usersWithOrdersList', parent: board);
  static final RouteX usersWithOrdersDetails =
      RouteX(pageName: 'usersWithOrdersDetails', parent: usersWithOrdersList);
  static final RouteX rules = RouteX(pageName: 'rules', parent: board);
  static final RouteX claims = RouteX(pageName: 'claims');
  static final RouteX panel = RouteX(pageName: 'panel');
  // Manage Products
  static final RouteX viewProducts =
      RouteX(pageName: 'viewProducts', parent: panel);
  static final RouteX viewProductDetails =
      RouteX(pageName: 'viewProductDetails', parent: panel);
  static final RouteX productMaker =
      RouteX(pageName: 'productMaker', parent: panel);
  static final RouteX manageProduct =
      RouteX(pageName: 'manageProduct', parent: panel);
  // Extras
  static final RouteX discountSections =
      RouteX(pageName: 'discountSections', parent: panel);
  static final RouteX discountSectionView =
      RouteX(pageName: 'discountSectionView', parent: panel);
  static final RouteX discountSectionBuilderPage =
      RouteX(pageName: 'discountSectionBuilderPage', parent: panel);
  static final RouteX logs = RouteX(pageName: 'logs', parent: panel);
  // Clients & Admins
  static final RouteX clientsAndAdminsView =
      RouteX(pageName: 'clientsAndAdminsView', parent: panel);
  static final RouteX adminsView =
      RouteX(pageName: 'adminsView', parent: panel);
  static final RouteX userDetailsView =
      RouteX(pageName: 'userDetailsView', parent: panel);
  // Order Reports
  static final RouteX userOrdersHistory =
      RouteX(pageName: 'userOrdersHistory', parent: panel);
  static final RouteX userOrdersDetail =
      RouteX(pageName: 'userOrdersDetail', parent: userOrdersHistory);
  static final RouteX masterOrdersHistory =
      RouteX(pageName: 'masterOrdersHistory', parent: panel);
  static final RouteX mainOrdersDetail =
      RouteX(pageName: 'mainOrdersDetail', parent: masterOrdersHistory);
  static final RouteX account = RouteX(pageName: 'account');
  static final RouteX settings = RouteX(pageName: 'settings', parent: account);
  // children of home
  static RouteX knowYourColors =
      RouteX(pageName: 'knowYourColors', parent: board);
}
