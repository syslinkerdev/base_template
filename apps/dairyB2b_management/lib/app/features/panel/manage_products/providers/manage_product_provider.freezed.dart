// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_product_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ManageProductState {
  Product? get product;
  Discount? get discount;
  ManageProductMode get mode;

  /// Create a copy of ManageProductState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ManageProductStateCopyWith<ManageProductState> get copyWith =>
      _$ManageProductStateCopyWithImpl<ManageProductState>(
          this as ManageProductState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ManageProductState &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product, discount, mode);

  @override
  String toString() {
    return 'ManageProductState(product: $product, discount: $discount, mode: $mode)';
  }
}

/// @nodoc
abstract mixin class $ManageProductStateCopyWith<$Res> {
  factory $ManageProductStateCopyWith(
          ManageProductState value, $Res Function(ManageProductState) _then) =
      _$ManageProductStateCopyWithImpl;
  @useResult
  $Res call({Product? product, Discount? discount, ManageProductMode mode});

  $ProductCopyWith<$Res>? get product;
  $DiscountCopyWith<$Res>? get discount;
}

/// @nodoc
class _$ManageProductStateCopyWithImpl<$Res>
    implements $ManageProductStateCopyWith<$Res> {
  _$ManageProductStateCopyWithImpl(this._self, this._then);

  final ManageProductState _self;
  final $Res Function(ManageProductState) _then;

  /// Create a copy of ManageProductState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = freezed,
    Object? discount = freezed,
    Object? mode = null,
  }) {
    return _then(_self.copyWith(
      product: freezed == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      discount: freezed == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as Discount?,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ManageProductMode,
    ));
  }

  /// Create a copy of ManageProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_self.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_self.product!, (value) {
      return _then(_self.copyWith(product: value));
    });
  }

  /// Create a copy of ManageProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscountCopyWith<$Res>? get discount {
    if (_self.discount == null) {
      return null;
    }

    return $DiscountCopyWith<$Res>(_self.discount!, (value) {
      return _then(_self.copyWith(discount: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ManageProductState].
extension ManageProductStatePatterns on ManageProductState {
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
    TResult Function(_ManageProductState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManageProductState() when $default != null:
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
    TResult Function(_ManageProductState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManageProductState():
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
    TResult? Function(_ManageProductState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManageProductState() when $default != null:
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
            Product? product, Discount? discount, ManageProductMode mode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ManageProductState() when $default != null:
        return $default(_that.product, _that.discount, _that.mode);
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
            Product? product, Discount? discount, ManageProductMode mode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManageProductState():
        return $default(_that.product, _that.discount, _that.mode);
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
            Product? product, Discount? discount, ManageProductMode mode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ManageProductState() when $default != null:
        return $default(_that.product, _that.discount, _that.mode);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ManageProductState implements ManageProductState {
  const _ManageProductState({this.product, this.discount, required this.mode});

  @override
  final Product? product;
  @override
  final Discount? discount;
  @override
  final ManageProductMode mode;

  /// Create a copy of ManageProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ManageProductStateCopyWith<_ManageProductState> get copyWith =>
      __$ManageProductStateCopyWithImpl<_ManageProductState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ManageProductState &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product, discount, mode);

  @override
  String toString() {
    return 'ManageProductState(product: $product, discount: $discount, mode: $mode)';
  }
}

/// @nodoc
abstract mixin class _$ManageProductStateCopyWith<$Res>
    implements $ManageProductStateCopyWith<$Res> {
  factory _$ManageProductStateCopyWith(
          _ManageProductState value, $Res Function(_ManageProductState) _then) =
      __$ManageProductStateCopyWithImpl;
  @override
  @useResult
  $Res call({Product? product, Discount? discount, ManageProductMode mode});

  @override
  $ProductCopyWith<$Res>? get product;
  @override
  $DiscountCopyWith<$Res>? get discount;
}

/// @nodoc
class __$ManageProductStateCopyWithImpl<$Res>
    implements _$ManageProductStateCopyWith<$Res> {
  __$ManageProductStateCopyWithImpl(this._self, this._then);

  final _ManageProductState _self;
  final $Res Function(_ManageProductState) _then;

  /// Create a copy of ManageProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? product = freezed,
    Object? discount = freezed,
    Object? mode = null,
  }) {
    return _then(_ManageProductState(
      product: freezed == product
          ? _self.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      discount: freezed == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as Discount?,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ManageProductMode,
    ));
  }

  /// Create a copy of ManageProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_self.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_self.product!, (value) {
      return _then(_self.copyWith(product: value));
    });
  }

  /// Create a copy of ManageProductState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscountCopyWith<$Res>? get discount {
    if (_self.discount == null) {
      return null;
    }

    return $DiscountCopyWith<$Res>(_self.discount!, (value) {
      return _then(_self.copyWith(discount: value));
    });
  }
}

// dart format on
