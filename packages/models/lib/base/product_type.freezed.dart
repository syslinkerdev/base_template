// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductType {
  String get id;
  @JsonKey(name: 'short_form')
  String get shortForm;
  @JsonKey(name: 'full_form')
  String get fullForm;

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductTypeCopyWith<ProductType> get copyWith =>
      _$ProductTypeCopyWithImpl<ProductType>(this as ProductType, _$identity);

  /// Serializes this ProductType to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductType &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shortForm, shortForm) ||
                other.shortForm == shortForm) &&
            (identical(other.fullForm, fullForm) ||
                other.fullForm == fullForm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, shortForm, fullForm);

  @override
  String toString() {
    return 'ProductType(id: $id, shortForm: $shortForm, fullForm: $fullForm)';
  }
}

/// @nodoc
abstract mixin class $ProductTypeCopyWith<$Res> {
  factory $ProductTypeCopyWith(
          ProductType value, $Res Function(ProductType) _then) =
      _$ProductTypeCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'short_form') String shortForm,
      @JsonKey(name: 'full_form') String fullForm});
}

/// @nodoc
class _$ProductTypeCopyWithImpl<$Res> implements $ProductTypeCopyWith<$Res> {
  _$ProductTypeCopyWithImpl(this._self, this._then);

  final ProductType _self;
  final $Res Function(ProductType) _then;

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shortForm = null,
    Object? fullForm = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shortForm: null == shortForm
          ? _self.shortForm
          : shortForm // ignore: cast_nullable_to_non_nullable
              as String,
      fullForm: null == fullForm
          ? _self.fullForm
          : fullForm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProductType].
extension ProductTypePatterns on ProductType {
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
    TResult Function(_ProductType value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductType() when $default != null:
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
    TResult Function(_ProductType value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductType():
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
    TResult? Function(_ProductType value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductType() when $default != null:
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
    TResult Function(String id, @JsonKey(name: 'short_form') String shortForm,
            @JsonKey(name: 'full_form') String fullForm)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductType() when $default != null:
        return $default(_that.id, _that.shortForm, _that.fullForm);
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
    TResult Function(String id, @JsonKey(name: 'short_form') String shortForm,
            @JsonKey(name: 'full_form') String fullForm)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductType():
        return $default(_that.id, _that.shortForm, _that.fullForm);
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
    TResult? Function(String id, @JsonKey(name: 'short_form') String shortForm,
            @JsonKey(name: 'full_form') String fullForm)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductType() when $default != null:
        return $default(_that.id, _that.shortForm, _that.fullForm);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProductType implements ProductType {
  _ProductType(
      {required this.id,
      @JsonKey(name: 'short_form') required this.shortForm,
      @JsonKey(name: 'full_form') required this.fullForm});
  factory _ProductType.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'short_form')
  final String shortForm;
  @override
  @JsonKey(name: 'full_form')
  final String fullForm;

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductTypeCopyWith<_ProductType> get copyWith =>
      __$ProductTypeCopyWithImpl<_ProductType>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductTypeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductType &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shortForm, shortForm) ||
                other.shortForm == shortForm) &&
            (identical(other.fullForm, fullForm) ||
                other.fullForm == fullForm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, shortForm, fullForm);

  @override
  String toString() {
    return 'ProductType(id: $id, shortForm: $shortForm, fullForm: $fullForm)';
  }
}

/// @nodoc
abstract mixin class _$ProductTypeCopyWith<$Res>
    implements $ProductTypeCopyWith<$Res> {
  factory _$ProductTypeCopyWith(
          _ProductType value, $Res Function(_ProductType) _then) =
      __$ProductTypeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'short_form') String shortForm,
      @JsonKey(name: 'full_form') String fullForm});
}

/// @nodoc
class __$ProductTypeCopyWithImpl<$Res> implements _$ProductTypeCopyWith<$Res> {
  __$ProductTypeCopyWithImpl(this._self, this._then);

  final _ProductType _self;
  final $Res Function(_ProductType) _then;

  /// Create a copy of ProductType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? shortForm = null,
    Object? fullForm = null,
  }) {
    return _then(_ProductType(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shortForm: null == shortForm
          ? _self.shortForm
          : shortForm // ignore: cast_nullable_to_non_nullable
              as String,
      fullForm: null == fullForm
          ? _self.fullForm
          : fullForm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
