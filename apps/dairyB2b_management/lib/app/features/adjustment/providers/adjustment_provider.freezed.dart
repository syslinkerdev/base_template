// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adjustment_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdjustmentState {
  List<Product>? get finalCart;
  OrderX? get order;
  UserX? get user;
  AdjustmentMode? get mode;

  /// Create a copy of AdjustmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AdjustmentStateCopyWith<AdjustmentState> get copyWith =>
      _$AdjustmentStateCopyWithImpl<AdjustmentState>(
          this as AdjustmentState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AdjustmentState &&
            const DeepCollectionEquality().equals(other.finalCart, finalCart) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(finalCart), order, user, mode);

  @override
  String toString() {
    return 'AdjustmentState(finalCart: $finalCart, order: $order, user: $user, mode: $mode)';
  }
}

/// @nodoc
abstract mixin class $AdjustmentStateCopyWith<$Res> {
  factory $AdjustmentStateCopyWith(
          AdjustmentState value, $Res Function(AdjustmentState) _then) =
      _$AdjustmentStateCopyWithImpl;
  @useResult
  $Res call(
      {List<Product>? finalCart,
      OrderX? order,
      UserX? user,
      AdjustmentMode? mode});

  $OrderXCopyWith<$Res>? get order;
  $UserXCopyWith<$Res>? get user;
}

/// @nodoc
class _$AdjustmentStateCopyWithImpl<$Res>
    implements $AdjustmentStateCopyWith<$Res> {
  _$AdjustmentStateCopyWithImpl(this._self, this._then);

  final AdjustmentState _self;
  final $Res Function(AdjustmentState) _then;

  /// Create a copy of AdjustmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? finalCart = freezed,
    Object? order = freezed,
    Object? user = freezed,
    Object? mode = freezed,
  }) {
    return _then(_self.copyWith(
      finalCart: freezed == finalCart
          ? _self.finalCart
          : finalCart // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
      order: freezed == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderX?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserX?,
      mode: freezed == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AdjustmentMode?,
    ));
  }

  /// Create a copy of AdjustmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderXCopyWith<$Res>? get order {
    if (_self.order == null) {
      return null;
    }

    return $OrderXCopyWith<$Res>(_self.order!, (value) {
      return _then(_self.copyWith(order: value));
    });
  }

  /// Create a copy of AdjustmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserXCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $UserXCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AdjustmentState].
extension AdjustmentStatePatterns on AdjustmentState {
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
    TResult Function(_AdjustmentState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AdjustmentState() when $default != null:
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
    TResult Function(_AdjustmentState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AdjustmentState():
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
    TResult? Function(_AdjustmentState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AdjustmentState() when $default != null:
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
    TResult Function(List<Product>? finalCart, OrderX? order, UserX? user,
            AdjustmentMode? mode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AdjustmentState() when $default != null:
        return $default(_that.finalCart, _that.order, _that.user, _that.mode);
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
    TResult Function(List<Product>? finalCart, OrderX? order, UserX? user,
            AdjustmentMode? mode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AdjustmentState():
        return $default(_that.finalCart, _that.order, _that.user, _that.mode);
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
    TResult? Function(List<Product>? finalCart, OrderX? order, UserX? user,
            AdjustmentMode? mode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AdjustmentState() when $default != null:
        return $default(_that.finalCart, _that.order, _that.user, _that.mode);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AdjustmentState implements AdjustmentState {
  const _AdjustmentState(
      {final List<Product>? finalCart, this.order, this.user, this.mode})
      : _finalCart = finalCart;

  final List<Product>? _finalCart;
  @override
  List<Product>? get finalCart {
    final value = _finalCart;
    if (value == null) return null;
    if (_finalCart is EqualUnmodifiableListView) return _finalCart;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final OrderX? order;
  @override
  final UserX? user;
  @override
  final AdjustmentMode? mode;

  /// Create a copy of AdjustmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AdjustmentStateCopyWith<_AdjustmentState> get copyWith =>
      __$AdjustmentStateCopyWithImpl<_AdjustmentState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AdjustmentState &&
            const DeepCollectionEquality()
                .equals(other._finalCart, _finalCart) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_finalCart), order, user, mode);

  @override
  String toString() {
    return 'AdjustmentState(finalCart: $finalCart, order: $order, user: $user, mode: $mode)';
  }
}

/// @nodoc
abstract mixin class _$AdjustmentStateCopyWith<$Res>
    implements $AdjustmentStateCopyWith<$Res> {
  factory _$AdjustmentStateCopyWith(
          _AdjustmentState value, $Res Function(_AdjustmentState) _then) =
      __$AdjustmentStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Product>? finalCart,
      OrderX? order,
      UserX? user,
      AdjustmentMode? mode});

  @override
  $OrderXCopyWith<$Res>? get order;
  @override
  $UserXCopyWith<$Res>? get user;
}

/// @nodoc
class __$AdjustmentStateCopyWithImpl<$Res>
    implements _$AdjustmentStateCopyWith<$Res> {
  __$AdjustmentStateCopyWithImpl(this._self, this._then);

  final _AdjustmentState _self;
  final $Res Function(_AdjustmentState) _then;

  /// Create a copy of AdjustmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? finalCart = freezed,
    Object? order = freezed,
    Object? user = freezed,
    Object? mode = freezed,
  }) {
    return _then(_AdjustmentState(
      finalCart: freezed == finalCart
          ? _self._finalCart
          : finalCart // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
      order: freezed == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderX?,
      user: freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserX?,
      mode: freezed == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AdjustmentMode?,
    ));
  }

  /// Create a copy of AdjustmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderXCopyWith<$Res>? get order {
    if (_self.order == null) {
      return null;
    }

    return $OrderXCopyWith<$Res>(_self.order!, (value) {
      return _then(_self.copyWith(order: value));
    });
  }

  /// Create a copy of AdjustmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserXCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $UserXCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
