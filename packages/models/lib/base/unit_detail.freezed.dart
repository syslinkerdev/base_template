// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnitDetail {
  String get id; // e.g. "unit_001"
  double get value; // e.g. 500
  @JsonKey(name: 'short_form')
  String get unitShortForm; // e.g. "ml"
  @JsonKey(name: 'full_form')
  String get unitFullForm; // e.g. "Milliliter"
// NEW: conversion fields
  @JsonKey(name: 'display_base')
  String get displayBase; // e.g. "L", "Kg", "Piece"
  double get factor;

  /// Create a copy of UnitDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnitDetailCopyWith<UnitDetail> get copyWith =>
      _$UnitDetailCopyWithImpl<UnitDetail>(this as UnitDetail, _$identity);

  /// Serializes this UnitDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnitDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unitShortForm, unitShortForm) ||
                other.unitShortForm == unitShortForm) &&
            (identical(other.unitFullForm, unitFullForm) ||
                other.unitFullForm == unitFullForm) &&
            (identical(other.displayBase, displayBase) ||
                other.displayBase == displayBase) &&
            (identical(other.factor, factor) || other.factor == factor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, value, unitShortForm, unitFullForm, displayBase, factor);

  @override
  String toString() {
    return 'UnitDetail(id: $id, value: $value, unitShortForm: $unitShortForm, unitFullForm: $unitFullForm, displayBase: $displayBase, factor: $factor)';
  }
}

/// @nodoc
abstract mixin class $UnitDetailCopyWith<$Res> {
  factory $UnitDetailCopyWith(
          UnitDetail value, $Res Function(UnitDetail) _then) =
      _$UnitDetailCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      double value,
      @JsonKey(name: 'short_form') String unitShortForm,
      @JsonKey(name: 'full_form') String unitFullForm,
      @JsonKey(name: 'display_base') String displayBase,
      double factor});
}

/// @nodoc
class _$UnitDetailCopyWithImpl<$Res> implements $UnitDetailCopyWith<$Res> {
  _$UnitDetailCopyWithImpl(this._self, this._then);

  final UnitDetail _self;
  final $Res Function(UnitDetail) _then;

  /// Create a copy of UnitDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
    Object? unitShortForm = null,
    Object? unitFullForm = null,
    Object? displayBase = null,
    Object? factor = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unitShortForm: null == unitShortForm
          ? _self.unitShortForm
          : unitShortForm // ignore: cast_nullable_to_non_nullable
              as String,
      unitFullForm: null == unitFullForm
          ? _self.unitFullForm
          : unitFullForm // ignore: cast_nullable_to_non_nullable
              as String,
      displayBase: null == displayBase
          ? _self.displayBase
          : displayBase // ignore: cast_nullable_to_non_nullable
              as String,
      factor: null == factor
          ? _self.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [UnitDetail].
extension UnitDetailPatterns on UnitDetail {
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
    TResult Function(_UnitDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnitDetail() when $default != null:
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
    TResult Function(_UnitDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnitDetail():
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
    TResult? Function(_UnitDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnitDetail() when $default != null:
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
            String id,
            double value,
            @JsonKey(name: 'short_form') String unitShortForm,
            @JsonKey(name: 'full_form') String unitFullForm,
            @JsonKey(name: 'display_base') String displayBase,
            double factor)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnitDetail() when $default != null:
        return $default(_that.id, _that.value, _that.unitShortForm,
            _that.unitFullForm, _that.displayBase, _that.factor);
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
            String id,
            double value,
            @JsonKey(name: 'short_form') String unitShortForm,
            @JsonKey(name: 'full_form') String unitFullForm,
            @JsonKey(name: 'display_base') String displayBase,
            double factor)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnitDetail():
        return $default(_that.id, _that.value, _that.unitShortForm,
            _that.unitFullForm, _that.displayBase, _that.factor);
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
            String id,
            double value,
            @JsonKey(name: 'short_form') String unitShortForm,
            @JsonKey(name: 'full_form') String unitFullForm,
            @JsonKey(name: 'display_base') String displayBase,
            double factor)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnitDetail() when $default != null:
        return $default(_that.id, _that.value, _that.unitShortForm,
            _that.unitFullForm, _that.displayBase, _that.factor);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UnitDetail implements UnitDetail {
  _UnitDetail(
      {required this.id,
      required this.value,
      @JsonKey(name: 'short_form') required this.unitShortForm,
      @JsonKey(name: 'full_form') required this.unitFullForm,
      @JsonKey(name: 'display_base') required this.displayBase,
      required this.factor});
  factory _UnitDetail.fromJson(Map<String, dynamic> json) =>
      _$UnitDetailFromJson(json);

  @override
  final String id;
// e.g. "unit_001"
  @override
  final double value;
// e.g. 500
  @override
  @JsonKey(name: 'short_form')
  final String unitShortForm;
// e.g. "ml"
  @override
  @JsonKey(name: 'full_form')
  final String unitFullForm;
// e.g. "Milliliter"
// NEW: conversion fields
  @override
  @JsonKey(name: 'display_base')
  final String displayBase;
// e.g. "L", "Kg", "Piece"
  @override
  final double factor;

  /// Create a copy of UnitDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnitDetailCopyWith<_UnitDetail> get copyWith =>
      __$UnitDetailCopyWithImpl<_UnitDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UnitDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnitDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unitShortForm, unitShortForm) ||
                other.unitShortForm == unitShortForm) &&
            (identical(other.unitFullForm, unitFullForm) ||
                other.unitFullForm == unitFullForm) &&
            (identical(other.displayBase, displayBase) ||
                other.displayBase == displayBase) &&
            (identical(other.factor, factor) || other.factor == factor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, value, unitShortForm, unitFullForm, displayBase, factor);

  @override
  String toString() {
    return 'UnitDetail(id: $id, value: $value, unitShortForm: $unitShortForm, unitFullForm: $unitFullForm, displayBase: $displayBase, factor: $factor)';
  }
}

/// @nodoc
abstract mixin class _$UnitDetailCopyWith<$Res>
    implements $UnitDetailCopyWith<$Res> {
  factory _$UnitDetailCopyWith(
          _UnitDetail value, $Res Function(_UnitDetail) _then) =
      __$UnitDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      double value,
      @JsonKey(name: 'short_form') String unitShortForm,
      @JsonKey(name: 'full_form') String unitFullForm,
      @JsonKey(name: 'display_base') String displayBase,
      double factor});
}

/// @nodoc
class __$UnitDetailCopyWithImpl<$Res> implements _$UnitDetailCopyWith<$Res> {
  __$UnitDetailCopyWithImpl(this._self, this._then);

  final _UnitDetail _self;
  final $Res Function(_UnitDetail) _then;

  /// Create a copy of UnitDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? value = null,
    Object? unitShortForm = null,
    Object? unitFullForm = null,
    Object? displayBase = null,
    Object? factor = null,
  }) {
    return _then(_UnitDetail(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unitShortForm: null == unitShortForm
          ? _self.unitShortForm
          : unitShortForm // ignore: cast_nullable_to_non_nullable
              as String,
      unitFullForm: null == unitFullForm
          ? _self.unitFullForm
          : unitFullForm // ignore: cast_nullable_to_non_nullable
              as String,
      displayBase: null == displayBase
          ? _self.displayBase
          : displayBase // ignore: cast_nullable_to_non_nullable
              as String,
      factor: null == factor
          ? _self.factor
          : factor // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
