// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_blocks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DataBlock3 {
  String get v1;
  String get v2;
  String get v3;

  /// Create a copy of DataBlock3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DataBlock3CopyWith<DataBlock3> get copyWith =>
      _$DataBlock3CopyWithImpl<DataBlock3>(this as DataBlock3, _$identity);

  /// Serializes this DataBlock3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DataBlock3 &&
            (identical(other.v1, v1) || other.v1 == v1) &&
            (identical(other.v2, v2) || other.v2 == v2) &&
            (identical(other.v3, v3) || other.v3 == v3));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, v1, v2, v3);

  @override
  String toString() {
    return 'DataBlock3(v1: $v1, v2: $v2, v3: $v3)';
  }
}

/// @nodoc
abstract mixin class $DataBlock3CopyWith<$Res> {
  factory $DataBlock3CopyWith(
          DataBlock3 value, $Res Function(DataBlock3) _then) =
      _$DataBlock3CopyWithImpl;
  @useResult
  $Res call({String v1, String v2, String v3});
}

/// @nodoc
class _$DataBlock3CopyWithImpl<$Res> implements $DataBlock3CopyWith<$Res> {
  _$DataBlock3CopyWithImpl(this._self, this._then);

  final DataBlock3 _self;
  final $Res Function(DataBlock3) _then;

  /// Create a copy of DataBlock3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? v1 = null,
    Object? v2 = null,
    Object? v3 = null,
  }) {
    return _then(_self.copyWith(
      v1: null == v1
          ? _self.v1
          : v1 // ignore: cast_nullable_to_non_nullable
              as String,
      v2: null == v2
          ? _self.v2
          : v2 // ignore: cast_nullable_to_non_nullable
              as String,
      v3: null == v3
          ? _self.v3
          : v3 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [DataBlock3].
extension DataBlock3Patterns on DataBlock3 {
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
    TResult Function(_DataBlock3 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DataBlock3() when $default != null:
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
    TResult Function(_DataBlock3 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DataBlock3():
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
    TResult? Function(_DataBlock3 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DataBlock3() when $default != null:
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
    TResult Function(String v1, String v2, String v3)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DataBlock3() when $default != null:
        return $default(_that.v1, _that.v2, _that.v3);
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
    TResult Function(String v1, String v2, String v3) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DataBlock3():
        return $default(_that.v1, _that.v2, _that.v3);
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
    TResult? Function(String v1, String v2, String v3)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DataBlock3() when $default != null:
        return $default(_that.v1, _that.v2, _that.v3);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DataBlock3 extends DataBlock3 {
  const _DataBlock3({required this.v1, required this.v2, required this.v3})
      : super._();
  factory _DataBlock3.fromJson(Map<String, dynamic> json) =>
      _$DataBlock3FromJson(json);

  @override
  final String v1;
  @override
  final String v2;
  @override
  final String v3;

  /// Create a copy of DataBlock3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DataBlock3CopyWith<_DataBlock3> get copyWith =>
      __$DataBlock3CopyWithImpl<_DataBlock3>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DataBlock3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DataBlock3 &&
            (identical(other.v1, v1) || other.v1 == v1) &&
            (identical(other.v2, v2) || other.v2 == v2) &&
            (identical(other.v3, v3) || other.v3 == v3));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, v1, v2, v3);

  @override
  String toString() {
    return 'DataBlock3(v1: $v1, v2: $v2, v3: $v3)';
  }
}

/// @nodoc
abstract mixin class _$DataBlock3CopyWith<$Res>
    implements $DataBlock3CopyWith<$Res> {
  factory _$DataBlock3CopyWith(
          _DataBlock3 value, $Res Function(_DataBlock3) _then) =
      __$DataBlock3CopyWithImpl;
  @override
  @useResult
  $Res call({String v1, String v2, String v3});
}

/// @nodoc
class __$DataBlock3CopyWithImpl<$Res> implements _$DataBlock3CopyWith<$Res> {
  __$DataBlock3CopyWithImpl(this._self, this._then);

  final _DataBlock3 _self;
  final $Res Function(_DataBlock3) _then;

  /// Create a copy of DataBlock3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? v1 = null,
    Object? v2 = null,
    Object? v3 = null,
  }) {
    return _then(_DataBlock3(
      v1: null == v1
          ? _self.v1
          : v1 // ignore: cast_nullable_to_non_nullable
              as String,
      v2: null == v2
          ? _self.v2
          : v2 // ignore: cast_nullable_to_non_nullable
              as String,
      v3: null == v3
          ? _self.v3
          : v3 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
