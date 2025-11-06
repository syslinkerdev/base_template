// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demand_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DemandLine {
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  DateTime get createdAt;
  @JsonKey(name: 'order_id')
  String get orderId;
  @JsonKey(name: 'company_id')
  String get companyId;
  @JsonKey(name: 'company_name')
  String get companyName;
  @JsonKey(name: 'client_id')
  String get clientId;
  @JsonKey(name: 'client_name')
  String get clientName;
  @JsonKey(name: 'shop_name')
  String get shopName;
  @JsonKey(name: 'shop_address')
  Address get shopAddress;
  @JsonKey(name: 'products')
  List<DemandLineItem> get products;
  @JsonKey(name: 'client_total')
  double get clientTotal;

  /// Create a copy of DemandLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DemandLineCopyWith<DemandLine> get copyWith =>
      _$DemandLineCopyWithImpl<DemandLine>(this as DemandLine, _$identity);

  /// Serializes this DemandLine to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DemandLine &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName) &&
            (identical(other.shopAddress, shopAddress) ||
                other.shopAddress == shopAddress) &&
            const DeepCollectionEquality().equals(other.products, products) &&
            (identical(other.clientTotal, clientTotal) ||
                other.clientTotal == clientTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      createdAt,
      orderId,
      companyId,
      companyName,
      clientId,
      clientName,
      shopName,
      shopAddress,
      const DeepCollectionEquality().hash(products),
      clientTotal);

  @override
  String toString() {
    return 'DemandLine(createdAt: $createdAt, orderId: $orderId, companyId: $companyId, companyName: $companyName, clientId: $clientId, clientName: $clientName, shopName: $shopName, shopAddress: $shopAddress, products: $products, clientTotal: $clientTotal)';
  }
}

/// @nodoc
abstract mixin class $DemandLineCopyWith<$Res> {
  factory $DemandLineCopyWith(
          DemandLine value, $Res Function(DemandLine) _then) =
      _$DemandLineCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(name: 'order_id') String orderId,
      @JsonKey(name: 'company_id') String companyId,
      @JsonKey(name: 'company_name') String companyName,
      @JsonKey(name: 'client_id') String clientId,
      @JsonKey(name: 'client_name') String clientName,
      @JsonKey(name: 'shop_name') String shopName,
      @JsonKey(name: 'shop_address') Address shopAddress,
      @JsonKey(name: 'products') List<DemandLineItem> products,
      @JsonKey(name: 'client_total') double clientTotal});

  $AddressCopyWith<$Res> get shopAddress;
}

/// @nodoc
class _$DemandLineCopyWithImpl<$Res> implements $DemandLineCopyWith<$Res> {
  _$DemandLineCopyWithImpl(this._self, this._then);

  final DemandLine _self;
  final $Res Function(DemandLine) _then;

  /// Create a copy of DemandLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? orderId = null,
    Object? companyId = null,
    Object? companyName = null,
    Object? clientId = null,
    Object? clientName = null,
    Object? shopName = null,
    Object? shopAddress = null,
    Object? products = null,
    Object? clientTotal = null,
  }) {
    return _then(_self.copyWith(
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderId: null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _self.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      shopName: null == shopName
          ? _self.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      shopAddress: null == shopAddress
          ? _self.shopAddress
          : shopAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      products: null == products
          ? _self.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<DemandLineItem>,
      clientTotal: null == clientTotal
          ? _self.clientTotal
          : clientTotal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of DemandLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get shopAddress {
    return $AddressCopyWith<$Res>(_self.shopAddress, (value) {
      return _then(_self.copyWith(shopAddress: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DemandLine].
extension DemandLinePatterns on DemandLine {
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
    TResult Function(_DemandLine value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemandLine() when $default != null:
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
    TResult Function(_DemandLine value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemandLine():
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
    TResult? Function(_DemandLine value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemandLine() when $default != null:
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
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(name: 'order_id') String orderId,
            @JsonKey(name: 'company_id') String companyId,
            @JsonKey(name: 'company_name') String companyName,
            @JsonKey(name: 'client_id') String clientId,
            @JsonKey(name: 'client_name') String clientName,
            @JsonKey(name: 'shop_name') String shopName,
            @JsonKey(name: 'shop_address') Address shopAddress,
            @JsonKey(name: 'products') List<DemandLineItem> products,
            @JsonKey(name: 'client_total') double clientTotal)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemandLine() when $default != null:
        return $default(
            _that.createdAt,
            _that.orderId,
            _that.companyId,
            _that.companyName,
            _that.clientId,
            _that.clientName,
            _that.shopName,
            _that.shopAddress,
            _that.products,
            _that.clientTotal);
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
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(name: 'order_id') String orderId,
            @JsonKey(name: 'company_id') String companyId,
            @JsonKey(name: 'company_name') String companyName,
            @JsonKey(name: 'client_id') String clientId,
            @JsonKey(name: 'client_name') String clientName,
            @JsonKey(name: 'shop_name') String shopName,
            @JsonKey(name: 'shop_address') Address shopAddress,
            @JsonKey(name: 'products') List<DemandLineItem> products,
            @JsonKey(name: 'client_total') double clientTotal)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemandLine():
        return $default(
            _that.createdAt,
            _that.orderId,
            _that.companyId,
            _that.companyName,
            _that.clientId,
            _that.clientName,
            _that.shopName,
            _that.shopAddress,
            _that.products,
            _that.clientTotal);
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
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(name: 'order_id') String orderId,
            @JsonKey(name: 'company_id') String companyId,
            @JsonKey(name: 'company_name') String companyName,
            @JsonKey(name: 'client_id') String clientId,
            @JsonKey(name: 'client_name') String clientName,
            @JsonKey(name: 'shop_name') String shopName,
            @JsonKey(name: 'shop_address') Address shopAddress,
            @JsonKey(name: 'products') List<DemandLineItem> products,
            @JsonKey(name: 'client_total') double clientTotal)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemandLine() when $default != null:
        return $default(
            _that.createdAt,
            _that.orderId,
            _that.companyId,
            _that.companyName,
            _that.clientId,
            _that.clientName,
            _that.shopName,
            _that.shopAddress,
            _that.products,
            _that.clientTotal);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DemandLine extends DemandLine {
  const _DemandLine(
      {@JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      required this.createdAt,
      @JsonKey(name: 'order_id') required this.orderId,
      @JsonKey(name: 'company_id') required this.companyId,
      @JsonKey(name: 'company_name') required this.companyName,
      @JsonKey(name: 'client_id') required this.clientId,
      @JsonKey(name: 'client_name') required this.clientName,
      @JsonKey(name: 'shop_name') required this.shopName,
      @JsonKey(name: 'shop_address') required this.shopAddress,
      @JsonKey(name: 'products') required final List<DemandLineItem> products,
      @JsonKey(name: 'client_total') required this.clientTotal})
      : _products = products,
        super._();
  factory _DemandLine.fromJson(Map<String, dynamic> json) =>
      _$DemandLineFromJson(json);

  @override
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  final DateTime createdAt;
  @override
  @JsonKey(name: 'order_id')
  final String orderId;
  @override
  @JsonKey(name: 'company_id')
  final String companyId;
  @override
  @JsonKey(name: 'company_name')
  final String companyName;
  @override
  @JsonKey(name: 'client_id')
  final String clientId;
  @override
  @JsonKey(name: 'client_name')
  final String clientName;
  @override
  @JsonKey(name: 'shop_name')
  final String shopName;
  @override
  @JsonKey(name: 'shop_address')
  final Address shopAddress;
  final List<DemandLineItem> _products;
  @override
  @JsonKey(name: 'products')
  List<DemandLineItem> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  @JsonKey(name: 'client_total')
  final double clientTotal;

  /// Create a copy of DemandLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DemandLineCopyWith<_DemandLine> get copyWith =>
      __$DemandLineCopyWithImpl<_DemandLine>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DemandLineToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DemandLine &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName) &&
            (identical(other.shopAddress, shopAddress) ||
                other.shopAddress == shopAddress) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.clientTotal, clientTotal) ||
                other.clientTotal == clientTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      createdAt,
      orderId,
      companyId,
      companyName,
      clientId,
      clientName,
      shopName,
      shopAddress,
      const DeepCollectionEquality().hash(_products),
      clientTotal);

  @override
  String toString() {
    return 'DemandLine(createdAt: $createdAt, orderId: $orderId, companyId: $companyId, companyName: $companyName, clientId: $clientId, clientName: $clientName, shopName: $shopName, shopAddress: $shopAddress, products: $products, clientTotal: $clientTotal)';
  }
}

/// @nodoc
abstract mixin class _$DemandLineCopyWith<$Res>
    implements $DemandLineCopyWith<$Res> {
  factory _$DemandLineCopyWith(
          _DemandLine value, $Res Function(_DemandLine) _then) =
      __$DemandLineCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(name: 'order_id') String orderId,
      @JsonKey(name: 'company_id') String companyId,
      @JsonKey(name: 'company_name') String companyName,
      @JsonKey(name: 'client_id') String clientId,
      @JsonKey(name: 'client_name') String clientName,
      @JsonKey(name: 'shop_name') String shopName,
      @JsonKey(name: 'shop_address') Address shopAddress,
      @JsonKey(name: 'products') List<DemandLineItem> products,
      @JsonKey(name: 'client_total') double clientTotal});

  @override
  $AddressCopyWith<$Res> get shopAddress;
}

/// @nodoc
class __$DemandLineCopyWithImpl<$Res> implements _$DemandLineCopyWith<$Res> {
  __$DemandLineCopyWithImpl(this._self, this._then);

  final _DemandLine _self;
  final $Res Function(_DemandLine) _then;

  /// Create a copy of DemandLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? createdAt = null,
    Object? orderId = null,
    Object? companyId = null,
    Object? companyName = null,
    Object? clientId = null,
    Object? clientName = null,
    Object? shopName = null,
    Object? shopAddress = null,
    Object? products = null,
    Object? clientTotal = null,
  }) {
    return _then(_DemandLine(
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orderId: null == orderId
          ? _self.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _self.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientName: null == clientName
          ? _self.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      shopName: null == shopName
          ? _self.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      shopAddress: null == shopAddress
          ? _self.shopAddress
          : shopAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      products: null == products
          ? _self._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<DemandLineItem>,
      clientTotal: null == clientTotal
          ? _self.clientTotal
          : clientTotal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of DemandLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get shopAddress {
    return $AddressCopyWith<$Res>(_self.shopAddress, (value) {
      return _then(_self.copyWith(shopAddress: value));
    });
  }
}

// dart format on
