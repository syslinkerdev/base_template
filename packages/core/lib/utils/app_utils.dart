import 'package:package_info_plus/package_info_plus.dart';

class AppUtils {
  /// Returns the app version (e.g., "1.0.3")
  static Future<String> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// Returns the full version name like "1.0.3+7"
  static Future<String> getFullAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version}+${packageInfo.buildNumber}";
  }

  /// Returns app name (optional)
  static Future<String> getAppName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }
}
