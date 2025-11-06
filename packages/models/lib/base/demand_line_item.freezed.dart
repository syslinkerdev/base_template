// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demand_line_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
DemandLineItem _$DemandLineItemFromJson(Map<String, dynamic> json) {
  return _DemandProductItem.fromJson(json);
}

/// @nodoc
mixin _$DemandLineItem {
  @JsonKey(name: 'product_id')
  String get productId;
  @JsonKey(name: 'product_name')
  String get productName;
  @JsonKey(name: 'product_key')
  String get productKey;
  @JsonKey(name: 'unit_details')
  UnitDetail get unitDetails;
  @JsonKey(name: 'product_type')
  ProductType get productType;
  @JsonKey(name: 'quantity')
  int get quantity;
  @JsonKey(name: 'unit_price')
  double get unitPrice;
  @JsonKey(name: 'discount')
  double get discount;
  @JsonKey(name: 'subtotal')
  double get subtotal;

  /// Create a copy of DemandLineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DemandLineItemCopyWith<DemandLineItem> get copyWith =>
      _$DemandLineItemCopyWithImpl<DemandLineItem>(
          this as DemandLineItem, _$identity);

  /// Serializes this DemandLineItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DemandLineItem &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productKey, productKey) ||
                other.productKey == productKey) &&
            (identical(other.unitDetails, unitDetails) ||
                other.unitDetails == unitDetails) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      productName,
      productKey,
      unitDetails,
      productType,
      quantity,
      unitPrice,
      discount,
      subtotal);

  @override
  String toString() {
    return 'DemandLineItem(productId: $productId, productName: $productName, productKey: $productKey, unitDetails: $unitDetails, productType: $productType, quantity: $quantity, unitPrice: $unitPrice, discount: $discount, subtotal: $subtotal)';
  }
}

/// @nodoc
abstract mixin class $DemandLineItemCopyWith<$Res> {
  factory $DemandLineItemCopyWith(
          DemandLineItem value, $Res Function(DemandLineItem) _then) =
      _$DemandLineItemCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') String productId,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_key') String productKey,
      @JsonKey(name: 'unit_details') UnitDetail unitDetails,
      @JsonKey(name: 'product_type') ProductType productType,
      @JsonKey(name: 'quantity') int quantity,
      @JsonKey(name: 'unit_price') double unitPrice,
      @JsonKey(name: 'discount') double discount,
      @JsonKey(name: 'subtotal') double subtotal});

  $UnitDetailCopyWith<$Res> get unitDetails;
  $ProductTypeCopyWith<$Res> get productType;
}

/// @nodoc
class _$DemandLineItemCopyWithImpl<$Res>
    implements $DemandLineItemCopyWith<$Res> {
  _$DemandLineItemCopyWithImpl(this._self, this._then);

  final DemandLineItem _self;
  final $Res Function(DemandLineItem) _then;

  /// Create a copy of DemandLineItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? productKey = null,
    Object? unitDetails = null,
    Object? productType = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? discount = null,
    Object? subtotal = null,
  }) {
    return _then(_self.copyWith(
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _self.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productKey: null == productKey
          ? _self.productKey
          : productKey // ignore: cast_nullable_to_non_nullable
              as String,
      unitDetails: null == unitDetails
          ? _self.unitDetails
          : unitDetails // ignore: cast_nullable_to_non_nullable
              as UnitDetail,
      productType: null == productType
          ? _self.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as ProductType,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _self.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      subtotal: null == subtotal
          ? _self.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of DemandLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnitDetailCopyWith<$Res> get unitDetails {
    return $UnitDetailCopyWith<$Res>(_self.unitDetails, (value) {
      return _then(_self.copyWith(unitDetails: value));
    });
  }

  /// Create a copy of DemandLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductTypeCopyWith<$Res> get productType {
    return $ProductTypeCopyWith<$Res>(_self.productType, (value) {
      return _then(_self.copyWith(productType: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DemandLineItem].
extension DemandLineItemPatterns on DemandLineItem {
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
    TResult Function(_DemandProductItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemandProductItem() when $default != null:
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
    TResult Function(_DemandProductItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemandProductItem():
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
    TResult? Function(_DemandProductItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemandProductItem() when $default != null:
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
            @JsonKey(name: 'product_id') String productId,
            @JsonKey(name: 'product_name') String productName,
            @JsonKey(name: 'product_key') String productKey,
            @JsonKey(name: 'unit_details') UnitDetail unitDetails,
            @JsonKey(name: 'product_type') ProductType productType,
            @JsonKey(name: 'quantity') int quantity,
            @JsonKey(name: 'unit_price') double unitPrice,
            @JsonKey(name: 'discount') double discount,
            @JsonKey(name: 'subtotal') double subtotal)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DemandProductItem() when $default != null:
        return $default(
            _that.productId,
            _that.productName,
            _that.productKey,
            _that.unitDetails,
            _that.productType,
            _that.quantity,
            _that.unitPrice,
            _that.discount,
            _that.subtotal);
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
            @JsonKey(name: 'product_id') String productId,
            @JsonKey(name: 'product_name') String productName,
            @JsonKey(name: 'product_key') String productKey,
            @JsonKey(name: 'unit_details') UnitDetail unitDetails,
            @JsonKey(name: 'product_type') ProductType productType,
            @JsonKey(name: 'quantity') int quantity,
            @JsonKey(name: 'unit_price') double unitPrice,
            @JsonKey(name: 'discount') double discount,
            @JsonKey(name: 'subtotal') double subtotal)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemandProductItem():
        return $default(
            _that.productId,
            _that.productName,
            _that.productKey,
            _that.unitDetails,
            _that.productType,
            _that.quantity,
            _that.unitPrice,
            _that.discount,
            _that.subtotal);
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
            @JsonKey(name: 'product_id') String productId,
            @JsonKey(name: 'product_name') String productName,
            @JsonKey(name: 'product_key') String productKey,
            @JsonKey(name: 'unit_details') UnitDetail unitDetails,
            @JsonKey(name: 'product_type') ProductType productType,
            @JsonKey(name: 'quantity') int quantity,
            @JsonKey(name: 'unit_price') double unitPrice,
            @JsonKey(name: 'discount') double discount,
            @JsonKey(name: 'subtotal') double subtotal)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DemandProductItem() when $default != null:
        return $default(
            _that.productId,
            _that.productName,
            _that.productKey,
            _that.unitDetails,
            _that.productType,
            _that.quantity,
            _that.unitPrice,
            _that.discount,
            _that.subtotal);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DemandProductItem extends DemandLineItem {
  const _DemandProductItem(
      {@JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'product_name') required this.productName,
      @JsonKey(name: 'product_key') required this.productKey,
      @JsonKey(name: 'unit_details') required this.unitDetails,
      @JsonKey(name: 'product_type') required this.productType,
      @JsonKey(name: 'quantity') required this.quantity,
      @JsonKey(name: 'unit_price') required this.unitPrice,
      @JsonKey(name: 'discount') required this.discount,
      @JsonKey(name: 'subtotal') required this.subtotal})
      : super._();
  factory _DemandProductItem.fromJson(Map<String, dynamic> json) =>
      _$DemandProductItemFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final String productId;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  @JsonKey(name: 'product_key')
  final String productKey;
  @override
  @JsonKey(name: 'unit_details')
  final UnitDetail unitDetails;
  @override
  @JsonKey(name: 'product_type')
  final ProductType productType;
  @override
  @JsonKey(name: 'quantity')
  final int quantity;
  @override
  @JsonKey(name: 'unit_price')
  final double unitPrice;
  @override
  @JsonKey(name: 'discount')
  final double discount;
  @override
  @JsonKey(name: 'subtotal')
  final double subtotal;

  /// Create a copy of DemandLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DemandProductItemCopyWith<_DemandProductItem> get copyWith =>
      __$DemandProductItemCopyWithImpl<_DemandProductItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DemandProductItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DemandProductItem &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productKey, productKey) ||
                other.productKey == productKey) &&
            (identical(other.unitDetails, unitDetails) ||
                other.unitDetails == unitDetails) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      productName,
      productKey,
      unitDetails,
      productType,
      quantity,
      unitPrice,
      discount,
      subtotal);

  @override
  String toString() {
    return 'DemandLineItem(productId: $productId, productName: $productName, productKey: $productKey, unitDetails: $unitDetails, productType: $productType, quantity: $quantity, unitPrice: $unitPrice, discount: $discount, subtotal: $subtotal)';
  }
}

/// @nodoc
abstract mixin class _$DemandProductItemCopyWith<$Res>
    implements $DemandLineItemCopyWith<$Res> {
  factory _$DemandProductItemCopyWith(
          _DemandProductItem value, $Res Function(_DemandProductItem) _then) =
      __$DemandProductItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') String productId,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_key') String productKey,
      @JsonKey(name: 'unit_details') UnitDetail unitDetails,
      @JsonKey(name: 'product_type') ProductType productType,
      @JsonKey(name: 'quantity') int quantity,
      @JsonKey(name: 'unit_price') double unitPrice,
      @JsonKey(name: 'discount') double discount,
      @JsonKey(name: 'subtotal') double subtotal});

  @override
  $UnitDetailCopyWith<$Res> get unitDetails;
  @override
  $ProductTypeCopyWith<$Res> get productType;
}

/// @nodoc
class __$DemandProductItemCopyWithImpl<$Res>
    implements _$DemandProductItemCopyWith<$Res> {
  __$DemandProductItemCopyWithImpl(this._self, this._then);

  final _DemandProductItem _self;
  final $Res Function(_DemandProductItem) _then;

  /// Create a copy of DemandLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? productKey = null,
    Object? unitDetails = null,
    Object? productType = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? discount = null,
    Object? subtotal = null,
  }) {
    return _then(_DemandProductItem(
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _self.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productKey: null == productKey
          ? _self.productKey
          : productKey // ignore: cast_nullable_to_non_nullable
              as String,
      unitDetails: null == unitDetails
          ? _self.unitDetails
          : unitDetails // ignore: cast_nullable_to_non_nullable
              as UnitDetail,
      productType: null == productType
          ? _self.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as ProductType,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _self.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      subtotal: null == subtotal
          ? _self.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of DemandLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnitDetailCopyWith<$Res> get unitDetails {
    return $UnitDetailCopyWith<$Res>(_self.unitDetails, (value) {
      return _then(_self.copyWith(unitDetails: value));
    });
  }

  /// Create a copy of DemandLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductTypeCopyWith<$Res> get productType {
    return $ProductTypeCopyWith<$Res>(_self.productType, (value) {
      return _then(_self.copyWith(productType: value));
    });
  }
}

// dart format on
