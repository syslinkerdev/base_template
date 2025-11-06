// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'log_model.freezed.dart';
part 'log_model.g.dart';

@freezed
abstract class LogModel with _$LogModel {
  const LogModel._();

  const factory LogModel({
    required String id,
    @JsonKey(
        name: 'type',
        fromJson: LogTypeConverter.fromJson,
        toJson: LogTypeConverter.toJson)
    required LogType type,
    required String message,
    @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
    required DateTime createdAt,

    // Optional user info
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(
        name: 'user_role',
        fromJson: RoleConverter.fromJsonNullable,
        toJson: RoleConverter.toJsonNullable)
    Role? userRole,
    @JsonKey(name: 'route') String? route,
    @JsonKey(name: 'metadata') Map<String, dynamic>? metadata,
  }) = _LogModel;

  factory LogModel.fromJson(Map<String, dynamic> json) =>
      _$LogModelFromJson(json);
}

extension LogModelApi on LogModel {
  Map<String, dynamic> toDocument() => {
      'id': id,
      'type': LogTypeConverter.toJson(type),
      'message': message,
      'created_at': createdAt,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (userRole != null) 'user_role': RoleConverter.toJsonNullable(userRole),
      if (route != null) 'route': route,
      if (metadata != null) 'metadata': metadata,
    };
}
