// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppState _$AppStateFromJson(Map<String, dynamic> json) => _AppState(
      uId: json['uId'] as String? ?? 'empty user',
      status: json['status'] == null
          ? AppStatus.unknown
          : AppStatusConverter.fromJson(json['status'] as Object),
      role: json['role'] == null
          ? Role.client
          : RoleConverter.fromJson(json['role'] as Object),
    );

Map<String, dynamic> _$AppStateToJson(_AppState instance) => <String, dynamic>{
      'uId': instance.uId,
      'status': AppStatusConverter.toJson(instance.status),
      'role': RoleConverter.toJson(instance.role),
    };
