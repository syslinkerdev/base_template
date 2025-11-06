// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discount_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Discount {
  String get id;
  @JsonKey(
      name: 'product_reference',
      fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
      toJson: DocumentReferenceJsonConverter.toJsonNullable)
  DocumentReference? get productReference;
  @JsonKey(name: 'product_key')
  String get productKey;
  double get discount;
  @JsonKey(
      name: 'status',
      fromJson: ProductStatusConverter.fromJson,
      toJson: ProductStatusConverter.toJson)
  ProductStatus get status;
  @JsonKey(includeToJson: false)
  double get maxAllowedDiscount;

  /// Create a copy of Discount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiscountCopyWith<Discount> get copyWith =>
      _$DiscountCopyWithImpl<Discount>(this as Discount, _$identity);

  /// Serializes this Discount to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Discount &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productReference, productReference) ||
                other.productReference == productReference) &&
            (identical(other.productKey, productKey) ||
                other.productKey == productKey) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.maxAllowedDiscount, maxAllowedDiscount) ||
                other.maxAllowedDiscount == maxAllowedDiscount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, productReference, productKey,
      discount, status, maxAllowedDiscount);

  @override
  String toString() {
    return 'Discount(id: $id, productReference: $productReference, productKey: $productKey, discount: $discount, status: $status, maxAllowedDiscount: $maxAllowedDiscount)';
  }
}

/// @nodoc
abstract mixin class $DiscountCopyWith<$Res> {
  factory $DiscountCopyWith(Discount value, $Res Function(Discount) _then) =
      _$DiscountCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(
          name: 'product_reference',
          fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
          toJson: DocumentReferenceJsonConverter.toJsonNullable)
      DocumentReference? productReference,
      @JsonKey(name: 'product_key') String productKey,
      double discount,
      @JsonKey(
          name: 'status',
          fromJson: ProductStatusConverter.fromJson,
          toJson: ProductStatusConverter.toJson)
      ProductStatus status,
      @JsonKey(includeToJson: false) double maxAllowedDiscount});
}

/// @nodoc
class _$DiscountCopyWithImpl<$Res> implements $DiscountCopyWith<$Res> {
  _$DiscountCopyWithImpl(this._self, this._then);

  final Discount _self;
  final $Res Function(Discount) _then;

  /// Create a copy of Discount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productReference = freezed,
    Object? productKey = null,
    Object? discount = null,
    Object? status = null,
    Object? maxAllowedDiscount = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productReference: freezed == productReference
          ? _self.productReference
          : productReference // ignore: cast_nullable_to_non_nullable
              as DocumentReference?,
      productKey: null == productKey
          ? _self.productKey
          : productKey // ignore: cast_nullable_to_non_nullable
              as String,
      discount: null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductStatus,
      maxAllowedDiscount: null == maxAllowedDiscount
          ? _self.maxAllowedDiscount
          : maxAllowedDiscount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// Adds pattern-matching-related methods to [Discount].
extension DiscountPatterns on Discount {
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
    TResult Function(_Discount value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Discount() when $default != null:
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
    TResult Function(_Discount value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Discount():
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
    TResult? Function(_Discount value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Discount() when $default != null:
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
            String id,
            @JsonKey(
                name: 'product_reference',
                fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
                toJson: DocumentReferenceJsonConverter.toJsonNullable)
            DocumentReference? productReference,
            @JsonKey(name: 'product_key') String productKey,
            double discount,
            @JsonKey(
                name: 'status',
                fromJson: ProductStatusConverter.fromJson,
                toJson: ProductStatusConverter.toJson)
            ProductStatus status,
            @JsonKey(includeToJson: false) double maxAllowedDiscount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Discount() when $default != null:
        return $default(_that.id, _that.productReference, _that.productKey,
            _that.discount, _that.status, _that.maxAllowedDiscount);
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
            String id,
            @JsonKey(
                name: 'product_reference',
                fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
                toJson: DocumentReferenceJsonConverter.toJsonNullable)
            DocumentReference? productReference,
            @JsonKey(name: 'product_key') String productKey,
            double discount,
            @JsonKey(
                name: 'status',
                fromJson: ProductStatusConverter.fromJson,
                toJson: ProductStatusConverter.toJson)
            ProductStatus status,
            @JsonKey(includeToJson: false) double maxAllowedDiscount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Discount():
        return $default(_that.id, _that.productReference, _that.productKey,
            _that.discount, _that.status, _that.maxAllowedDiscount);
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
            String id,
            @JsonKey(
                name: 'product_reference',
                fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
                toJson: DocumentReferenceJsonConverter.toJsonNullable)
            DocumentReference? productReference,
            @JsonKey(name: 'product_key') String productKey,
            double discount,
            @JsonKey(
                name: 'status',
                fromJson: ProductStatusConverter.fromJson,
                toJson: ProductStatusConverter.toJson)
            ProductStatus status,
            @JsonKey(includeToJson: false) double maxAllowedDiscount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Discount() when $default != null:
        return $default(_that.id, _that.productReference, _that.productKey,
            _that.discount, _that.status, _that.maxAllowedDiscount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Discount extends Discount {
  _Discount(
      {required this.id,
      @JsonKey(
          name: 'product_reference',
          fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
          toJson: DocumentReferenceJsonConverter.toJsonNullable)
      this.productReference,
      @JsonKey(name: 'product_key') required this.productKey,
      required this.discount,
      @JsonKey(
          name: 'status',
          fromJson: ProductStatusConverter.fromJson,
          toJson: ProductStatusConverter.toJson)
      this.status = ProductStatus.draft,
      @JsonKey(includeToJson: false) this.maxAllowedDiscount = 0.0})
      : super._();
  factory _Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(
      name: 'product_reference',
      fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
      toJson: DocumentReferenceJsonConverter.toJsonNullable)
  final DocumentReference? productReference;
  @override
  @JsonKey(name: 'product_key')
  final String productKey;
  @override
  final double discount;
  @override
  @JsonKey(
      name: 'status',
      fromJson: ProductStatusConverter.fromJson,
      toJson: ProductStatusConverter.toJson)
  final ProductStatus status;
  @override
  @JsonKey(includeToJson: false)
  final double maxAllowedDiscount;

  /// Create a copy of Discount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DiscountCopyWith<_Discount> get copyWith =>
      __$DiscountCopyWithImpl<_Discount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DiscountToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Discount &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productReference, productReference) ||
                other.productReference == productReference) &&
            (identical(other.productKey, productKey) ||
                other.productKey == productKey) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.maxAllowedDiscount, maxAllowedDiscount) ||
                other.maxAllowedDiscount == maxAllowedDiscount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, productReference, productKey,
      discount, status, maxAllowedDiscount);

  @override
  String toString() {
    return 'Discount(id: $id, productReference: $productReference, productKey: $productKey, discount: $discount, status: $status, maxAllowedDiscount: $maxAllowedDiscount)';
  }
}

/// @nodoc
abstract mixin class _$DiscountCopyWith<$Res>
    implements $DiscountCopyWith<$Res> {
  factory _$DiscountCopyWith(_Discount value, $Res Function(_Discount) _then) =
      __$DiscountCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(
          name: 'product_reference',
          fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
          toJson: DocumentReferenceJsonConverter.toJsonNullable)
      DocumentReference? productReference,
      @JsonKey(name: 'product_key') String productKey,
      double discount,
      @JsonKey(
          name: 'status',
          fromJson: ProductStatusConverter.fromJson,
          toJson: ProductStatusConverter.toJson)
      ProductStatus status,
      @JsonKey(includeToJson: false) double maxAllowedDiscount});
}

/// @nodoc
class __$DiscountCopyWithImpl<$Res> implements _$DiscountCopyWith<$Res> {
  __$DiscountCopyWithImpl(this._self, this._then);

  final _Discount _self;
  final $Res Function(_Discount) _then;

  /// Create a copy of Discount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? productReference = freezed,
    Object? productKey = null,
    Object? discount = null,
    Object? status = null,
    Object? maxAllowedDiscount = null,
  }) {
    return _then(_Discount(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productReference: freezed == productReference
          ? _self.productReference
          : productReference // ignore: cast_nullable_to_non_nullable
              as DocumentReference?,
      productKey: null == productKey
          ? _self.productKey
          : productKey // ignore: cast_nullable_to_non_nullable
              as String,
      discount: null == discount
          ? _self.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductStatus,
      maxAllowedDiscount: null == maxAllowedDiscount
          ? _self.maxAllowedDiscount
          : maxAllowedDiscount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
