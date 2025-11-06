// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {
// CLIENT-SIDE SELECTION
  int? get userSideQuantity; // user-selected quantity
  double? get priceAfterDiscount; // calculated after discount
// CORE DETAILS
  String get id;
  String get name;
  Brand get brand;
  Category get category;
  @JsonKey(name: 'product_type')
  ProductType get productType;
  String get image; // URL or asset path
  double get price;
  String get currency;
  @JsonKey(name: 'search_key')
  String get searchKey;
  @JsonKey(name: 'short_form')
  String get shortForm; // SKU
// UNIT INFO
  @JsonKey(name: 'unit_details')
  UnitDetail get unitDetails; // ORDERING CONSTRAINTS
// @JsonKey(name: 'min_buy_quantity') required int minBuyQuantity,
  @JsonKey(name: 'pack_size')
  int get packSize;
  @JsonKey(name: 'quick_add_options')
  List<PackagingType> get quickAddOptions; // SYSTEM STATUS
  @JsonKey(
      name: 'status',
      fromJson: ProductStatusConverter.fromJson,
      toJson: ProductStatusConverter.toJson)
  ProductStatus get status; // META
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  DateTime get createdAt;
  @JsonKey(name: 'created_by')
  String get createdBy;
  @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get updatedAt;
  @JsonKey(name: 'updated_by')
  String? get updatedBy;
  @JsonKey(name: 'order_frequency')
  String? get orderFrequency;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductCopyWith<Product> get copyWith =>
      _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Product &&
            (identical(other.userSideQuantity, userSideQuantity) ||
                other.userSideQuantity == userSideQuantity) &&
            (identical(other.priceAfterDiscount, priceAfterDiscount) ||
                other.priceAfterDiscount == priceAfterDiscount) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey) &&
            (identical(other.shortForm, shortForm) ||
                other.shortForm == shortForm) &&
            (identical(other.unitDetails, unitDetails) ||
                other.unitDetails == unitDetails) &&
            (identical(other.packSize, packSize) ||
                other.packSize == packSize) &&
            const DeepCollectionEquality()
                .equals(other.quickAddOptions, quickAddOptions) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            (identical(other.orderFrequency, orderFrequency) ||
                other.orderFrequency == orderFrequency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userSideQuantity,
        priceAfterDiscount,
        id,
        name,
        brand,
        category,
        productType,
        image,
        price,
        currency,
        searchKey,
        shortForm,
        unitDetails,
        packSize,
        const DeepCollectionEquality().hash(quickAddOptions),
        status,
        createdAt,
        createdBy,
        updatedAt,
        updatedBy,
        orderFrequency
      ]);

  @override
  String toString() {
    return 'Product(userSideQuantity: $userSideQuantity, priceAfterDiscount: $priceAfterDiscount, id: $id, name: $name, brand: $brand, category: $category, productType: $productType, image: $image, price: $price, currency: $currency, searchKey: $searchKey, shortForm: $shortForm, unitDetails: $unitDetails, packSize: $packSize, quickAddOptions: $quickAddOptions, status: $status, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy, orderFrequency: $orderFrequency)';
  }
}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) =
      _$ProductCopyWithImpl;
  @useResult
  $Res call(
      {int? userSideQuantity,
      double? priceAfterDiscount,
      String id,
      String name,
      Brand brand,
      Category category,
      @JsonKey(name: 'product_type') ProductType productType,
      String image,
      double price,
      String currency,
      @JsonKey(name: 'search_key') String searchKey,
      @JsonKey(name: 'short_form') String shortForm,
      @JsonKey(name: 'unit_details') UnitDetail unitDetails,
      @JsonKey(name: 'pack_size') int packSize,
      @JsonKey(name: 'quick_add_options') List<PackagingType> quickAddOptions,
      @JsonKey(
          name: 'status',
          fromJson: ProductStatusConverter.fromJson,
          toJson: ProductStatusConverter.toJson)
      ProductStatus status,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? updatedAt,
      @JsonKey(name: 'updated_by') String? updatedBy,
      @JsonKey(name: 'order_frequency') String? orderFrequency});

  $BrandCopyWith<$Res> get brand;
  $CategoryCopyWith<$Res> get category;
  $ProductTypeCopyWith<$Res> get productType;
  $UnitDetailCopyWith<$Res> get unitDetails;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res> implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userSideQuantity = freezed,
    Object? priceAfterDiscount = freezed,
    Object? id = null,
    Object? name = null,
    Object? brand = null,
    Object? category = null,
    Object? productType = null,
    Object? image = null,
    Object? price = null,
    Object? currency = null,
    Object? searchKey = null,
    Object? shortForm = null,
    Object? unitDetails = null,
    Object? packSize = null,
    Object? quickAddOptions = null,
    Object? status = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
    Object? orderFrequency = freezed,
  }) {
    return _then(_self.copyWith(
      userSideQuantity: freezed == userSideQuantity
          ? _self.userSideQuantity
          : userSideQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      priceAfterDiscount: freezed == priceAfterDiscount
          ? _self.priceAfterDiscount
          : priceAfterDiscount // ignore: cast_nullable_to_non_nullable
              as double?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as Brand,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      productType: null == productType
          ? _self.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as ProductType,
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      searchKey: null == searchKey
          ? _self.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String,
      shortForm: null == shortForm
          ? _self.shortForm
          : shortForm // ignore: cast_nullable_to_non_nullable
              as String,
      unitDetails: null == unitDetails
          ? _self.unitDetails
          : unitDetails // ignore: cast_nullable_to_non_nullable
              as UnitDetail,
      packSize: null == packSize
          ? _self.packSize
          : packSize // ignore: cast_nullable_to_non_nullable
              as int,
      quickAddOptions: null == quickAddOptions
          ? _self.quickAddOptions
          : quickAddOptions // ignore: cast_nullable_to_non_nullable
              as List<PackagingType>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductStatus,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _self.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      orderFrequency: freezed == orderFrequency
          ? _self.orderFrequency
          : orderFrequency // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BrandCopyWith<$Res> get brand {
    return $BrandCopyWith<$Res>(_self.brand, (value) {
      return _then(_self.copyWith(brand: value));
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_self.category, (value) {
      return _then(_self.copyWith(category: value));
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductTypeCopyWith<$Res> get productType {
    return $ProductTypeCopyWith<$Res>(_self.productType, (value) {
      return _then(_self.copyWith(productType: value));
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnitDetailCopyWith<$Res> get unitDetails {
    return $UnitDetailCopyWith<$Res>(_self.unitDetails, (value) {
      return _then(_self.copyWith(unitDetails: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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
    TResult Function(_Product value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Product() when $default != null:
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
    TResult Function(_Product value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Product():
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
    TResult? Function(_Product value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Product() when $default != null:
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
            int? userSideQuantity,
            double? priceAfterDiscount,
            String id,
            String name,
            Brand brand,
            Category category,
            @JsonKey(name: 'product_type') ProductType productType,
            String image,
            double price,
            String currency,
            @JsonKey(name: 'search_key') String searchKey,
            @JsonKey(name: 'short_form') String shortForm,
            @JsonKey(name: 'unit_details') UnitDetail unitDetails,
            @JsonKey(name: 'pack_size') int packSize,
            @JsonKey(name: 'quick_add_options')
            List<PackagingType> quickAddOptions,
            @JsonKey(
                name: 'status',
                fromJson: ProductStatusConverter.fromJson,
                toJson: ProductStatusConverter.toJson)
            ProductStatus status,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(name: 'created_by') String createdBy,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt,
            @JsonKey(name: 'updated_by') String? updatedBy,
            @JsonKey(name: 'order_frequency') String? orderFrequency)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Product() when $default != null:
        return $default(
            _that.userSideQuantity,
            _that.priceAfterDiscount,
            _that.id,
            _that.name,
            _that.brand,
            _that.category,
            _that.productType,
            _that.image,
            _that.price,
            _that.currency,
            _that.searchKey,
            _that.shortForm,
            _that.unitDetails,
            _that.packSize,
            _that.quickAddOptions,
            _that.status,
            _that.createdAt,
            _that.createdBy,
            _that.updatedAt,
            _that.updatedBy,
            _that.orderFrequency);
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
            int? userSideQuantity,
            double? priceAfterDiscount,
            String id,
            String name,
            Brand brand,
            Category category,
            @JsonKey(name: 'product_type') ProductType productType,
            String image,
            double price,
            String currency,
            @JsonKey(name: 'search_key') String searchKey,
            @JsonKey(name: 'short_form') String shortForm,
            @JsonKey(name: 'unit_details') UnitDetail unitDetails,
            @JsonKey(name: 'pack_size') int packSize,
            @JsonKey(name: 'quick_add_options')
            List<PackagingType> quickAddOptions,
            @JsonKey(
                name: 'status',
                fromJson: ProductStatusConverter.fromJson,
                toJson: ProductStatusConverter.toJson)
            ProductStatus status,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(name: 'created_by') String createdBy,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt,
            @JsonKey(name: 'updated_by') String? updatedBy,
            @JsonKey(name: 'order_frequency') String? orderFrequency)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Product():
        return $default(
            _that.userSideQuantity,
            _that.priceAfterDiscount,
            _that.id,
            _that.name,
            _that.brand,
            _that.category,
            _that.productType,
            _that.image,
            _that.price,
            _that.currency,
            _that.searchKey,
            _that.shortForm,
            _that.unitDetails,
            _that.packSize,
            _that.quickAddOptions,
            _that.status,
            _that.createdAt,
            _that.createdBy,
            _that.updatedAt,
            _that.updatedBy,
            _that.orderFrequency);
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
            int? userSideQuantity,
            double? priceAfterDiscount,
            String id,
            String name,
            Brand brand,
            Category category,
            @JsonKey(name: 'product_type') ProductType productType,
            String image,
            double price,
            String currency,
            @JsonKey(name: 'search_key') String searchKey,
            @JsonKey(name: 'short_form') String shortForm,
            @JsonKey(name: 'unit_details') UnitDetail unitDetails,
            @JsonKey(name: 'pack_size') int packSize,
            @JsonKey(name: 'quick_add_options')
            List<PackagingType> quickAddOptions,
            @JsonKey(
                name: 'status',
                fromJson: ProductStatusConverter.fromJson,
                toJson: ProductStatusConverter.toJson)
            ProductStatus status,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(name: 'created_by') String createdBy,
            @JsonKey(
                name: 'updated_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? updatedAt,
            @JsonKey(name: 'updated_by') String? updatedBy,
            @JsonKey(name: 'order_frequency') String? orderFrequency)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Product() when $default != null:
        return $default(
            _that.userSideQuantity,
            _that.priceAfterDiscount,
            _that.id,
            _that.name,
            _that.brand,
            _that.category,
            _that.productType,
            _that.image,
            _that.price,
            _that.currency,
            _that.searchKey,
            _that.shortForm,
            _that.unitDetails,
            _that.packSize,
            _that.quickAddOptions,
            _that.status,
            _that.createdAt,
            _that.createdBy,
            _that.updatedAt,
            _that.updatedBy,
            _that.orderFrequency);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Product extends Product {
  _Product(
      {this.userSideQuantity = 0,
      this.priceAfterDiscount = 0,
      required this.id,
      required this.name,
      required this.brand,
      required this.category,
      @JsonKey(name: 'product_type') required this.productType,
      required this.image,
      required this.price,
      this.currency = 'INR',
      @JsonKey(name: 'search_key') required this.searchKey,
      @JsonKey(name: 'short_form') required this.shortForm,
      @JsonKey(name: 'unit_details') required this.unitDetails,
      @JsonKey(name: 'pack_size') required this.packSize,
      @JsonKey(name: 'quick_add_options')
      required final List<PackagingType> quickAddOptions,
      @JsonKey(
          name: 'status',
          fromJson: ProductStatusConverter.fromJson,
          toJson: ProductStatusConverter.toJson)
      this.status = ProductStatus.draft,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      required this.createdAt,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      this.updatedAt,
      @JsonKey(name: 'updated_by') this.updatedBy,
      @JsonKey(name: 'order_frequency') this.orderFrequency})
      : _quickAddOptions = quickAddOptions,
        super._();
  factory _Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

// CLIENT-SIDE SELECTION
  @override
  @JsonKey()
  final int? userSideQuantity;
// user-selected quantity
  @override
  @JsonKey()
  final double? priceAfterDiscount;
// calculated after discount
// CORE DETAILS
  @override
  final String id;
  @override
  final String name;
  @override
  final Brand brand;
  @override
  final Category category;
  @override
  @JsonKey(name: 'product_type')
  final ProductType productType;
  @override
  final String image;
// URL or asset path
  @override
  final double price;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(name: 'search_key')
  final String searchKey;
  @override
  @JsonKey(name: 'short_form')
  final String shortForm;
// SKU
// UNIT INFO
  @override
  @JsonKey(name: 'unit_details')
  final UnitDetail unitDetails;
// ORDERING CONSTRAINTS
// @JsonKey(name: 'min_buy_quantity') required int minBuyQuantity,
  @override
  @JsonKey(name: 'pack_size')
  final int packSize;
  final List<PackagingType> _quickAddOptions;
  @override
  @JsonKey(name: 'quick_add_options')
  List<PackagingType> get quickAddOptions {
    if (_quickAddOptions is EqualUnmodifiableListView) return _quickAddOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickAddOptions);
  }

// SYSTEM STATUS
  @override
  @JsonKey(
      name: 'status',
      fromJson: ProductStatusConverter.fromJson,
      toJson: ProductStatusConverter.toJson)
  final ProductStatus status;
// META
  @override
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  final DateTime createdAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'updated_by')
  final String? updatedBy;
  @override
  @JsonKey(name: 'order_frequency')
  final String? orderFrequency;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductCopyWith<_Product> get copyWith =>
      __$ProductCopyWithImpl<_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Product &&
            (identical(other.userSideQuantity, userSideQuantity) ||
                other.userSideQuantity == userSideQuantity) &&
            (identical(other.priceAfterDiscount, priceAfterDiscount) ||
                other.priceAfterDiscount == priceAfterDiscount) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey) &&
            (identical(other.shortForm, shortForm) ||
                other.shortForm == shortForm) &&
            (identical(other.unitDetails, unitDetails) ||
                other.unitDetails == unitDetails) &&
            (identical(other.packSize, packSize) ||
                other.packSize == packSize) &&
            const DeepCollectionEquality()
                .equals(other._quickAddOptions, _quickAddOptions) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            (identical(other.orderFrequency, orderFrequency) ||
                other.orderFrequency == orderFrequency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userSideQuantity,
        priceAfterDiscount,
        id,
        name,
        brand,
        category,
        productType,
        image,
        price,
        currency,
        searchKey,
        shortForm,
        unitDetails,
        packSize,
        const DeepCollectionEquality().hash(_quickAddOptions),
        status,
        createdAt,
        createdBy,
        updatedAt,
        updatedBy,
        orderFrequency
      ]);

  @override
  String toString() {
    return 'Product(userSideQuantity: $userSideQuantity, priceAfterDiscount: $priceAfterDiscount, id: $id, name: $name, brand: $brand, category: $category, productType: $productType, image: $image, price: $price, currency: $currency, searchKey: $searchKey, shortForm: $shortForm, unitDetails: $unitDetails, packSize: $packSize, quickAddOptions: $quickAddOptions, status: $status, createdAt: $createdAt, createdBy: $createdBy, updatedAt: $updatedAt, updatedBy: $updatedBy, orderFrequency: $orderFrequency)';
  }
}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) =
      __$ProductCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? userSideQuantity,
      double? priceAfterDiscount,
      String id,
      String name,
      Brand brand,
      Category category,
      @JsonKey(name: 'product_type') ProductType productType,
      String image,
      double price,
      String currency,
      @JsonKey(name: 'search_key') String searchKey,
      @JsonKey(name: 'short_form') String shortForm,
      @JsonKey(name: 'unit_details') UnitDetail unitDetails,
      @JsonKey(name: 'pack_size') int packSize,
      @JsonKey(name: 'quick_add_options') List<PackagingType> quickAddOptions,
      @JsonKey(
          name: 'status',
          fromJson: ProductStatusConverter.fromJson,
          toJson: ProductStatusConverter.toJson)
      ProductStatus status,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(
          name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? updatedAt,
      @JsonKey(name: 'updated_by') String? updatedBy,
      @JsonKey(name: 'order_frequency') String? orderFrequency});

  @override
  $BrandCopyWith<$Res> get brand;
  @override
  $CategoryCopyWith<$Res> get category;
  @override
  $ProductTypeCopyWith<$Res> get productType;
  @override
  $UnitDetailCopyWith<$Res> get unitDetails;
}

/// @nodoc
class __$ProductCopyWithImpl<$Res> implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userSideQuantity = freezed,
    Object? priceAfterDiscount = freezed,
    Object? id = null,
    Object? name = null,
    Object? brand = null,
    Object? category = null,
    Object? productType = null,
    Object? image = null,
    Object? price = null,
    Object? currency = null,
    Object? searchKey = null,
    Object? shortForm = null,
    Object? unitDetails = null,
    Object? packSize = null,
    Object? quickAddOptions = null,
    Object? status = null,
    Object? createdAt = null,
    Object? createdBy = null,
    Object? updatedAt = freezed,
    Object? updatedBy = freezed,
    Object? orderFrequency = freezed,
  }) {
    return _then(_Product(
      userSideQuantity: freezed == userSideQuantity
          ? _self.userSideQuantity
          : userSideQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      priceAfterDiscount: freezed == priceAfterDiscount
          ? _self.priceAfterDiscount
          : priceAfterDiscount // ignore: cast_nullable_to_non_nullable
              as double?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as Brand,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      productType: null == productType
          ? _self.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as ProductType,
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      searchKey: null == searchKey
          ? _self.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String,
      shortForm: null == shortForm
          ? _self.shortForm
          : shortForm // ignore: cast_nullable_to_non_nullable
              as String,
      unitDetails: null == unitDetails
          ? _self.unitDetails
          : unitDetails // ignore: cast_nullable_to_non_nullable
              as UnitDetail,
      packSize: null == packSize
          ? _self.packSize
          : packSize // ignore: cast_nullable_to_non_nullable
              as int,
      quickAddOptions: null == quickAddOptions
          ? _self._quickAddOptions
          : quickAddOptions // ignore: cast_nullable_to_non_nullable
              as List<PackagingType>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductStatus,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedBy: freezed == updatedBy
          ? _self.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      orderFrequency: freezed == orderFrequency
          ? _self.orderFrequency
          : orderFrequency // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BrandCopyWith<$Res> get brand {
    return $BrandCopyWith<$Res>(_self.brand, (value) {
      return _then(_self.copyWith(brand: value));
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_self.category, (value) {
      return _then(_self.copyWith(category: value));
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductTypeCopyWith<$Res> get productType {
    return $ProductTypeCopyWith<$Res>(_self.productType, (value) {
      return _then(_self.copyWith(productType: value));
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UnitDetailCopyWith<$Res> get unitDetails {
    return $UnitDetailCopyWith<$Res>(_self.unitDetails, (value) {
      return _then(_self.copyWith(unitDetails: value));
    });
  }
}

// dart format on
