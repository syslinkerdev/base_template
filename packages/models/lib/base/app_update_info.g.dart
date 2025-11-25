// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUpdateInfo _$AppUpdateInfoFromJson(Map<String, dynamic> json) =>
    _AppUpdateInfo(
      appName: json['app_name'] as String,
      version: json['version'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$AppUpdateInfoToJson(_AppUpdateInfo instance) =>
    <String, dynamic>{
      'app_name': instance.appName,
      'version': instance.version,
      'url': instance.url,
    };
