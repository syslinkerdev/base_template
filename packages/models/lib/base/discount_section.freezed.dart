// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discount_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiscountSection {
  String get id;
  String get name;
  @JsonKey(name: 'product_discounts')
  Map<String, Discount> get productDiscounts;
  @JsonKey(
      name: 'status',
      fromJson: DiscountSectionStatusConverter.fromJson,
      toJson: DiscountSectionStatusConverter.toJson)
  DiscountSectionStatus get status;
  @JsonKey(name: 'meta')
  MetaDataX? get meta;

  /// Create a copy of DiscountSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiscountSectionCopyWith<DiscountSection> get copyWith =>
      _$DiscountSectionCopyWithImpl<DiscountSection>(
          this as DiscountSection, _$identity);

  /// Serializes this DiscountSection to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiscountSection &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.productDiscounts, productDiscounts) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(productDiscounts), status, meta);

  @override
  String toString() {
    return 'DiscountSection(id: $id, name: $name, productDiscounts: $productDiscounts, status: $status, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $DiscountSectionCopyWith<$Res> {
  factory $DiscountSectionCopyWith(
          DiscountSection value, $Res Function(DiscountSection) _then) =
      _$DiscountSectionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'product_discounts')
      Map<String, Discount> productDiscounts,
      @JsonKey(
          name: 'status',
          fromJson: DiscountSectionStatusConverter.fromJson,
          toJson: DiscountSectionStatusConverter.toJson)
      DiscountSectionStatus status,
      @JsonKey(name: 'meta') MetaDataX? meta});

  $MetaDataXCopyWith<$Res>? get meta;
}

/// @nodoc
class _$DiscountSectionCopyWithImpl<$Res>
    implements $DiscountSectionCopyWith<$Res> {
  _$DiscountSectionCopyWithImpl(this._self, this._then);

  final DiscountSection _self;
  final $Res Function(DiscountSection) _then;

  /// Create a copy of DiscountSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? productDiscounts = null,
    Object? status = null,
    Object? meta = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      productDiscounts: null == productDiscounts
          ? _self.productDiscounts
          : productDiscounts // ignore: cast_nullable_to_non_nullable
              as Map<String, Discount>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as DiscountSectionStatus,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as MetaDataX?,
    ));
  }

  /// Create a copy of DiscountSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetaDataXCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $MetaDataXCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DiscountSection].
extension DiscountSectionPatterns on DiscountSection {
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
    TResult Function(_DiscountSection value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiscountSection() when $default != null:
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
    TResult Function(_DiscountSection value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscountSection():
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
    TResult? Function(_DiscountSection value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscountSection() when $default != null:
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
            String name,
            @JsonKey(name: 'product_discounts')
            Map<String, Discount> productDiscounts,
            @JsonKey(
                name: 'status',
                fromJson: DiscountSectionStatusConverter.fromJson,
                toJson: DiscountSectionStatusConverter.toJson)
            DiscountSectionStatus status,
            @JsonKey(name: 'meta') MetaDataX? meta)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiscountSection() when $default != null:
        return $default(_that.id, _that.name, _that.productDiscounts,
            _that.status, _that.meta);
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
            String name,
            @JsonKey(name: 'product_discounts')
            Map<String, Discount> productDiscounts,
            @JsonKey(
                name: 'status',
                fromJson: DiscountSectionStatusConverter.fromJson,
                toJson: DiscountSectionStatusConverter.toJson)
            DiscountSectionStatus status,
            @JsonKey(name: 'meta') MetaDataX? meta)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscountSection():
        return $default(_that.id, _that.name, _that.productDiscounts,
            _that.status, _that.meta);
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
            String name,
            @JsonKey(name: 'product_discounts')
            Map<String, Discount> productDiscounts,
            @JsonKey(
                name: 'status',
                fromJson: DiscountSectionStatusConverter.fromJson,
                toJson: DiscountSectionStatusConverter.toJson)
            DiscountSectionStatus status,
            @JsonKey(name: 'meta') MetaDataX? meta)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscountSection() when $default != null:
        return $default(_that.id, _that.name, _that.productDiscounts,
            _that.status, _that.meta);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DiscountSection extends DiscountSection {
  _DiscountSection(
      {required this.id,
      required this.name,
      @JsonKey(name: 'product_discounts')
      final Map<String, Discount> productDiscounts = const <String, Discount>{},
      @JsonKey(
          name: 'status',
          fromJson: DiscountSectionStatusConverter.fromJson,
          toJson: DiscountSectionStatusConverter.toJson)
      this.status = DiscountSectionStatus.custom,
      @JsonKey(name: 'meta') this.meta})
      : _productDiscounts = productDiscounts,
        super._();
  factory _DiscountSection.fromJson(Map<String, dynamic> json) =>
      _$DiscountSectionFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final Map<String, Discount> _productDiscounts;
  @override
  @JsonKey(name: 'product_discounts')
  Map<String, Discount> get productDiscounts {
    if (_productDiscounts is EqualUnmodifiableMapView) return _productDiscounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_productDiscounts);
  }

  @override
  @JsonKey(
      name: 'status',
      fromJson: DiscountSectionStatusConverter.fromJson,
      toJson: DiscountSectionStatusConverter.toJson)
  final DiscountSectionStatus status;
  @override
  @JsonKey(name: 'meta')
  final MetaDataX? meta;

  /// Create a copy of DiscountSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DiscountSectionCopyWith<_DiscountSection> get copyWith =>
      __$DiscountSectionCopyWithImpl<_DiscountSection>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DiscountSectionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DiscountSection &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._productDiscounts, _productDiscounts) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(_productDiscounts), status, meta);

  @override
  String toString() {
    return 'DiscountSection(id: $id, name: $name, productDiscounts: $productDiscounts, status: $status, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class _$DiscountSectionCopyWith<$Res>
    implements $DiscountSectionCopyWith<$Res> {
  factory _$DiscountSectionCopyWith(
          _DiscountSection value, $Res Function(_DiscountSection) _then) =
      __$DiscountSectionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'product_discounts')
      Map<String, Discount> productDiscounts,
      @JsonKey(
          name: 'status',
          fromJson: DiscountSectionStatusConverter.fromJson,
          toJson: DiscountSectionStatusConverter.toJson)
      DiscountSectionStatus status,
      @JsonKey(name: 'meta') MetaDataX? meta});

  @override
  $MetaDataXCopyWith<$Res>? get meta;
}

/// @nodoc
class __$DiscountSectionCopyWithImpl<$Res>
    implements _$DiscountSectionCopyWith<$Res> {
  __$DiscountSectionCopyWithImpl(this._self, this._then);

  final _DiscountSection _self;
  final $Res Function(_DiscountSection) _then;

  /// Create a copy of DiscountSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? productDiscounts = null,
    Object? status = null,
    Object? meta = freezed,
  }) {
    return _then(_DiscountSection(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      productDiscounts: null == productDiscounts
          ? _self._productDiscounts
          : productDiscounts // ignore: cast_nullable_to_non_nullable
              as Map<String, Discount>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as DiscountSectionStatus,
      meta: freezed == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as MetaDataX?,
    ));
  }

  /// Create a copy of DiscountSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetaDataXCopyWith<$Res>? get meta {
    if (_self.meta == null) {
      return null;
    }

    return $MetaDataXCopyWith<$Res>(_self.meta!, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

// dart format on
