import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/app_base/app_state.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/router/app_router.dart';
import 'package:repo/repo.dart';

class AppStateListener {
  final WidgetRef ref;
  final GoRouter appRouter;

  AppStateListener(this.ref, this.appRouter);

  static bool _initialHandled = false;
  ProviderSubscription<AsyncValue<UserX?>>? _userListenerSub;

  void setupListener() {
    //print('📡 AppStateListener setup');
    //print('_initialHandled $_initialHandled');

    // Listen to app state changes for navigation
    ref.listen<AppState>(
      appStateXProvider,
      (previous, next) {
        if (previous != next) {
          //print('🔥 AppState changed from $previous to $next');
          _handleStateChange(next);
        }
      },
    );

    // Initial one-time handling after app start
    if (!_initialHandled) {
      _initialHandled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final current = ref.read(appStateXProvider);
        // print('🚀 App launched with state: ${current.status}');
        FlutterNativeSplash.remove();
        _handleStateChange(current);
      });
    }
  }

  void _handleStateChange(AppState state) {
    //print('🧭 Navigating for status: ${state.status}');

    switch (state.status) {
      case AppStatus.unAuthorized:
        //print('🔄 Resetting user listener (logged out/unAuthorized)');
        _cancelUserListener();
        _navigateLogIn();
        break;
      case AppStatus.otpVerified:
        _goIfNeeded(AppRoute.kyc.path, '🔐 OTP Verified');
        break;
      case AppStatus.kycCompleted:
        _navigateCreatePin(state);
        break;
      case AppStatus.pinCompleted:
        _navigateWelcome(state);
        break;
      case AppStatus.authorized:
        //print('✅ App authorized — attach user listener for ${state.uId}');
        _listenToUserDoc(state.uId);
        break;
      case AppStatus.deleted:
        // Cancel any existing listener, then navigate to delete-account flow
        _cancelUserListener();
        _goIfNeeded(
          AppRoute.deleteAccount.path,
          '🗑️ Account marked deleted',
          extra: DeleteAccountArgs(
            uId: state.uId,
            onRecoverAccount: (ref) =>
                ref.read(appStateXProvider.notifier).markUnAuthorized(),
            onCreateNewAccount: (ref) =>
                ref.read(appStateXProvider.notifier).resetToInitial(),
          ),
        );
        break;
      case AppStatus.unknown:
        _navigatePhoneVerification();
        break;
    }
  }

  /// Attach a global listener to the user's Firestore doc stream.
  /// If a listener already exists, we skip attaching another one.
  void _listenToUserDoc(String uId) {
    if (_userListenerSub != null) {
      //print('⚠️ User listener already active for a uid — skipping attach.');
      return;
    }

    //print('🔌 Attaching user listener for $uId');

    // listenManual with explicit generic to avoid `dynamic` issues
    _userListenerSub = ref.listenManual<AsyncValue<UserX?>>(
      fetchUserStreamProvider(uId: uId),
      (_, next) {
        // next is AsyncValue<UserX?> — handle its states explicitly
        next.when(
          data: (user) {
            if (user == null) {
              return;
            }
            //print('📡 User update: uid=${user.uid}, status=${user.status}');
            _handleUser(user);
          },
          loading: () {
            //print('⏳ Waiting for user doc snapshot...');
            // optionally show loading UI elsewhere
          },
          error: (err, stack) {
            // Log the error and decide whether to cancel or retry
            //print('🔥 Error in user stream for $uId: $err');
            // Do not cancel automatically on transient errors; react as per your needs
          },
        );
      },
    );
  }

  /// Central place to react to user changes that require navigation.
  void _handleUser(UserX user) {
    // If suspended we already handled earlier, but double-check
    if (user.status == UserStatus.suspended) {
      //print('🚨 User is suspended, navigating to suspended screen...');
      _goIfNeeded(AppRoute.suspended.path, '🚨 Suspended', extra: user);
      return;
    }

    // // If user is deleted according to doc field, treat similarly
    // if (user.status == UserStatus.deleted) {
    //   //print('🗑️ User doc marked deleted — cancelling listener and marking deleted');
    //   _cancelUserListener();
    //   ref.read(appStateXProvider.notifier).markDeleted(user.uid);
    //   return;
    // }

    GlobalCacheService.instance.setUser(user);
    final currentPath = AppRouter.router.state.uri.path;
    //print('currentPath $currentPath');

    // If we come from certain paths, navigate to home (today)
    if (currentPath == AppRoute.suspended.path ||
        currentPath == AppRoute.initial.path ||
        currentPath == AppRoute.logIn.path ||
        currentPath == AppRoute.welcome.path) {
      //print('🎉 User active — moving to home (today)');
      _goIfNeeded(AppRoute.board.path, '🎉 Authorized');
    }
  }

  /// Cancel active user listener safely.
  void _cancelUserListener() {
    if (_userListenerSub != null) {
      //print('🧹 Cancelling user listener');
      try {
        _userListenerSub?.close();
      } catch (e) {
        // close() should be safe; but guard against unexpected errors
        //print('⚠️ Error while closing user listener: $e');
      }
      _userListenerSub = null;
    }
  }

  void _navigateLogIn() => _goIfNeeded(
        AppRoute.logIn.path,
        '🔒 User is unauthorized',
        extra: LogInArgs(
          onLogInSuccess: (uId, role) =>
              ref.read(appStateXProvider.notifier).logIn(uId: uId, role: role),
          phoneForAccessCodePress: (context, phoneNo) =>
              AppRoute.accessCodeVerification.push(
            context,
            extra: AccessCodeVerificationArgs(
              phoneNo: phoneNo,
              forForgotPIN: (ctx, uId) => AppRoute.forgotPin.push(
                ctx,
                extra: ForgotPinArgs(
                  uId: uId,
                  onSuccess: (ctxF) =>
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(ctxF).popUntil(
                      (route) => route.settings.name == AppRoute.logIn.name,
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      );

  void _navigateCreatePin(AppState state) => _goIfNeeded(
        AppRoute.createPIN.path,
        '✅ KYC Done',
        extra: CreatePinArgs(
          uId: state.uId,
          onSuccess: (ref) =>
              ref.read(appStateXProvider.notifier).markPinCompleted(),
        ),
      );

  void _navigateWelcome(AppState state) => _goIfNeeded(
        AppRoute.welcome.path,
        '🔓 PIN Complete',
        extra: WelcomeScreenArgs(
          role: state.role,
          onMarkAuthorized: () {
            if (state.status != AppStatus.authorized) {
              ref.read(appStateXProvider.notifier).markAuthorized();
            }
          },
        ),
      );

  void _navigatePhoneVerification() => _goIfNeeded(
        AppRoute.phoneNoVerification.path,
        '📱 Phone verification required',
        extra: PhoneInputScreenArgs(
          forAdmin: true,
          onCodeSent: (context) => AppRoute.otp.push(
            context,
            extra: OtpInputScreenArgs(
              onUserNotPresent: (ref) =>
                  ref.read(appStateXProvider.notifier).markOtpVerified(),
              onUserPresent: (user, ref) {
                if (user.role == null || user.role == Role.client) {
                  AppRoute.unauthAccess.go(context, extra: user);
                } else {
                  ref.read(appStateXProvider.notifier).markUnAuthorized();
                }
              },
              onDeletedUserFound: (deletedUser, ref) => ref
                  .read(appStateXProvider.notifier)
                  .markDeleted(deletedUser.uid),
            ),
          ),
        ),
      );

  void _goIfNeeded(String path, String log, {Object? extra}) {
    final currentPath = appRouter.state.uri.path;
    if (currentPath != path) {
      //print(log);
      appRouter.go(path, extra: extra);
    }
  }
}
