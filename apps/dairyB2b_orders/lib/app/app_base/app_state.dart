// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'app_state.freezed.dart';
part 'app_state.g.dart';


@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default('empty user') String uId,
    @JsonKey(fromJson: AppStatusConverter.fromJson, toJson: AppStatusConverter.toJson)
    @Default(AppStatus.unknown)
    AppStatus status,
    @JsonKey(fromJson: RoleConverter.fromJson, toJson: RoleConverter.toJson)
    @Default(Role.client)
    Role role,
  }) = _AppState;

  factory AppState.empty() =>
      AppState(uId: 'empty user', status: AppStatus.unknown, role: Role.client);

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}
