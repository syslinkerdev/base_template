// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderX {
// 🧾 Order Info
  @JsonKey(name: 'order_id')
  String get orderId;
  @JsonKey(name: 'user_uid')
  String get userUid;
  @JsonKey(name: 'superuser_uid')
  String get superuserUid;
  @JsonKey(name: 'logs')
  List<String>? get logs; // 💰 Pricing
  @JsonKey(name: 'total_price')
  double get totalPrice;
  @JsonKey(name: 'original_total_price')
  double get originalTotalPrice;
  @JsonKey(name: 'service_charges')
  double get serviceCharges; // 🧺 Products
  @JsonKey(name: 'ordered_products')
  List<CartItem> get orderedProducts; // 🕒 Metadata
  @JsonKey(name: 'created_by')
  String get createdBy;
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  DateTime get createdAt;
  @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get updatedAt; // 📅 Delivery date
  @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
  DateTime get deliveryDate; // 🔁 Status: placed | adjusted | deleted
  @JsonKey(
      fromJson: OrderStatusConverter.fromJson,
      toJson: OrderStatusConverter.toJson)
  OrderStatus get status;

  /// Create a copy of OrderX
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderXCopyWith<OrderX> get copyWith =>
      _$OrderXCopyWithImpl<OrderX>(this as OrderX, _$identity);

  /// Serializes this OrderX to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderX &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.userUid, userUid) || other.userUid == userUid) &&
            (identical(other.superuserUid, superuserUid) ||
                other.superuserUid == superuserUid) &&
            const DeepCollectionEquality().equals(other.logs, logs) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.originalTotalPrice, originalTotalPrice) ||
                other.originalTotalPrice == originalTotalPrice) &&
            (identical(other.serviceCharges, serviceCharges) ||
                other.serviceCharges == serviceCharges) &&
            const DeepCollectionEquality()
                .equals(other.orderedProducts, orderedProducts) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deliveryDate, deliveryDate) ||
                other.deliveryDate == deliveryDate) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orderId,
      userUid,
      superuserUid,
      const DeepCollectionEquality().hash(logs),
      totalPrice,
      originalTotalPrice,
      serviceCharges,
      const DeepCollectionEquality().hash(orderedProducts),
      createdBy,
      createdAt,
      updatedAt,
      deliveryDate,
      status);

  @override
  String toString() {
    return 'OrderX(orderId: $orderId, userUid: $userUid, superuserUid: $superuserUid, logs: $logs, totalPrice: $totalPrice, originalTotalPrice: $originalTotalPrice, serviceCharges: $serviceCharges, orderedProducts: $orderedProducts, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, deliveryDate: $deliveryDate, status: $status)';
  }
}

/// @nodoc
abstract mixin class $OrderXCopyWith<$Res> {
  factory $OrderXCopyWith(OrderX value, $Res Function(OrderX) _then) =
      _$OrderXCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'order_id') String orderId,
      @JsonKey(name: 'user_uid') String userUid,
      @JsonKey(name: 'superuser_uid') String superuserUid,
      @JsonKey(name: 'logs') List<String>? logs,
      @JsonKey(name: 'total_price') double totalPrice,
      @JsonKey(name: 'original_total_price') double originalTotalPrice,
      @JsonKey(name: 'service_charges') double serviceCharges,
      @JsonKey(name: 'ordered_products') List<CartItem> orderedProducts,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? updatedAt,
      @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
      DateTime deliveryDate,
      @JsonKey(
          fromJson: OrderStatusConverter.fromJson,
          toJson: OrderStatusConverter.toJson)
      OrderStatus status});
}

/// @nodoc
class _$OrderXCopyWithImpl<$Res> implements $OrderXCopyWith<$Res> {
  _$OrderXCopyWithImpl(this._self, this._then);

  final OrderX _self;
  final $Res Function(OrderX) _then;

  /// Create a copy of OrderX
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? userUid = null,
    Object? superuserUid = null,
    Object? logs = freezed,
    Object? totalPrice = null,
    Object? originalTotalPrice = null,
    Object? serviceCharges = null,
    Object? orderedProducts = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deliveryDate = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      orderId: null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: null == userUid
          ? _self.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      superuserUid: null == superuserUid
          ? _self.superuserUid
          : superuserUid // ignore: cast_nullable_to_non_nullable
              as String,
      logs: freezed == logs
          ? _self.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      originalTotalPrice: null == originalTotalPrice
          ? _self.originalTotalPrice
          : originalTotalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      serviceCharges: null == serviceCharges
          ? _self.serviceCharges
          : serviceCharges // ignore: cast_nullable_to_non_nullable
              as double,
      orderedProducts: null == orderedProducts
          ? _self.orderedProducts
          : orderedProducts // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      createdBy: null == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveryDate: null == deliveryDate
          ? _self.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
    ));
  }
}

/// Adds pattern-matching-related methods to [OrderX].
extension OrderXPatterns on OrderX {
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
    TResult Function(_OrderX value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrderX() when $default != null:
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
    TResult Function(_OrderX value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderX():
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
    TResult? Function(_OrderX value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderX() when $default != null:
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
            @JsonKey(name: 'order_id') String orderId,
            @JsonKey(name: 'user_uid') String userUid,
            @JsonKey(name: 'superuser_uid') String superuserUid,
            @JsonKey(name: 'logs') List<String>? logs,
            @JsonKey(name: 'total_price') double totalPrice,
            @JsonKey(name: 'original_total_price') double originalTotalPrice,
            @JsonKey(name: 'service_charges') double serviceCharges,
            @JsonKey(name: 'ordered_products') List<CartItem> orderedProducts,
            @JsonKey(name: 'created_by') String createdBy,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt,
            @JsonKey(
                name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
            DateTime deliveryDate,
            @JsonKey(
                fromJson: OrderStatusConverter.fromJson,
                toJson: OrderStatusConverter.toJson)
            OrderStatus status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrderX() when $default != null:
        return $default(
            _that.orderId,
            _that.userUid,
            _that.superuserUid,
            _that.logs,
            _that.totalPrice,
            _that.originalTotalPrice,
            _that.serviceCharges,
            _that.orderedProducts,
            _that.createdBy,
            _that.createdAt,
            _that.updatedAt,
            _that.deliveryDate,
            _that.status);
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
            @JsonKey(name: 'order_id') String orderId,
            @JsonKey(name: 'user_uid') String userUid,
            @JsonKey(name: 'superuser_uid') String superuserUid,
            @JsonKey(name: 'logs') List<String>? logs,
            @JsonKey(name: 'total_price') double totalPrice,
            @JsonKey(name: 'original_total_price') double originalTotalPrice,
            @JsonKey(name: 'service_charges') double serviceCharges,
            @JsonKey(name: 'ordered_products') List<CartItem> orderedProducts,
            @JsonKey(name: 'created_by') String createdBy,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt,
            @JsonKey(
                name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
            DateTime deliveryDate,
            @JsonKey(
                fromJson: OrderStatusConverter.fromJson,
                toJson: OrderStatusConverter.toJson)
            OrderStatus status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderX():
        return $default(
            _that.orderId,
            _that.userUid,
            _that.superuserUid,
            _that.logs,
            _that.totalPrice,
            _that.originalTotalPrice,
            _that.serviceCharges,
            _that.orderedProducts,
            _that.createdBy,
            _that.createdAt,
            _that.updatedAt,
            _that.deliveryDate,
            _that.status);
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
            @JsonKey(name: 'order_id') String orderId,
            @JsonKey(name: 'user_uid') String userUid,
            @JsonKey(name: 'superuser_uid') String superuserUid,
            @JsonKey(name: 'logs') List<String>? logs,
            @JsonKey(name: 'total_price') double totalPrice,
            @JsonKey(name: 'original_total_price') double originalTotalPrice,
            @JsonKey(name: 'service_charges') double serviceCharges,
            @JsonKey(name: 'ordered_products') List<CartItem> orderedProducts,
            @JsonKey(name: 'created_by') String createdBy,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt,
            @JsonKey(
                name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
            DateTime deliveryDate,
            @JsonKey(
                fromJson: OrderStatusConverter.fromJson,
                toJson: OrderStatusConverter.toJson)
            OrderStatus status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderX() when $default != null:
        return $default(
            _that.orderId,
            _that.userUid,
            _that.superuserUid,
            _that.logs,
            _that.totalPrice,
            _that.originalTotalPrice,
            _that.serviceCharges,
            _that.orderedProducts,
            _that.createdBy,
            _that.createdAt,
            _that.updatedAt,
            _that.deliveryDate,
            _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OrderX extends OrderX {
  _OrderX(
      {@JsonKey(name: 'order_id') required this.orderId,
      @JsonKey(name: 'user_uid') required this.userUid,
      @JsonKey(name: 'superuser_uid') required this.superuserUid,
      @JsonKey(name: 'logs') final List<String>? logs,
      @JsonKey(name: 'total_price') required this.totalPrice,
      @JsonKey(name: 'original_total_price') required this.originalTotalPrice,
      @JsonKey(name: 'service_charges') required this.serviceCharges,
      @JsonKey(name: 'ordered_products')
      required final List<CartItem> orderedProducts,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      required this.createdAt,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      this.updatedAt,
      @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
      required this.deliveryDate,
      @JsonKey(
          fromJson: OrderStatusConverter.fromJson,
          toJson: OrderStatusConverter.toJson)
      this.status = OrderStatus.placed})
      : _logs = logs,
        _orderedProducts = orderedProducts,
        super._();
  factory _OrderX.fromJson(Map<String, dynamic> json) => _$OrderXFromJson(json);

// 🧾 Order Info
  @override
  @JsonKey(name: 'order_id')
  final String orderId;
  @override
  @JsonKey(name: 'user_uid')
  final String userUid;
  @override
  @JsonKey(name: 'superuser_uid')
  final String superuserUid;
  final List<String>? _logs;
  @override
  @JsonKey(name: 'logs')
  List<String>? get logs {
    final value = _logs;
    if (value == null) return null;
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// 💰 Pricing
  @override
  @JsonKey(name: 'total_price')
  final double totalPrice;
  @override
  @JsonKey(name: 'original_total_price')
  final double originalTotalPrice;
  @override
  @JsonKey(name: 'service_charges')
  final double serviceCharges;
// 🧺 Products
  final List<CartItem> _orderedProducts;
// 🧺 Products
  @override
  @JsonKey(name: 'ordered_products')
  List<CartItem> get orderedProducts {
    if (_orderedProducts is EqualUnmodifiableListView) return _orderedProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderedProducts);
  }

// 🕒 Metadata
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? updatedAt;
// 📅 Delivery date
  @override
  @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
  final DateTime deliveryDate;
// 🔁 Status: placed | adjusted | deleted
  @override
  @JsonKey(
      fromJson: OrderStatusConverter.fromJson,
      toJson: OrderStatusConverter.toJson)
  final OrderStatus status;

  /// Create a copy of OrderX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderXCopyWith<_OrderX> get copyWith =>
      __$OrderXCopyWithImpl<_OrderX>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrderXToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderX &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.userUid, userUid) || other.userUid == userUid) &&
            (identical(other.superuserUid, superuserUid) ||
                other.superuserUid == superuserUid) &&
            const DeepCollectionEquality().equals(other._logs, _logs) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.originalTotalPrice, originalTotalPrice) ||
                other.originalTotalPrice == originalTotalPrice) &&
            (identical(other.serviceCharges, serviceCharges) ||
                other.serviceCharges == serviceCharges) &&
            const DeepCollectionEquality()
                .equals(other._orderedProducts, _orderedProducts) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deliveryDate, deliveryDate) ||
                other.deliveryDate == deliveryDate) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orderId,
      userUid,
      superuserUid,
      const DeepCollectionEquality().hash(_logs),
      totalPrice,
      originalTotalPrice,
      serviceCharges,
      const DeepCollectionEquality().hash(_orderedProducts),
      createdBy,
      createdAt,
      updatedAt,
      deliveryDate,
      status);

  @override
  String toString() {
    return 'OrderX(orderId: $orderId, userUid: $userUid, superuserUid: $superuserUid, logs: $logs, totalPrice: $totalPrice, originalTotalPrice: $originalTotalPrice, serviceCharges: $serviceCharges, orderedProducts: $orderedProducts, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, deliveryDate: $deliveryDate, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$OrderXCopyWith<$Res> implements $OrderXCopyWith<$Res> {
  factory _$OrderXCopyWith(_OrderX value, $Res Function(_OrderX) _then) =
      __$OrderXCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'order_id') String orderId,
      @JsonKey(name: 'user_uid') String userUid,
      @JsonKey(name: 'superuser_uid') String superuserUid,
      @JsonKey(name: 'logs') List<String>? logs,
      @JsonKey(name: 'total_price') double totalPrice,
      @JsonKey(name: 'original_total_price') double originalTotalPrice,
      @JsonKey(name: 'service_charges') double serviceCharges,
      @JsonKey(name: 'ordered_products') List<CartItem> orderedProducts,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? updatedAt,
      @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
      DateTime deliveryDate,
      @JsonKey(
          fromJson: OrderStatusConverter.fromJson,
          toJson: OrderStatusConverter.toJson)
      OrderStatus status});
}

/// @nodoc
class __$OrderXCopyWithImpl<$Res> implements _$OrderXCopyWith<$Res> {
  __$OrderXCopyWithImpl(this._self, this._then);

  final _OrderX _self;
  final $Res Function(_OrderX) _then;

  /// Create a copy of OrderX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? orderId = null,
    Object? userUid = null,
    Object? superuserUid = null,
    Object? logs = freezed,
    Object? totalPrice = null,
    Object? originalTotalPrice = null,
    Object? serviceCharges = null,
    Object? orderedProducts = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deliveryDate = null,
    Object? status = null,
  }) {
    return _then(_OrderX(
      orderId: null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: null == userUid
          ? _self.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      superuserUid: null == superuserUid
          ? _self.superuserUid
          : superuserUid // ignore: cast_nullable_to_non_nullable
              as String,
      logs: freezed == logs
          ? _self._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      originalTotalPrice: null == originalTotalPrice
          ? _self.originalTotalPrice
          : originalTotalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      serviceCharges: null == serviceCharges
          ? _self.serviceCharges
          : serviceCharges // ignore: cast_nullable_to_non_nullable
              as double,
      orderedProducts: null == orderedProducts
          ? _self._orderedProducts
          : orderedProducts // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      createdBy: null == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveryDate: null == deliveryDate
          ? _self.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
    ));
  }
}

// dart format on
