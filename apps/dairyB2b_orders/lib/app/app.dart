import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/router/app_router.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_listener.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppStateListener(ref).setupListener();
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
