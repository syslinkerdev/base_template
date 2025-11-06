class EnumJsonConverter<T extends Enum> {
  final List<T> values;

  const EnumJsonConverter(this.values);

  T fromJson(Object json) {
    return values.byName(json as String);
  }

  String toJson(T value) {
    return value.name;
  }

  T? fromJsonNullable(Object? json) {
    if (json == null) return null;
    return fromJson(json);
  }

  String? toJsonNullable(T? value) {
    return value?.name;
  }
}
