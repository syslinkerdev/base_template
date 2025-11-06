// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductLine {
  @JsonKey(name: 'company_id')
  String get companyId;
  @JsonKey(name: 'company_name')
  String get companyName;
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
  @JsonKey(name: 'total_quantity')
  int get totalQuantity;
  @JsonKey(name: 'unit_price')
  double get unitPrice;
  @JsonKey(name: 'discount')
  double get discount;
  @JsonKey(name: 'subtotal')
  double get subtotal;

  /// Create a copy of ProductLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductLineCopyWith<ProductLine> get copyWith =>
      _$ProductLineCopyWithImpl<ProductLine>(this as ProductLine, _$identity);

  /// Serializes this ProductLine to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductLine &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
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
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
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
      companyId,
      companyName,
      productId,
      productName,
      productKey,
      unitDetails,
      productType,
      totalQuantity,
      unitPrice,
      discount,
      subtotal);

  @override
  String toString() {
    return 'ProductLine(companyId: $companyId, companyName: $companyName, productId: $productId, productName: $productName, productKey: $productKey, unitDetails: $unitDetails, productType: $productType, totalQuantity: $totalQuantity, unitPrice: $unitPrice, discount: $discount, subtotal: $subtotal)';
  }
}

/// @nodoc
abstract mixin class $ProductLineCopyWith<$Res> {
  factory $ProductLineCopyWith(
          ProductLine value, $Res Function(ProductLine) _then) =
      _$ProductLineCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'company_id') String companyId,
      @JsonKey(name: 'company_name') String companyName,
      @JsonKey(name: 'product_id') String productId,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_key') String productKey,
      @JsonKey(name: 'unit_details') UnitDetail unitDetails,
      @JsonKey(name: 'product_type') ProductType productType,
      @JsonKey(name: 'total_quantity') int totalQuantity,
      @JsonKey(name: 'unit_price') double unitPrice,
      @JsonKey(name: 'discount') double discount,
      @JsonKey(name: 'subtotal') double subtotal});

  $UnitDetailCopyWith<$Res> get unitDetails;
  $ProductTypeCopyWith<$Res> get productType;
}

/// @nodoc
class _$ProductLineCopyWithImpl<$Res> implements $ProductLineCopyWith<$Res> {
  _$ProductLineCopyWithImpl(this._self, this._then);

  final ProductLine _self;
  final $Res Function(ProductLine) _then;

  /// Create a copy of ProductLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyId = null,
    Object? companyName = null,
    Object? productId = null,
    Object? productName = null,
    Object? productKey = null,
    Object? unitDetails = null,
    Object? productType = null,
    Object? totalQuantity = null,
    Object? unitPrice = null,
    Object? discount = null,
    Object? subtotal = null,
  }) {
    return _then(_self.copyWith(
      companyId: null == companyId
          ? _self.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
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
      totalQuantity: null == totalQuantity
          ? _self.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of ProductLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnitDetailCopyWith<$Res> get unitDetails {
    return $UnitDetailCopyWith<$Res>(_self.unitDetails, (value) {
      return _then(_self.copyWith(unitDetails: value));
    });
  }

  /// Create a copy of ProductLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductTypeCopyWith<$Res> get productType {
    return $ProductTypeCopyWith<$Res>(_self.productType, (value) {
      return _then(_self.copyWith(productType: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ProductLine].
extension ProductLinePatterns on ProductLine {
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
    TResult Function(_ProductLine value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductLine() when $default != null:
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
    TResult Function(_ProductLine value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductLine():
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
    TResult? Function(_ProductLine value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductLine() when $default != null:
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
            @JsonKey(name: 'company_id') String companyId,
            @JsonKey(name: 'company_name') String companyName,
            @JsonKey(name: 'product_id') String productId,
            @JsonKey(name: 'product_name') String productName,
            @JsonKey(name: 'product_key') String productKey,
            @JsonKey(name: 'unit_details') UnitDetail unitDetails,
            @JsonKey(name: 'product_type') ProductType productType,
            @JsonKey(name: 'total_quantity') int totalQuantity,
            @JsonKey(name: 'unit_price') double unitPrice,
            @JsonKey(name: 'discount') double discount,
            @JsonKey(name: 'subtotal') double subtotal)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductLine() when $default != null:
        return $default(
            _that.companyId,
            _that.companyName,
            _that.productId,
            _that.productName,
            _that.productKey,
            _that.unitDetails,
            _that.productType,
            _that.totalQuantity,
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
            @JsonKey(name: 'company_id') String companyId,
            @JsonKey(name: 'company_name') String companyName,
            @JsonKey(name: 'product_id') String productId,
            @JsonKey(name: 'product_name') String productName,
            @JsonKey(name: 'product_key') String productKey,
            @JsonKey(name: 'unit_details') UnitDetail unitDetails,
            @JsonKey(name: 'product_type') ProductType productType,
            @JsonKey(name: 'total_quantity') int totalQuantity,
            @JsonKey(name: 'unit_price') double unitPrice,
            @JsonKey(name: 'discount') double discount,
            @JsonKey(name: 'subtotal') double subtotal)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductLine():
        return $default(
            _that.companyId,
            _that.companyName,
            _that.productId,
            _that.productName,
            _that.productKey,
            _that.unitDetails,
            _that.productType,
            _that.totalQuantity,
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
            @JsonKey(name: 'company_id') String companyId,
            @JsonKey(name: 'company_name') String companyName,
            @JsonKey(name: 'product_id') String productId,
            @JsonKey(name: 'product_name') String productName,
            @JsonKey(name: 'product_key') String productKey,
            @JsonKey(name: 'unit_details') UnitDetail unitDetails,
            @JsonKey(name: 'product_type') ProductType productType,
            @JsonKey(name: 'total_quantity') int totalQuantity,
            @JsonKey(name: 'unit_price') double unitPrice,
            @JsonKey(name: 'discount') double discount,
            @JsonKey(name: 'subtotal') double subtotal)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductLine() when $default != null:
        return $default(
            _that.companyId,
            _that.companyName,
            _that.productId,
            _that.productName,
            _that.productKey,
            _that.unitDetails,
            _that.productType,
            _that.totalQuantity,
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
class _ProductLine extends ProductLine {
  const _ProductLine(
      {@JsonKey(name: 'company_id') required this.companyId,
      @JsonKey(name: 'company_name') required this.companyName,
      @JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'product_name') required this.productName,
      @JsonKey(name: 'product_key') required this.productKey,
      @JsonKey(name: 'unit_details') required this.unitDetails,
      @JsonKey(name: 'product_type') required this.productType,
      @JsonKey(name: 'total_quantity') required this.totalQuantity,
      @JsonKey(name: 'unit_price') required this.unitPrice,
      @JsonKey(name: 'discount') required this.discount,
      @JsonKey(name: 'subtotal') required this.subtotal})
      : super._();
  factory _ProductLine.fromJson(Map<String, dynamic> json) =>
      _$ProductLineFromJson(json);

  @override
  @JsonKey(name: 'company_id')
  final String companyId;
  @override
  @JsonKey(name: 'company_name')
  final String companyName;
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
  @JsonKey(name: 'total_quantity')
  final int totalQuantity;
  @override
  @JsonKey(name: 'unit_price')
  final double unitPrice;
  @override
  @JsonKey(name: 'discount')
  final double discount;
  @override
  @JsonKey(name: 'subtotal')
  final double subtotal;

  /// Create a copy of ProductLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductLineCopyWith<_ProductLine> get copyWith =>
      __$ProductLineCopyWithImpl<_ProductLine>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductLineToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductLine &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
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
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
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
      companyId,
      companyName,
      productId,
      productName,
      productKey,
      unitDetails,
      productType,
      totalQuantity,
      unitPrice,
      discount,
      subtotal);

  @override
  String toString() {
    return 'ProductLine(companyId: $companyId, companyName: $companyName, productId: $productId, productName: $productName, productKey: $productKey, unitDetails: $unitDetails, productType: $productType, totalQuantity: $totalQuantity, unitPrice: $unitPrice, discount: $discount, subtotal: $subtotal)';
  }
}

/// @nodoc
abstract mixin class _$ProductLineCopyWith<$Res>
    implements $ProductLineCopyWith<$Res> {
  factory _$ProductLineCopyWith(
          _ProductLine value, $Res Function(_ProductLine) _then) =
      __$ProductLineCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'company_id') String companyId,
      @JsonKey(name: 'company_name') String companyName,
      @JsonKey(name: 'product_id') String productId,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_key') String productKey,
      @JsonKey(name: 'unit_details') UnitDetail unitDetails,
      @JsonKey(name: 'product_type') ProductType productType,
      @JsonKey(name: 'total_quantity') int totalQuantity,
      @JsonKey(name: 'unit_price') double unitPrice,
      @JsonKey(name: 'discount') double discount,
      @JsonKey(name: 'subtotal') double subtotal});

  @override
  $UnitDetailCopyWith<$Res> get unitDetails;
  @override
  $ProductTypeCopyWith<$Res> get productType;
}

/// @nodoc
class __$ProductLineCopyWithImpl<$Res> implements _$ProductLineCopyWith<$Res> {
  __$ProductLineCopyWithImpl(this._self, this._then);

  final _ProductLine _self;
  final $Res Function(_ProductLine) _then;

  /// Create a copy of ProductLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? companyId = null,
    Object? companyName = null,
    Object? productId = null,
    Object? productName = null,
    Object? productKey = null,
    Object? unitDetails = null,
    Object? productType = null,
    Object? totalQuantity = null,
    Object? unitPrice = null,
    Object? discount = null,
    Object? subtotal = null,
  }) {
    return _then(_ProductLine(
      companyId: null == companyId
          ? _self.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
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
      totalQuantity: null == totalQuantity
          ? _self.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of ProductLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnitDetailCopyWith<$Res> get unitDetails {
    return $UnitDetailCopyWith<$Res>(_self.unitDetails, (value) {
      return _then(_self.copyWith(unitDetails: value));
    });
  }

  /// Create a copy of ProductLine
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
