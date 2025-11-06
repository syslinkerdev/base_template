import 'package:auth/auth.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/app_base/unauthorized_access_screen.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/adjustment_screen.dart';
import 'package:dairyB2b_management/app/features/kyc/ui/kyc_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/company_report_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/products_ordered_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/who_ordered_screen.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/router/shell_router.dart';
import 'package:dairyB2b_management/router/scaffold_with_nav_bar.dart';
import 'package:system_assets/app_images.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final context = rootNavigatorKey.currentState?.context;
  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoute.initial.path,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoute.initial.path,
        name: AppRoute.initial.name,
        builder: (context, state) => const SplashScreen(logo: sysImages.MMlogo),
      ),
      GoRoute(
        path: AppRoute.logIn.path,
        name: AppRoute.logIn.name,
        builder: (context, state) {
          final args = state.extra as LogInArgs;
          return LogIn(
            onLogInSuccess: args.onLogInSuccess,
            phoneForAccessCodePress: args.phoneForAccessCodePress,
          );
        },
      ),
      GoRoute(
        path: AppRoute.accessCodeVerification.path,
        name: AppRoute.accessCodeVerification.name,
        builder: (context, state) {
          final args = state.extra as AccessCodeVerificationArgs;
          return AccessCodeVerification(
              phoneNo: args.phoneNo,
              forForgotPIN: args.forForgotPIN,
              forDeleteAccount: args.forDeleteAccount);
        },
      ),
      GoRoute(
        path: AppRoute.deleteAccount.path,
        name: AppRoute.deleteAccount.name,
        builder: (context, state) {
          final args = state.extra as DeleteAccountArgs;
          return DeleteAccount(
              uId: args.uId,
              onRecoverAccount: args.onRecoverAccount,
              onCreateNewAccount: args.onCreateNewAccount);
        },
      ),
      GoRoute(
        path: AppRoute.softDelete.path,
        name: AppRoute.softDelete.name,
        builder: (context, state) {
          final args = state.extra as SoftDeleteArgs;
          return SoftDelete(
              user: args.user,
              afterSoftDeleteProcess: args.afterSoftDeleteProcess);
        },
      ),
      GoRoute(
        path: AppRoute.forgotPin.path,
        name: AppRoute.forgotPin.name,
        builder: (context, state) {
          final args = state.extra as ForgotPinArgs;
          return ForgotPin(uId: args.uId, onSuccess: args.onSuccess);
        },
      ),
      GoRoute(
        path: AppRoute.phoneNoVerification.path,
        name: AppRoute.phoneNoVerification.name,
        builder: (context, state) {
          final args = state.extra as PhoneInputScreenArgs;
          return PhoneInputScreen(
              onCodeSent: args.onCodeSent, forAdmin: args.forAdmin);
        },
      ),
      GoRoute(
        path: AppRoute.otp.path,
        name: AppRoute.otp.name,
        builder: (context, state) {
          final args = state.extra as OtpInputScreenArgs;
          return OtpInputScreen(
              onUserNotPresent: args.onUserNotPresent,
              onUserPresent: args.onUserPresent,
              onDeletedUserFound: args.onDeletedUserFound);
        },
      ),
      GoRoute(
        path: AppRoute.kyc.path,
        name: AppRoute.kyc.name,
        builder: (context, state) => const KycScreen(),
      ),
      GoRoute(
        path: AppRoute.createPIN.path,
        name: AppRoute.createPIN.name,
        builder: (context, state) {
          final args = state.extra as CreatePinArgs;
          return CreatePin(uId: args.uId, onSuccess: args.onSuccess);
        },
      ),
      GoRoute(
        path: AppRoute.welcome.path,
        name: AppRoute.welcome.name,
        builder: (context, state) {
          final args = state.extra as WelcomeScreenArgs;
          return WelcomeScreen(
            role: args.role,
            onMarkAuthorized: args.onMarkAuthorized,
          );
        },
      ),
      // GoRoute(
      //   path: AppRoute.comingSoon.path,
      //   name: AppRoute.comingSoon.name,
      //   builder: (context, state) => ComingSoon(),
      // ),
      GoRoute(
        path: AppRoute.unauthAccess.path,
        name: AppRoute.unauthAccess.name,
        builder: (context, state) =>
            UnauthorizedAccessScreen(user: state.extra as UserX),
      ),
      GoRoute(
        path: AppRoute.suspended.path,
        name: AppRoute.suspended.name,
        builder: (context, state) =>
            SuspendedScreen(user: state.extra as UserX),
      ),
      GoRoute(
        path: AppRoute.companyReport.path,
        name: AppRoute.companyReport.name,
        builder: (context, state) {
          var args = state.extra as CompanyReportScreenArgs;
          return CompanyReportScreen(
              brand: args.brand,
              selectedDate: args.selectedDate,
              forActualDelivery: args.forActualDelivery);
        },
        routes: [
          GoRoute(
            path: AppRoute.productsOrdered.pageName,
            name: AppRoute.productsOrdered.name,
            builder: (context, state) {
              var args = state.extra as ProductsOrderedScreenArgs;
              return ProductsOrderedScreen(
                  productLines: args.productLines,
                  companyEntry: args.companyEntry);
            },
          ),
          GoRoute(
            path: AppRoute.whoOrdered.pageName,
            name: AppRoute.whoOrdered.name,
            builder: (context, state) {
              var args = state.extra as WhoOrderedScreenArgs;
              return WhoOrderedScreen(
                  demandLines: args.demandLines,
                  companyEntry: args.companyEntry);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.adjustment.path,
        name: AppRoute.adjustment.name,
        builder: (context, state) => AdjustmentScreen(),
      ),
      StatefulShellRoute.indexedStack(
        branches: ShellRouter.shellBranches,
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
      ),
    ],
  );
}
