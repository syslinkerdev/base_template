import 'package:external_app_launcher/external_app_launcher.dart';

class AppLauncherService {
  static Future<void> openOrdersApp() async => await LaunchApp.openApp(
      androidPackageName: 'com.dairyB2b.orders', openStore: false);

  static Future<void> openManagementApp() async => await LaunchApp.openApp(
      androidPackageName: 'com.dairyB2b.management', openStore: false);
}
