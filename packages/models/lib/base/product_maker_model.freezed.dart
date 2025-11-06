// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_maker_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductMaker {
  List<Brand> get brands;
  List<Category> get categories;
  @JsonKey(name: 'packaging_types')
  List<PackagingType> get packagingTypes;
  List<UnitDetail> get units; // NEW: product types
  @JsonKey(name: 'product_types')
  List<ProductType> get productTypes;

  /// Create a copy of ProductMaker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductMakerCopyWith<ProductMaker> get copyWith =>
      _$ProductMakerCopyWithImpl<ProductMaker>(
          this as ProductMaker, _$identity);

  /// Serializes this ProductMaker to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductMaker &&
            const DeepCollectionEquality().equals(other.brands, brands) &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            const DeepCollectionEquality()
                .equals(other.packagingTypes, packagingTypes) &&
            const DeepCollectionEquality().equals(other.units, units) &&
            const DeepCollectionEquality()
                .equals(other.productTypes, productTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(brands),
      const DeepCollectionEquality().hash(categories),
      const DeepCollectionEquality().hash(packagingTypes),
      const DeepCollectionEquality().hash(units),
      const DeepCollectionEquality().hash(productTypes));

  @override
  String toString() {
    return 'ProductMaker(brands: $brands, categories: $categories, packagingTypes: $packagingTypes, units: $units, productTypes: $productTypes)';
  }
}

/// @nodoc
abstract mixin class $ProductMakerCopyWith<$Res> {
  factory $ProductMakerCopyWith(
          ProductMaker value, $Res Function(ProductMaker) _then) =
      _$ProductMakerCopyWithImpl;
  @useResult
  $Res call(
      {List<Brand> brands,
      List<Category> categories,
      @JsonKey(name: 'packaging_types') List<PackagingType> packagingTypes,
      List<UnitDetail> units,
      @JsonKey(name: 'product_types') List<ProductType> productTypes});
}

/// @nodoc
class _$ProductMakerCopyWithImpl<$Res> implements $ProductMakerCopyWith<$Res> {
  _$ProductMakerCopyWithImpl(this._self, this._then);

  final ProductMaker _self;
  final $Res Function(ProductMaker) _then;

  /// Create a copy of ProductMaker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brands = null,
    Object? categories = null,
    Object? packagingTypes = null,
    Object? units = null,
    Object? productTypes = null,
  }) {
    return _then(_self.copyWith(
      brands: null == brands
          ? _self.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<Brand>,
      categories: null == categories
          ? _self.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      packagingTypes: null == packagingTypes
          ? _self.packagingTypes
          : packagingTypes // ignore: cast_nullable_to_non_nullable
              as List<PackagingType>,
      units: null == units
          ? _self.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<UnitDetail>,
      productTypes: null == productTypes
          ? _self.productTypes
          : productTypes // ignore: cast_nullable_to_non_nullable
              as List<ProductType>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProductMaker].
extension ProductMakerPatterns on ProductMaker {
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
    TResult Function(_ProductMaker value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductMaker() when $default != null:
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
    TResult Function(_ProductMaker value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMaker():
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
    TResult? Function(_ProductMaker value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMaker() when $default != null:
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
            List<Brand> brands,
            List<Category> categories,
            @JsonKey(name: 'packaging_types')
            List<PackagingType> packagingTypes,
            List<UnitDetail> units,
            @JsonKey(name: 'product_types') List<ProductType> productTypes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductMaker() when $default != null:
        return $default(_that.brands, _that.categories, _that.packagingTypes,
            _that.units, _that.productTypes);
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
            List<Brand> brands,
            List<Category> categories,
            @JsonKey(name: 'packaging_types')
            List<PackagingType> packagingTypes,
            List<UnitDetail> units,
            @JsonKey(name: 'product_types') List<ProductType> productTypes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMaker():
        return $default(_that.brands, _that.categories, _that.packagingTypes,
            _that.units, _that.productTypes);
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
            List<Brand> brands,
            List<Category> categories,
            @JsonKey(name: 'packaging_types')
            List<PackagingType> packagingTypes,
            List<UnitDetail> units,
            @JsonKey(name: 'product_types') List<ProductType> productTypes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductMaker() when $default != null:
        return $default(_that.brands, _that.categories, _that.packagingTypes,
            _that.units, _that.productTypes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ProductMaker extends ProductMaker {
  const _ProductMaker(
      {required final List<Brand> brands,
      required final List<Category> categories,
      @JsonKey(name: 'packaging_types')
      required final List<PackagingType> packagingTypes,
      required final List<UnitDetail> units,
      @JsonKey(name: 'product_types')
      required final List<ProductType> productTypes})
      : _brands = brands,
        _categories = categories,
        _packagingTypes = packagingTypes,
        _units = units,
        _productTypes = productTypes,
        super._();
  factory _ProductMaker.fromJson(Map<String, dynamic> json) =>
      _$ProductMakerFromJson(json);

  final List<Brand> _brands;
  @override
  List<Brand> get brands {
    if (_brands is EqualUnmodifiableListView) return _brands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brands);
  }

  final List<Category> _categories;
  @override
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<PackagingType> _packagingTypes;
  @override
  @JsonKey(name: 'packaging_types')
  List<PackagingType> get packagingTypes {
    if (_packagingTypes is EqualUnmodifiableListView) return _packagingTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packagingTypes);
  }

  final List<UnitDetail> _units;
  @override
  List<UnitDetail> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

// NEW: product types
  final List<ProductType> _productTypes;
// NEW: product types
  @override
  @JsonKey(name: 'product_types')
  List<ProductType> get productTypes {
    if (_productTypes is EqualUnmodifiableListView) return _productTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productTypes);
  }

  /// Create a copy of ProductMaker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductMakerCopyWith<_ProductMaker> get copyWith =>
      __$ProductMakerCopyWithImpl<_ProductMaker>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProductMakerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductMaker &&
            const DeepCollectionEquality().equals(other._brands, _brands) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._packagingTypes, _packagingTypes) &&
            const DeepCollectionEquality().equals(other._units, _units) &&
            const DeepCollectionEquality()
                .equals(other._productTypes, _productTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_brands),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_packagingTypes),
      const DeepCollectionEquality().hash(_units),
      const DeepCollectionEquality().hash(_productTypes));

  @override
  String toString() {
    return 'ProductMaker(brands: $brands, categories: $categories, packagingTypes: $packagingTypes, units: $units, productTypes: $productTypes)';
  }
}

/// @nodoc
abstract mixin class _$ProductMakerCopyWith<$Res>
    implements $ProductMakerCopyWith<$Res> {
  factory _$ProductMakerCopyWith(
          _ProductMaker value, $Res Function(_ProductMaker) _then) =
      __$ProductMakerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Brand> brands,
      List<Category> categories,
      @JsonKey(name: 'packaging_types') List<PackagingType> packagingTypes,
      List<UnitDetail> units,
      @JsonKey(name: 'product_types') List<ProductType> productTypes});
}

/// @nodoc
class __$ProductMakerCopyWithImpl<$Res>
    implements _$ProductMakerCopyWith<$Res> {
  __$ProductMakerCopyWithImpl(this._self, this._then);

  final _ProductMaker _self;
  final $Res Function(_ProductMaker) _then;

  /// Create a copy of ProductMaker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? brands = null,
    Object? categories = null,
    Object? packagingTypes = null,
    Object? units = null,
    Object? productTypes = null,
  }) {
    return _then(_ProductMaker(
      brands: null == brands
          ? _self._brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<Brand>,
      categories: null == categories
          ? _self._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      packagingTypes: null == packagingTypes
          ? _self._packagingTypes
          : packagingTypes // ignore: cast_nullable_to_non_nullable
              as List<PackagingType>,
      units: null == units
          ? _self._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<UnitDetail>,
      productTypes: null == productTypes
          ? _self._productTypes
          : productTypes // ignore: cast_nullable_to_non_nullable
              as List<ProductType>,
    ));
  }
}

// dart format on
