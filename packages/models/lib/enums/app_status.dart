import 'package:models/models.dart';

enum AppStatus {
  unknown,
  otpVerified,
  kycCompleted,
  pinCompleted,
  authorized,
  unAuthorized,
  deleted,
}

class AppStatusConverter {
  static final _converter = EnumJsonConverter(AppStatus.values);

  static AppStatus fromJson(Object json) => _converter.fromJson(json);
  static String toJson(AppStatus appStatus) => _converter.toJson(appStatus);
  static AppStatus? fromJsonNullable(Object? json) =>
      _converter.fromJsonNullable(json);
  static String? toJsonNullable(AppStatus? appStatus) =>
      _converter.toJsonNullable(appStatus);
}
