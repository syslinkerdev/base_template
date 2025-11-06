// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LogModel _$LogModelFromJson(Map<String, dynamic> json) => _LogModel(
      id: json['id'] as String,
      type: LogTypeConverter.fromJson(json['type'] as Object),
      message: json['message'] as String,
      createdAt: TimeStampConverter.fromJson(json['created_at']),
      userId: json['user_id'] as String?,
      userName: json['user_name'] as String?,
      userRole: RoleConverter.fromJsonNullable(json['user_role']),
      route: json['route'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LogModelToJson(_LogModel instance) => <String, dynamic>{
      'id': instance.id,
      'type': LogTypeConverter.toJson(instance.type),
      'message': instance.message,
      'created_at': instance.createdAt.toIso8601String(),
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_role': RoleConverter.toJsonNullable(instance.userRole),
      'route': instance.route,
      'metadata': instance.metadata,
    };
