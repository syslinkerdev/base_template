// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meta_data_x.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
MetaDataX _$MetaDataXFromJson(Map<String, dynamic> json) {
  return _MetaData.fromJson(json);
}

/// @nodoc
mixin _$MetaDataX {
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get createdAt;
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get updatedAt;
  @JsonKey(name: 'updated_by')
  String? get updatedBy;

  /// Create a copy of MetaDataX
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MetaDataXCopyWith<MetaDataX> get copyWith =>
      _$MetaDataXCopyWithImpl<MetaDataX>(this as MetaDataX, _$identity);

  /// Serializes this MetaDataX to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MetaDataX &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, createdAt, createdBy, updatedAt, updatedBy);

  @override
  String toString() {
    return 'MetaDataX(createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy)';
  }
}

/// @nodoc
abstract mixin class $MetaDataXCopyWith<$Res> {
  factory $MetaDataXCopyWith(MetaDataX value, $Res Function(MetaDataX) _then) =
      _$MetaDataXCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(
          name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? createdAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? updatedAt,
      @JsonKey(name: 'updated_by') String? updatedBy});
}

/// @nodoc
class _$MetaDataXCopyWithImpl<$Res> implements $MetaDataXCopyWith<$Res> {
  _$MetaDataXCopyWithImpl(this._self, this._then);

  final MetaDataX _self;
  final $Res Function(MetaDataX) _then;

  /// Create a copy of MetaDataX
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? createdBy = freezed,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(_self.copyWith(
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _self.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MetaDataX].
extension MetaDataXPatterns on MetaDataX {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MetaData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MetaData() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MetaData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MetaData():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MetaData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MetaData() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(
                name: 'created_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? createdAt,
            @JsonKey(name: 'created_by') String? createdBy,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt,
            @JsonKey(name: 'updated_by') String? updatedBy)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MetaData() when $default != null:
        return $default(
            _that.createdAt, _that.createdBy, _that.updatedAt, _that.updatedBy);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(
                name: 'created_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? createdAt,
            @JsonKey(name: 'created_by') String? createdBy,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt,
            @JsonKey(name: 'updated_by') String? updatedBy)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MetaData():
        return $default(
            _that.createdAt, _that.createdBy, _that.updatedAt, _that.updatedBy);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(
                name: 'created_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? createdAt,
            @JsonKey(name: 'created_by') String? createdBy,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt,
            @JsonKey(name: 'updated_by') String? updatedBy)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MetaData() when $default != null:
        return $default(
            _that.createdAt, _that.createdBy, _that.updatedAt, _that.updatedBy);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MetaData implements MetaDataX {
  const _MetaData(
      {@JsonKey(
          name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
      this.createdAt,
      @JsonKey(name: 'created_by') this.createdBy,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      this.updatedAt,
      @JsonKey(name: 'updated_by') this.updatedBy});
  factory _MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);

  @override
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @override
  @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'updated_by')
  final String? updatedBy;

  /// Create a copy of MetaDataX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MetaDataCopyWith<_MetaData> get copyWith =>
      __$MetaDataCopyWithImpl<_MetaData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MetaDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MetaData &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, createdAt, createdBy, updatedAt, updatedBy);

  @override
  String toString() {
    return 'MetaDataX(createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy)';
  }
}

/// @nodoc
abstract mixin class _$MetaDataCopyWith<$Res>
    implements $MetaDataXCopyWith<$Res> {
  factory _$MetaDataCopyWith(_MetaData value, $Res Function(_MetaData) _then) =
      __$MetaDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? createdAt,
      @JsonKey(name: 'created_by') String? createdBy,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? updatedAt,
      @JsonKey(name: 'updated_by') String? updatedBy});
}

/// @nodoc
class __$MetaDataCopyWithImpl<$Res> implements _$MetaDataCopyWith<$Res> {
  __$MetaDataCopyWithImpl(this._self, this._then);

  final _MetaData _self;
  final $Res Function(_MetaData) _then;

  /// Create a copy of MetaDataX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? createdAt = freezed,
    Object? createdBy = freezed,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
  }) {
    return _then(_MetaData(
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _self.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
