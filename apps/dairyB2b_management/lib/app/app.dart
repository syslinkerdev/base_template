import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/app_base/app_state_listener.dart';
import 'package:core/core.dart';

import 'package:dairyB2b_management/router/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStateListener = AppStateListener(ref, AppRouter.router);
    appStateListener.setupListener();
    return MaterialApp.router(
      title: '${AppEnv.companyName} ${AppEnv.appName}',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: BAppTheme.lightTheme,
      darkTheme: BAppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
