// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_update_info.freezed.dart';
part 'app_update_info.g.dart';

@freezed
abstract class AppUpdateInfo with _$AppUpdateInfo {
  const AppUpdateInfo._();

  factory AppUpdateInfo({
    @JsonKey(name: 'app_name')
    required String appName, // the identifier of the app (e.g., "orders")
    required String version, // the latest version string (e.g., "v1.2.0")
    required String url, // download URL for the APK
  }) = _AppUpdateInfo;

  // Optional: empty constructor for default / placeholder
  factory AppUpdateInfo.empty() => AppUpdateInfo(
        appName: '',
        version: '',
        url: '',
      );

  bool get isEmpty => this == AppUpdateInfo.empty();
  bool get isNotEmpty => !isEmpty;

  static const String docId = 'app_updates';
  static const String fieldName = 'updates';

  factory AppUpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateInfoFromJson(json);
}
