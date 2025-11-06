// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartItem {
  @JsonKey(
      name: 'product_reference',
      fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
      toJson: DocumentReferenceJsonConverter.toJsonNullable)
  DocumentReference? get productReference; // Original client order
  @JsonKey(name: 'orig_qty')
  int get origQty;
  @JsonKey(name: 'orig_label')
  String? get origLabel; // Admin adjustments
  @JsonKey(name: 'adj_qty')
  int? get adjQty;
  @JsonKey(name: 'adj_label')
  String? get adjLabel; // Other product metadata
  @JsonKey(name: 'product_name')
  String? get productName;
  @JsonKey(name: 'search_key')
  String? get searchKey;
  @JsonKey(name: 'unit_price')
  double? get unitPrice;
  @JsonKey(name: 'unit_label')
  String? get unitLabel;
  @JsonKey(name: 'discount')
  double get discount;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CartItemCopyWith<CartItem> get copyWith =>
      _$CartItemCopyWithImpl<CartItem>(this as CartItem, _$identity);

  /// Serializes this CartItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CartItem &&
            (identical(other.productReference, productReference) ||
                other.productReference == productReference) &&
            (identical(other.origQty, origQty) || other.origQty == origQty) &&
            (identical(other.origLabel, origLabel) ||
                other.origLabel == origLabel) &&
            (identical(other.adjQty, adjQty) || other.adjQty == adjQty) &&
            (identical(other.adjLabel, adjLabel) ||
                other.adjLabel == adjLabel) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.unitLabel, unitLabel) ||
                other.unitLabel == unitLabel) &&
            (identical(other.discount, discount) ||
                other.discount == discount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productReference,
      origQty,
      origLabel,
      adjQty,
      adjLabel,
      productName,
      searchKey,
      unitPrice,
      unitLabel,
      discount);

  @override
  String toString() {
    return 'CartItem(productReference: $productReference, origQty: $origQty, origLabel: $origLabel, adjQty: $adjQty, adjLabel: $adjLabel, productName: $productName, searchKey: $searchKey, unitPrice: $unitPrice, unitLabel: $unitLabel, discount: $discount)';
  }
}

/// @nodoc
abstract mixin class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) _then) =
      _$CartItemCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(
          name: 'product_reference',
          fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
          toJson: DocumentReferenceJsonConverter.toJsonNullable)
      DocumentReference? productReference,
      @JsonKey(name: 'orig_qty') int origQty,
      @JsonKey(name: 'orig_label') String? origLabel,
      @JsonKey(name: 'adj_qty') int? adjQty,
      @JsonKey(name: 'adj_label') String? adjLabel,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'search_key') String? searchKey,
      @JsonKey(name: 'unit_price') double? unitPrice,
      @JsonKey(name: 'unit_label') String? unitLabel,
      @JsonKey(name: 'discount') double discount});
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res> implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._self, this._then);

  final CartItem _self;
  final $Res Function(CartItem) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productReference = freezed,
    Object? origQty = null,
    Object? origLabel = freezed,
    Object? adjQty = freezed,
    Object? adjLabel = freezed,
    Object? productName = freezed,
    Object? searchKey = freezed,
    Object? unitPrice = freezed,
    Object? unitLabel = freezed,
    Object? discount = null,
  }) {
    return _then(_self.copyWith(
      productReference: freezed == productReference
          ? _self.productReference
          : productReference // ignore: cast_nullable_to_non_nullable
              as DocumentReference?,
      origQty: null == origQty
          ? _self.origQty
          : origQty // ignore: cast_nullable_to_non_nullable
              as int,
      origLabel: freezed == origLabel
          ? _self.origLabel
          : origLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      adjQty: freezed == adjQty
          ? _self.adjQty
          : adjQty // ignore: cast_nullable_to_non_nullable
              as int?,
      adjLabel: freezed == adjLabel
          ? _self.adjLabel
          : adjLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: freezed == productName
          ? _self.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      searchKey: freezed == searchKey
          ? _self.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String?,
      unitPrice: freezed == unitPrice
          ? _self.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      unitLabel: freezed == unitLabel
          ? _self.unitLabel
          : unitLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [CartItem].
extension CartItemPatterns on CartItem {
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
    TResult Function(_CartItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CartItem() when $default != null:
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
    TResult Function(_CartItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CartItem():
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
    TResult? Function(_CartItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CartItem() when $default != null:
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
            @JsonKey(
                name: 'product_reference',
                fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
                toJson: DocumentReferenceJsonConverter.toJsonNullable)
            DocumentReference? productReference,
            @JsonKey(name: 'orig_qty') int origQty,
            @JsonKey(name: 'orig_label') String? origLabel,
            @JsonKey(name: 'adj_qty') int? adjQty,
            @JsonKey(name: 'adj_label') String? adjLabel,
            @JsonKey(name: 'product_name') String? productName,
            @JsonKey(name: 'search_key') String? searchKey,
            @JsonKey(name: 'unit_price') double? unitPrice,
            @JsonKey(name: 'unit_label') String? unitLabel,
            @JsonKey(name: 'discount') double discount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CartItem() when $default != null:
        return $default(
            _that.productReference,
            _that.origQty,
            _that.origLabel,
            _that.adjQty,
            _that.adjLabel,
            _that.productName,
            _that.searchKey,
            _that.unitPrice,
            _that.unitLabel,
            _that.discount);
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
            @JsonKey(
                name: 'product_reference',
                fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
                toJson: DocumentReferenceJsonConverter.toJsonNullable)
            DocumentReference? productReference,
            @JsonKey(name: 'orig_qty') int origQty,
            @JsonKey(name: 'orig_label') String? origLabel,
            @JsonKey(name: 'adj_qty') int? adjQty,
            @JsonKey(name: 'adj_label') String? adjLabel,
            @JsonKey(name: 'product_name') String? productName,
            @JsonKey(name: 'search_key') String? searchKey,
            @JsonKey(name: 'unit_price') double? unitPrice,
            @JsonKey(name: 'unit_label') String? unitLabel,
            @JsonKey(name: 'discount') double discount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CartItem():
        return $default(
            _that.productReference,
            _that.origQty,
            _that.origLabel,
            _that.adjQty,
            _that.adjLabel,
            _that.productName,
            _that.searchKey,
            _that.unitPrice,
            _that.unitLabel,
            _that.discount);
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
            @JsonKey(
                name: 'product_reference',
                fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
                toJson: DocumentReferenceJsonConverter.toJsonNullable)
            DocumentReference? productReference,
            @JsonKey(name: 'orig_qty') int origQty,
            @JsonKey(name: 'orig_label') String? origLabel,
            @JsonKey(name: 'adj_qty') int? adjQty,
            @JsonKey(name: 'adj_label') String? adjLabel,
            @JsonKey(name: 'product_name') String? productName,
            @JsonKey(name: 'search_key') String? searchKey,
            @JsonKey(name: 'unit_price') double? unitPrice,
            @JsonKey(name: 'unit_label') String? unitLabel,
            @JsonKey(name: 'discount') double discount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CartItem() when $default != null:
        return $default(
            _that.productReference,
            _that.origQty,
            _that.origLabel,
            _that.adjQty,
            _that.adjLabel,
            _that.productName,
            _that.searchKey,
            _that.unitPrice,
            _that.unitLabel,
            _that.discount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CartItem extends CartItem {
  _CartItem(
      {@JsonKey(
          name: 'product_reference',
          fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
          toJson: DocumentReferenceJsonConverter.toJsonNullable)
      this.productReference,
      @JsonKey(name: 'orig_qty') required this.origQty,
      @JsonKey(name: 'orig_label') this.origLabel,
      @JsonKey(name: 'adj_qty') this.adjQty,
      @JsonKey(name: 'adj_label') this.adjLabel,
      @JsonKey(name: 'product_name') this.productName,
      @JsonKey(name: 'search_key') this.searchKey,
      @JsonKey(name: 'unit_price') this.unitPrice,
      @JsonKey(name: 'unit_label') this.unitLabel,
      @JsonKey(name: 'discount') this.discount = 0.0})
      : super._();
  factory _CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  @override
  @JsonKey(
      name: 'product_reference',
      fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
      toJson: DocumentReferenceJsonConverter.toJsonNullable)
  final DocumentReference? productReference;
// Original client order
  @override
  @JsonKey(name: 'orig_qty')
  final int origQty;
  @override
  @JsonKey(name: 'orig_label')
  final String? origLabel;
// Admin adjustments
  @override
  @JsonKey(name: 'adj_qty')
  final int? adjQty;
  @override
  @JsonKey(name: 'adj_label')
  final String? adjLabel;
// Other product metadata
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  @JsonKey(name: 'search_key')
  final String? searchKey;
  @override
  @JsonKey(name: 'unit_price')
  final double? unitPrice;
  @override
  @JsonKey(name: 'unit_label')
  final String? unitLabel;
  @override
  @JsonKey(name: 'discount')
  final double discount;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CartItemCopyWith<_CartItem> get copyWith =>
      __$CartItemCopyWithImpl<_CartItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CartItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CartItem &&
            (identical(other.productReference, productReference) ||
                other.productReference == productReference) &&
            (identical(other.origQty, origQty) || other.origQty == origQty) &&
            (identical(other.origLabel, origLabel) ||
                other.origLabel == origLabel) &&
            (identical(other.adjQty, adjQty) || other.adjQty == adjQty) &&
            (identical(other.adjLabel, adjLabel) ||
                other.adjLabel == adjLabel) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.searchKey, searchKey) ||
                other.searchKey == searchKey) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.unitLabel, unitLabel) ||
                other.unitLabel == unitLabel) &&
            (identical(other.discount, discount) ||
                other.discount == discount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productReference,
      origQty,
      origLabel,
      adjQty,
      adjLabel,
      productName,
      searchKey,
      unitPrice,
      unitLabel,
      discount);

  @override
  String toString() {
    return 'CartItem(productReference: $productReference, origQty: $origQty, origLabel: $origLabel, adjQty: $adjQty, adjLabel: $adjLabel, productName: $productName, searchKey: $searchKey, unitPrice: $unitPrice, unitLabel: $unitLabel, discount: $discount)';
  }
}

/// @nodoc
abstract mixin class _$CartItemCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$CartItemCopyWith(_CartItem value, $Res Function(_CartItem) _then) =
      __$CartItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          name: 'product_reference',
          fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
          toJson: DocumentReferenceJsonConverter.toJsonNullable)
      DocumentReference? productReference,
      @JsonKey(name: 'orig_qty') int origQty,
      @JsonKey(name: 'orig_label') String? origLabel,
      @JsonKey(name: 'adj_qty') int? adjQty,
      @JsonKey(name: 'adj_label') String? adjLabel,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'search_key') String? searchKey,
      @JsonKey(name: 'unit_price') double? unitPrice,
      @JsonKey(name: 'unit_label') String? unitLabel,
      @JsonKey(name: 'discount') double discount});
}

/// @nodoc
class __$CartItemCopyWithImpl<$Res> implements _$CartItemCopyWith<$Res> {
  __$CartItemCopyWithImpl(this._self, this._then);

  final _CartItem _self;
  final $Res Function(_CartItem) _then;

  /// Create a copy of CartItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? productReference = freezed,
    Object? origQty = null,
    Object? origLabel = freezed,
    Object? adjQty = freezed,
    Object? adjLabel = freezed,
    Object? productName = freezed,
    Object? searchKey = freezed,
    Object? unitPrice = freezed,
    Object? unitLabel = freezed,
    Object? discount = null,
  }) {
    return _then(_CartItem(
      productReference: freezed == productReference
          ? _self.productReference
          : productReference // ignore: cast_nullable_to_non_nullable
              as DocumentReference?,
      origQty: null == origQty
          ? _self.origQty
          : origQty // ignore: cast_nullable_to_non_nullable
              as int,
      origLabel: freezed == origLabel
          ? _self.origLabel
          : origLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      adjQty: freezed == adjQty
          ? _self.adjQty
          : adjQty // ignore: cast_nullable_to_non_nullable
              as int?,
      adjLabel: freezed == adjLabel
          ? _self.adjLabel
          : adjLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: freezed == productName
          ? _self.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      searchKey: freezed == searchKey
          ? _self.searchKey
          : searchKey // ignore: cast_nullable_to_non_nullable
              as String?,
      unitPrice: freezed == unitPrice
          ? _self.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      unitLabel: freezed == unitLabel
          ? _self.unitLabel
          : unitLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      discount: null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
