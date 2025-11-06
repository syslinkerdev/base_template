import 'package:models/converters/enum_converter.dart';

enum LogType {
  unauthorizedAccess,
  login,
  logout,
  create,
  update,
  delete,
  error,
  custom,
}

class LogTypeConverter {
  static final _converter = EnumJsonConverter(LogType.values);

  static LogType fromJson(Object json) => _converter.fromJson(json);
  static String toJson(LogType type) => _converter.toJson(type);
  static LogType? fromJsonNullable(Object? json) =>
      _converter.fromJsonNullable(json);
  static String? toJsonNullable(LogType? type) =>
      _converter.toJsonNullable(type);
}
