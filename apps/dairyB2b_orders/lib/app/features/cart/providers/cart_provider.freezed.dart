// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartState {
  List<CartItem>? get cart;
  List<Product>? get finalCart;
  Map<String, bool>? get itemLoadingState;
  CartMode? get mode;
  String? get message;
  String? get editId;
  String? get basketName;
  String? get clientUid;
  double? get serviceCharges;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CartStateCopyWith<CartState> get copyWith =>
      _$CartStateCopyWithImpl<CartState>(this as CartState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CartState &&
            const DeepCollectionEquality().equals(other.cart, cart) &&
            const DeepCollectionEquality().equals(other.finalCart, finalCart) &&
            const DeepCollectionEquality()
                .equals(other.itemLoadingState, itemLoadingState) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.editId, editId) || other.editId == editId) &&
            (identical(other.basketName, basketName) ||
                other.basketName == basketName) &&
            (identical(other.clientUid, clientUid) ||
                other.clientUid == clientUid) &&
            (identical(other.serviceCharges, serviceCharges) ||
                other.serviceCharges == serviceCharges));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(cart),
      const DeepCollectionEquality().hash(finalCart),
      const DeepCollectionEquality().hash(itemLoadingState),
      mode,
      message,
      editId,
      basketName,
      clientUid,
      serviceCharges);

  @override
  String toString() {
    return 'CartState(cart: $cart, finalCart: $finalCart, itemLoadingState: $itemLoadingState, mode: $mode, message: $message, editId: $editId, basketName: $basketName, clientUid: $clientUid, serviceCharges: $serviceCharges)';
  }
}

/// @nodoc
abstract mixin class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) _then) =
      _$CartStateCopyWithImpl;
  @useResult
  $Res call(
      {List<CartItem>? cart,
      List<Product>? finalCart,
      Map<String, bool>? itemLoadingState,
      CartMode? mode,
      String? message,
      String? editId,
      String? basketName,
      String? clientUid,
      double? serviceCharges});
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res> implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._self, this._then);

  final CartState _self;
  final $Res Function(CartState) _then;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cart = freezed,
    Object? finalCart = freezed,
    Object? itemLoadingState = freezed,
    Object? mode = freezed,
    Object? message = freezed,
    Object? editId = freezed,
    Object? basketName = freezed,
    Object? clientUid = freezed,
    Object? serviceCharges = freezed,
  }) {
    return _then(_self.copyWith(
      cart: freezed == cart
          ? _self.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as List<CartItem>?,
      finalCart: freezed == finalCart
          ? _self.finalCart
          : finalCart // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
      itemLoadingState: freezed == itemLoadingState
          ? _self.itemLoadingState
          : itemLoadingState // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>?,
      mode: freezed == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as CartMode?,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      editId: freezed == editId
          ? _self.editId
          : editId // ignore: cast_nullable_to_non_nullable
              as String?,
      basketName: freezed == basketName
          ? _self.basketName
          : basketName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientUid: freezed == clientUid
          ? _self.clientUid
          : clientUid // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceCharges: freezed == serviceCharges
          ? _self.serviceCharges
          : serviceCharges // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CartState].
extension CartStatePatterns on CartState {
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
    TResult Function(_CartState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CartState() when $default != null:
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
    TResult Function(_CartState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CartState():
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
    TResult? Function(_CartState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CartState() when $default != null:
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
            List<CartItem>? cart,
            List<Product>? finalCart,
            Map<String, bool>? itemLoadingState,
            CartMode? mode,
            String? message,
            String? editId,
            String? basketName,
            String? clientUid,
            double? serviceCharges)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CartState() when $default != null:
        return $default(
            _that.cart,
            _that.finalCart,
            _that.itemLoadingState,
            _that.mode,
            _that.message,
            _that.editId,
            _that.basketName,
            _that.clientUid,
            _that.serviceCharges);
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
            List<CartItem>? cart,
            List<Product>? finalCart,
            Map<String, bool>? itemLoadingState,
            CartMode? mode,
            String? message,
            String? editId,
            String? basketName,
            String? clientUid,
            double? serviceCharges)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CartState():
        return $default(
            _that.cart,
            _that.finalCart,
            _that.itemLoadingState,
            _that.mode,
            _that.message,
            _that.editId,
            _that.basketName,
            _that.clientUid,
            _that.serviceCharges);
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
            List<CartItem>? cart,
            List<Product>? finalCart,
            Map<String, bool>? itemLoadingState,
            CartMode? mode,
            String? message,
            String? editId,
            String? basketName,
            String? clientUid,
            double? serviceCharges)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CartState() when $default != null:
        return $default(
            _that.cart,
            _that.finalCart,
            _that.itemLoadingState,
            _that.mode,
            _that.message,
            _that.editId,
            _that.basketName,
            _that.clientUid,
            _that.serviceCharges);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CartState implements CartState {
  const _CartState(
      {final List<CartItem>? cart,
      final List<Product>? finalCart,
      final Map<String, bool>? itemLoadingState,
      this.mode,
      this.message,
      this.editId,
      this.basketName,
      this.clientUid,
      this.serviceCharges})
      : _cart = cart,
        _finalCart = finalCart,
        _itemLoadingState = itemLoadingState;

  final List<CartItem>? _cart;
  @override
  List<CartItem>? get cart {
    final value = _cart;
    if (value == null) return null;
    if (_cart is EqualUnmodifiableListView) return _cart;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Product>? _finalCart;
  @override
  List<Product>? get finalCart {
    final value = _finalCart;
    if (value == null) return null;
    if (_finalCart is EqualUnmodifiableListView) return _finalCart;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, bool>? _itemLoadingState;
  @override
  Map<String, bool>? get itemLoadingState {
    final value = _itemLoadingState;
    if (value == null) return null;
    if (_itemLoadingState is EqualUnmodifiableMapView) return _itemLoadingState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final CartMode? mode;
  @override
  final String? message;
  @override
  final String? editId;
  @override
  final String? basketName;
  @override
  final String? clientUid;
  @override
  final double? serviceCharges;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CartStateCopyWith<_CartState> get copyWith =>
      __$CartStateCopyWithImpl<_CartState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CartState &&
            const DeepCollectionEquality().equals(other._cart, _cart) &&
            const DeepCollectionEquality()
                .equals(other._finalCart, _finalCart) &&
            const DeepCollectionEquality()
                .equals(other._itemLoadingState, _itemLoadingState) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.editId, editId) || other.editId == editId) &&
            (identical(other.basketName, basketName) ||
                other.basketName == basketName) &&
            (identical(other.clientUid, clientUid) ||
                other.clientUid == clientUid) &&
            (identical(other.serviceCharges, serviceCharges) ||
                other.serviceCharges == serviceCharges));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_cart),
      const DeepCollectionEquality().hash(_finalCart),
      const DeepCollectionEquality().hash(_itemLoadingState),
      mode,
      message,
      editId,
      basketName,
      clientUid,
      serviceCharges);

  @override
  String toString() {
    return 'CartState(cart: $cart, finalCart: $finalCart, itemLoadingState: $itemLoadingState, mode: $mode, message: $message, editId: $editId, basketName: $basketName, clientUid: $clientUid, serviceCharges: $serviceCharges)';
  }
}

/// @nodoc
abstract mixin class _$CartStateCopyWith<$Res>
    implements $CartStateCopyWith<$Res> {
  factory _$CartStateCopyWith(
          _CartState value, $Res Function(_CartState) _then) =
      __$CartStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<CartItem>? cart,
      List<Product>? finalCart,
      Map<String, bool>? itemLoadingState,
      CartMode? mode,
      String? message,
      String? editId,
      String? basketName,
      String? clientUid,
      double? serviceCharges});
}

/// @nodoc
class __$CartStateCopyWithImpl<$Res> implements _$CartStateCopyWith<$Res> {
  __$CartStateCopyWithImpl(this._self, this._then);

  final _CartState _self;
  final $Res Function(_CartState) _then;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? cart = freezed,
    Object? finalCart = freezed,
    Object? itemLoadingState = freezed,
    Object? mode = freezed,
    Object? message = freezed,
    Object? editId = freezed,
    Object? basketName = freezed,
    Object? clientUid = freezed,
    Object? serviceCharges = freezed,
  }) {
    return _then(_CartState(
      cart: freezed == cart
          ? _self._cart
          : cart // ignore: cast_nullable_to_non_nullable
              as List<CartItem>?,
      finalCart: freezed == finalCart
          ? _self._finalCart
          : finalCart // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
      itemLoadingState: freezed == itemLoadingState
          ? _self._itemLoadingState
          : itemLoadingState // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>?,
      mode: freezed == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as CartMode?,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      editId: freezed == editId
          ? _self.editId
          : editId // ignore: cast_nullable_to_non_nullable
              as String?,
      basketName: freezed == basketName
          ? _self.basketName
          : basketName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientUid: freezed == clientUid
          ? _self.clientUid
          : clientUid // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceCharges: freezed == serviceCharges
          ? _self.serviceCharges
          : serviceCharges // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
