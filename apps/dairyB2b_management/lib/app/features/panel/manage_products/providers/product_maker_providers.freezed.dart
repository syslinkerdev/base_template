// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_maker_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductMakerState {
  bool get isEdited;
  ProductMakerMode get mode;
  ProductMaker? get maker;

  /// Create a copy of ProductMakerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductMakerStateCopyWith<ProductMakerState> get copyWith =>
      _$ProductMakerStateCopyWithImpl<ProductMakerState>(
          this as ProductMakerState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductMakerState &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.maker, maker) || other.maker == maker));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEdited, mode, maker);

  @override
  String toString() {
    return 'ProductMakerState(isEdited: $isEdited, mode: $mode, maker: $maker)';
  }
}

/// @nodoc
abstract mixin class $ProductMakerStateCopyWith<$Res> {
  factory $ProductMakerStateCopyWith(
          ProductMakerState value, $Res Function(ProductMakerState) _then) =
      _$ProductMakerStateCopyWithImpl;
  @useResult
  $Res call({bool isEdited, ProductMakerMode mode, ProductMaker? maker});

  $ProductMakerCopyWith<$Res>? get maker;
}

/// @nodoc
class _$ProductMakerStateCopyWithImpl<$Res>
    implements $ProductMakerStateCopyWith<$Res> {
  _$ProductMakerStateCopyWithImpl(this._self, this._then);

  final ProductMakerState _self;
  final $Res Function(ProductMakerState) _then;

  /// Create a copy of ProductMakerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEdited = null,
    Object? mode = null,
    Object? maker = freezed,
  }) {
    return _then(_self.copyWith(
      isEdited: null == isEdited
          ? _self.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ProductMakerMode,
      maker: freezed == maker
          ? _self.maker
          : maker // ignore: cast_nullable_to_non_nullable
              as ProductMaker?,
    ));
  }

  /// Create a copy of ProductMakerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductMakerCopyWith<$Res>? get maker {
    if (_self.maker == null) {
      return null;
    }

    return $ProductMakerCopyWith<$Res>(_self.maker!, (value) {
      return _then(_self.copyWith(maker: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ProductMakerState].
extension ProductMakerStatePatterns on ProductMakerState {
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
    TResult Function(_ProductMakerState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductMakerState() when $default != null:
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
    TResult Function(_ProductMakerState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMakerState():
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
    TResult? Function(_ProductMakerState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMakerState() when $default != null:
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
    TResult Function(bool isEdited, ProductMakerMode mode, ProductMaker? maker)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductMakerState() when $default != null:
        return $default(_that.isEdited, _that.mode, _that.maker);
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
    TResult Function(bool isEdited, ProductMakerMode mode, ProductMaker? maker)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMakerState():
        return $default(_that.isEdited, _that.mode, _that.maker);
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
            bool isEdited, ProductMakerMode mode, ProductMaker? maker)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMakerState() when $default != null:
        return $default(_that.isEdited, _that.mode, _that.maker);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ProductMakerState implements ProductMakerState {
  const _ProductMakerState(
      {required this.isEdited, required this.mode, this.maker});

  @override
  final bool isEdited;
  @override
  final ProductMakerMode mode;
  @override
  final ProductMaker? maker;

  /// Create a copy of ProductMakerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductMakerStateCopyWith<_ProductMakerState> get copyWith =>
      __$ProductMakerStateCopyWithImpl<_ProductMakerState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductMakerState &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.maker, maker) || other.maker == maker));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEdited, mode, maker);

  @override
  String toString() {
    return 'ProductMakerState(isEdited: $isEdited, mode: $mode, maker: $maker)';
  }
}

/// @nodoc
abstract mixin class _$ProductMakerStateCopyWith<$Res>
    implements $ProductMakerStateCopyWith<$Res> {
  factory _$ProductMakerStateCopyWith(
          _ProductMakerState value, $Res Function(_ProductMakerState) _then) =
      __$ProductMakerStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isEdited, ProductMakerMode mode, ProductMaker? maker});

  @override
  $ProductMakerCopyWith<$Res>? get maker;
}

/// @nodoc
class __$ProductMakerStateCopyWithImpl<$Res>
    implements _$ProductMakerStateCopyWith<$Res> {
  __$ProductMakerStateCopyWithImpl(this._self, this._then);

  final _ProductMakerState _self;
  final $Res Function(_ProductMakerState) _then;

  /// Create a copy of ProductMakerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isEdited = null,
    Object? mode = null,
    Object? maker = freezed,
  }) {
    return _then(_ProductMakerState(
      isEdited: null == isEdited
          ? _self.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ProductMakerMode,
      maker: freezed == maker
          ? _self.maker
          : maker // ignore: cast_nullable_to_non_nullable
              as ProductMaker?,
    ));
  }

  /// Create a copy of ProductMakerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductMakerCopyWith<$Res>? get maker {
    if (_self.maker == null) {
      return null;
    }

    return $ProductMakerCopyWith<$Res>(_self.maker!, (value) {
      return _then(_self.copyWith(maker: value));
    });
  }
}

// dart format on
