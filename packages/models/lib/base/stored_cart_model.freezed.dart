// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stored_cart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoredCart {
  List<CartItem> get items;
  CartMode get mode;
  String? get editId;
  String? get basketName;
  String? get clientUid;

  /// Create a copy of StoredCart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StoredCartCopyWith<StoredCart> get copyWith =>
      _$StoredCartCopyWithImpl<StoredCart>(this as StoredCart, _$identity);

  /// Serializes this StoredCart to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StoredCart &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.editId, editId) || other.editId == editId) &&
            (identical(other.basketName, basketName) ||
                other.basketName == basketName) &&
            (identical(other.clientUid, clientUid) ||
                other.clientUid == clientUid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(items),
      mode,
      editId,
      basketName,
      clientUid);

  @override
  String toString() {
    return 'StoredCart(items: $items, mode: $mode, editId: $editId, basketName: $basketName, clientUid: $clientUid)';
  }
}

/// @nodoc
abstract mixin class $StoredCartCopyWith<$Res> {
  factory $StoredCartCopyWith(
          StoredCart value, $Res Function(StoredCart) _then) =
      _$StoredCartCopyWithImpl;
  @useResult
  $Res call(
      {List<CartItem> items,
      CartMode mode,
      String? editId,
      String? basketName,
      String? clientUid});
}

/// @nodoc
class _$StoredCartCopyWithImpl<$Res> implements $StoredCartCopyWith<$Res> {
  _$StoredCartCopyWithImpl(this._self, this._then);

  final StoredCart _self;
  final $Res Function(StoredCart) _then;

  /// Create a copy of StoredCart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? mode = null,
    Object? editId = freezed,
    Object? basketName = freezed,
    Object? clientUid = freezed,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as CartMode,
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
    ));
  }
}

/// Adds pattern-matching-related methods to [StoredCart].
extension StoredCartPatterns on StoredCart {
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
    TResult Function(_StoredCart value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoredCart() when $default != null:
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
    TResult Function(_StoredCart value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoredCart():
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
    TResult? Function(_StoredCart value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoredCart() when $default != null:
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
    TResult Function(List<CartItem> items, CartMode mode, String? editId,
            String? basketName, String? clientUid)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StoredCart() when $default != null:
        return $default(_that.items, _that.mode, _that.editId, _that.basketName,
            _that.clientUid);
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
    TResult Function(List<CartItem> items, CartMode mode, String? editId,
            String? basketName, String? clientUid)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoredCart():
        return $default(_that.items, _that.mode, _that.editId, _that.basketName,
            _that.clientUid);
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
    TResult? Function(List<CartItem> items, CartMode mode, String? editId,
            String? basketName, String? clientUid)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StoredCart() when $default != null:
        return $default(_that.items, _that.mode, _that.editId, _that.basketName,
            _that.clientUid);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StoredCart implements StoredCart {
  const _StoredCart(
      {required final List<CartItem> items,
      required this.mode,
      this.editId,
      this.basketName,
      this.clientUid})
      : _items = items;
  factory _StoredCart.fromJson(Map<String, dynamic> json) =>
      _$StoredCartFromJson(json);

  final List<CartItem> _items;
  @override
  List<CartItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final CartMode mode;
  @override
  final String? editId;
  @override
  final String? basketName;
  @override
  final String? clientUid;

  /// Create a copy of StoredCart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StoredCartCopyWith<_StoredCart> get copyWith =>
      __$StoredCartCopyWithImpl<_StoredCart>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StoredCartToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StoredCart &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.editId, editId) || other.editId == editId) &&
            (identical(other.basketName, basketName) ||
                other.basketName == basketName) &&
            (identical(other.clientUid, clientUid) ||
                other.clientUid == clientUid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      mode,
      editId,
      basketName,
      clientUid);

  @override
  String toString() {
    return 'StoredCart(items: $items, mode: $mode, editId: $editId, basketName: $basketName, clientUid: $clientUid)';
  }
}

/// @nodoc
abstract mixin class _$StoredCartCopyWith<$Res>
    implements $StoredCartCopyWith<$Res> {
  factory _$StoredCartCopyWith(
          _StoredCart value, $Res Function(_StoredCart) _then) =
      __$StoredCartCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<CartItem> items,
      CartMode mode,
      String? editId,
      String? basketName,
      String? clientUid});
}

/// @nodoc
class __$StoredCartCopyWithImpl<$Res> implements _$StoredCartCopyWith<$Res> {
  __$StoredCartCopyWithImpl(this._self, this._then);

  final _StoredCart _self;
  final $Res Function(_StoredCart) _then;

  /// Create a copy of StoredCart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? mode = null,
    Object? editId = freezed,
    Object? basketName = freezed,
    Object? clientUid = freezed,
  }) {
    return _then(_StoredCart(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as CartMode,
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
    ));
  }
}

// dart format on
