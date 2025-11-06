// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_manager_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductsManagerState {
  List<Product> get products;
  List<Product> get filteredProducts;

  /// Create a copy of ProductsManagerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProductsManagerStateCopyWith<ProductsManagerState> get copyWith =>
      _$ProductsManagerStateCopyWithImpl<ProductsManagerState>(
          this as ProductsManagerState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProductsManagerState &&
            const DeepCollectionEquality().equals(other.products, products) &&
            const DeepCollectionEquality()
                .equals(other.filteredProducts, filteredProducts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(products),
      const DeepCollectionEquality().hash(filteredProducts));

  @override
  String toString() {
    return 'ProductsManagerState(products: $products, filteredProducts: $filteredProducts)';
  }
}

/// @nodoc
abstract mixin class $ProductsManagerStateCopyWith<$Res> {
  factory $ProductsManagerStateCopyWith(ProductsManagerState value,
          $Res Function(ProductsManagerState) _then) =
      _$ProductsManagerStateCopyWithImpl;
  @useResult
  $Res call({List<Product> products, List<Product> filteredProducts});
}

/// @nodoc
class _$ProductsManagerStateCopyWithImpl<$Res>
    implements $ProductsManagerStateCopyWith<$Res> {
  _$ProductsManagerStateCopyWithImpl(this._self, this._then);

  final ProductsManagerState _self;
  final $Res Function(ProductsManagerState) _then;

  /// Create a copy of ProductsManagerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? filteredProducts = null,
  }) {
    return _then(_self.copyWith(
      products: null == products
          ? _self.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      filteredProducts: null == filteredProducts
          ? _self.filteredProducts
          : filteredProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProductsManagerState].
extension ProductsManagerStatePatterns on ProductsManagerState {
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
    TResult Function(_ProductsManagerState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductsManagerState() when $default != null:
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
    TResult Function(_ProductsManagerState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductsManagerState():
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
    TResult? Function(_ProductsManagerState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductsManagerState() when $default != null:
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
    TResult Function(List<Product> products, List<Product> filteredProducts)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProductsManagerState() when $default != null:
        return $default(_that.products, _that.filteredProducts);
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
    TResult Function(List<Product> products, List<Product> filteredProducts)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductsManagerState():
        return $default(_that.products, _that.filteredProducts);
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
    TResult? Function(List<Product> products, List<Product> filteredProducts)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProductsManagerState() when $default != null:
        return $default(_that.products, _that.filteredProducts);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ProductsManagerState implements ProductsManagerState {
  const _ProductsManagerState(
      {required final List<Product> products,
      required final List<Product> filteredProducts})
      : _products = products,
        _filteredProducts = filteredProducts;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<Product> _filteredProducts;
  @override
  List<Product> get filteredProducts {
    if (_filteredProducts is EqualUnmodifiableListView)
      return _filteredProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredProducts);
  }

  /// Create a copy of ProductsManagerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProductsManagerStateCopyWith<_ProductsManagerState> get copyWith =>
      __$ProductsManagerStateCopyWithImpl<_ProductsManagerState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProductsManagerState &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._filteredProducts, _filteredProducts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_filteredProducts));

  @override
  String toString() {
    return 'ProductsManagerState(products: $products, filteredProducts: $filteredProducts)';
  }
}

/// @nodoc
abstract mixin class _$ProductsManagerStateCopyWith<$Res>
    implements $ProductsManagerStateCopyWith<$Res> {
  factory _$ProductsManagerStateCopyWith(_ProductsManagerState value,
          $Res Function(_ProductsManagerState) _then) =
      __$ProductsManagerStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<Product> products, List<Product> filteredProducts});
}

/// @nodoc
class __$ProductsManagerStateCopyWithImpl<$Res>
    implements _$ProductsManagerStateCopyWith<$Res> {
  __$ProductsManagerStateCopyWithImpl(this._self, this._then);

  final _ProductsManagerState _self;
  final $Res Function(_ProductsManagerState) _then;

  /// Create a copy of ProductsManagerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? products = null,
    Object? filteredProducts = null,
  }) {
    return _then(_ProductsManagerState(
      products: null == products
          ? _self._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      filteredProducts: null == filteredProducts
          ? _self._filteredProducts
          : filteredProducts // ignore: cast_nullable_to_non_nullable
              as List<Product>,
    ));
  }
}

// dart format on
