// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_basket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SmartBasket {
  @JsonKey(name: 'basket_id')
  String get basketId;
  @JsonKey(name: 'basket_name')
  String get basketName;
  @JsonKey(name: 'items')
  List<CartItem> get items;
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get createdAt;
  @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get updatedAt;

  /// Create a copy of SmartBasket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SmartBasketCopyWith<SmartBasket> get copyWith =>
      _$SmartBasketCopyWithImpl<SmartBasket>(this as SmartBasket, _$identity);

  /// Serializes this SmartBasket to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SmartBasket &&
            (identical(other.basketId, basketId) ||
                other.basketId == basketId) &&
            (identical(other.basketName, basketName) ||
                other.basketName == basketName) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, basketId, basketName,
      const DeepCollectionEquality().hash(items), createdAt, updatedAt);

  @override
  String toString() {
    return 'SmartBasket(basketId: $basketId, basketName: $basketName, items: $items, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $SmartBasketCopyWith<$Res> {
  factory $SmartBasketCopyWith(
          SmartBasket value, $Res Function(SmartBasket) _then) =
      _$SmartBasketCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'basket_id') String basketId,
      @JsonKey(name: 'basket_name') String basketName,
      @JsonKey(name: 'items') List<CartItem> items,
      @JsonKey(
          name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? createdAt,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? updatedAt});
}

/// @nodoc
class _$SmartBasketCopyWithImpl<$Res> implements $SmartBasketCopyWith<$Res> {
  _$SmartBasketCopyWithImpl(this._self, this._then);

  final SmartBasket _self;
  final $Res Function(SmartBasket) _then;

  /// Create a copy of SmartBasket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basketId = null,
    Object? basketName = null,
    Object? items = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      basketId: null == basketId
          ? _self.basketId
          : basketId // ignore: cast_nullable_to_non_nullable
              as String,
      basketName: null == basketName
          ? _self.basketName
          : basketName // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SmartBasket].
extension SmartBasketPatterns on SmartBasket {
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
    TResult Function(_SmartBasket value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmartBasket() when $default != null:
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
    TResult Function(_SmartBasket value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartBasket():
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
    TResult? Function(_SmartBasket value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartBasket() when $default != null:
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
            @JsonKey(name: 'basket_id') String basketId,
            @JsonKey(name: 'basket_name') String basketName,
            @JsonKey(name: 'items') List<CartItem> items,
            @JsonKey(
                name: 'created_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? createdAt,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SmartBasket() when $default != null:
        return $default(_that.basketId, _that.basketName, _that.items,
            _that.createdAt, _that.updatedAt);
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
            @JsonKey(name: 'basket_id') String basketId,
            @JsonKey(name: 'basket_name') String basketName,
            @JsonKey(name: 'items') List<CartItem> items,
            @JsonKey(
                name: 'created_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? createdAt,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartBasket():
        return $default(_that.basketId, _that.basketName, _that.items,
            _that.createdAt, _that.updatedAt);
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
            @JsonKey(name: 'basket_id') String basketId,
            @JsonKey(name: 'basket_name') String basketName,
            @JsonKey(name: 'items') List<CartItem> items,
            @JsonKey(
                name: 'created_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? createdAt,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SmartBasket() when $default != null:
        return $default(_that.basketId, _that.basketName, _that.items,
            _that.createdAt, _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SmartBasket extends SmartBasket {
  const _SmartBasket(
      {@JsonKey(name: 'basket_id') required this.basketId,
      @JsonKey(name: 'basket_name') required this.basketName,
      @JsonKey(name: 'items') required final List<CartItem> items,
      @JsonKey(
          name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
      this.createdAt,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      this.updatedAt})
      : _items = items,
        super._();
  factory _SmartBasket.fromJson(Map<String, dynamic> json) =>
      _$SmartBasketFromJson(json);

  @override
  @JsonKey(name: 'basket_id')
  final String basketId;
  @override
  @JsonKey(name: 'basket_name')
  final String basketName;
  final List<CartItem> _items;
  @override
  @JsonKey(name: 'items')
  List<CartItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? updatedAt;

  /// Create a copy of SmartBasket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SmartBasketCopyWith<_SmartBasket> get copyWith =>
      __$SmartBasketCopyWithImpl<_SmartBasket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SmartBasketToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SmartBasket &&
            (identical(other.basketId, basketId) ||
                other.basketId == basketId) &&
            (identical(other.basketName, basketName) ||
                other.basketName == basketName) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, basketId, basketName,
      const DeepCollectionEquality().hash(_items), createdAt, updatedAt);

  @override
  String toString() {
    return 'SmartBasket(basketId: $basketId, basketName: $basketName, items: $items, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$SmartBasketCopyWith<$Res>
    implements $SmartBasketCopyWith<$Res> {
  factory _$SmartBasketCopyWith(
          _SmartBasket value, $Res Function(_SmartBasket) _then) =
      __$SmartBasketCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'basket_id') String basketId,
      @JsonKey(name: 'basket_name') String basketName,
      @JsonKey(name: 'items') List<CartItem> items,
      @JsonKey(
          name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? createdAt,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? updatedAt});
}

/// @nodoc
class __$SmartBasketCopyWithImpl<$Res> implements _$SmartBasketCopyWith<$Res> {
  __$SmartBasketCopyWithImpl(this._self, this._then);

  final _SmartBasket _self;
  final $Res Function(_SmartBasket) _then;

  /// Create a copy of SmartBasket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? basketId = null,
    Object? basketName = null,
    Object? items = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_SmartBasket(
      basketId: null == basketId
          ? _self.basketId
          : basketId // ignore: cast_nullable_to_non_nullable
              as String,
      basketName: null == basketName
          ? _self.basketName
          : basketName // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
