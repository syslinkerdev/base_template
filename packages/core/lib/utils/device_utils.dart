import 'dart:io' as io;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceUtils {
  static Future<Map<String, dynamic>> getPlatformMetadata() async {
    final deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      final info = await deviceInfo.webBrowserInfo;
      return {
        'platform': 'web',
        'browserName': describeEnum(info.browserName),
        'userAgent': info.userAgent ?? '',
        'appVersion': info.appVersion ?? '',
      };
    } else if (io.Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return {
        'platform': 'android',
        'model': info.model,
        'manufacturer': info.manufacturer,
        'version': info.version.release,
        'sdkInt': info.version.sdkInt,
      };
    } else if (io.Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return {
        'platform': 'ios',
        'model': info.utsname.machine,
        'systemName': info.systemName,
        'systemVersion': info.systemVersion,
        'name': info.name,
      };
    } else {
      return {
        'platform': 'unknown',
        'details': 'Not Android, iOS or Web',
      };
    }
  }
}
