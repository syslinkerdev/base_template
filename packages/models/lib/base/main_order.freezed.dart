// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MainOrder {
  @JsonKey(name: 'main_order_id')
  String get mainOrderId; // 📅 Delivery date
  @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
  DateTime get deliveryDate;
  List<CompanyEntry> get companies; // smaller keys
  @JsonKey(name: 'overall_total')
  double get overallTotal;
  @JsonKey(name: 'overall_total_after_dis')
  double get overallTotalAfterDis;
  @JsonKey(name: 'service_charges')
  double get serviceCharges; // extra fields
  @JsonKey(name: 'no_of_products')
  int get noOfProducts;
  @JsonKey(name: 'no_of_clients')
  int get noOfClients;
  @JsonKey(name: 'generated_by')
  String get generatedBy;
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  DateTime get createdAt;

  /// Create a copy of MainOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MainOrderCopyWith<MainOrder> get copyWith =>
      _$MainOrderCopyWithImpl<MainOrder>(this as MainOrder, _$identity);

  /// Serializes this MainOrder to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MainOrder &&
            (identical(other.mainOrderId, mainOrderId) ||
                other.mainOrderId == mainOrderId) &&
            (identical(other.deliveryDate, deliveryDate) ||
                other.deliveryDate == deliveryDate) &&
            const DeepCollectionEquality().equals(other.companies, companies) &&
            (identical(other.overallTotal, overallTotal) ||
                other.overallTotal == overallTotal) &&
            (identical(other.overallTotalAfterDis, overallTotalAfterDis) ||
                other.overallTotalAfterDis == overallTotalAfterDis) &&
            (identical(other.serviceCharges, serviceCharges) ||
                other.serviceCharges == serviceCharges) &&
            (identical(other.noOfProducts, noOfProducts) ||
                other.noOfProducts == noOfProducts) &&
            (identical(other.noOfClients, noOfClients) ||
                other.noOfClients == noOfClients) &&
            (identical(other.generatedBy, generatedBy) ||
                other.generatedBy == generatedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mainOrderId,
      deliveryDate,
      const DeepCollectionEquality().hash(companies),
      overallTotal,
      overallTotalAfterDis,
      serviceCharges,
      noOfProducts,
      noOfClients,
      generatedBy,
      createdAt);

  @override
  String toString() {
    return 'MainOrder(mainOrderId: $mainOrderId, deliveryDate: $deliveryDate, companies: $companies, overallTotal: $overallTotal, overallTotalAfterDis: $overallTotalAfterDis, serviceCharges: $serviceCharges, noOfProducts: $noOfProducts, noOfClients: $noOfClients, generatedBy: $generatedBy, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $MainOrderCopyWith<$Res> {
  factory $MainOrderCopyWith(MainOrder value, $Res Function(MainOrder) _then) =
      _$MainOrderCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'main_order_id') String mainOrderId,
      @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
      DateTime deliveryDate,
      List<CompanyEntry> companies,
      @JsonKey(name: 'overall_total') double overallTotal,
      @JsonKey(name: 'overall_total_after_dis') double overallTotalAfterDis,
      @JsonKey(name: 'service_charges') double serviceCharges,
      @JsonKey(name: 'no_of_products') int noOfProducts,
      @JsonKey(name: 'no_of_clients') int noOfClients,
      @JsonKey(name: 'generated_by') String generatedBy,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt});
}

/// @nodoc
class _$MainOrderCopyWithImpl<$Res> implements $MainOrderCopyWith<$Res> {
  _$MainOrderCopyWithImpl(this._self, this._then);

  final MainOrder _self;
  final $Res Function(MainOrder) _then;

  /// Create a copy of MainOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainOrderId = null,
    Object? deliveryDate = null,
    Object? companies = null,
    Object? overallTotal = null,
    Object? overallTotalAfterDis = null,
    Object? serviceCharges = null,
    Object? noOfProducts = null,
    Object? noOfClients = null,
    Object? generatedBy = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      mainOrderId: null == mainOrderId
          ? _self.mainOrderId
          : mainOrderId // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryDate: null == deliveryDate
          ? _self.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      companies: null == companies
          ? _self.companies
          : companies // ignore: cast_nullable_to_non_nullable
              as List<CompanyEntry>,
      overallTotal: null == overallTotal
          ? _self.overallTotal
          : overallTotal // ignore: cast_nullable_to_non_nullable
              as double,
      overallTotalAfterDis: null == overallTotalAfterDis
          ? _self.overallTotalAfterDis
          : overallTotalAfterDis // ignore: cast_nullable_to_non_nullable
              as double,
      serviceCharges: null == serviceCharges
          ? _self.serviceCharges
          : serviceCharges // ignore: cast_nullable_to_non_nullable
              as double,
      noOfProducts: null == noOfProducts
          ? _self.noOfProducts
          : noOfProducts // ignore: cast_nullable_to_non_nullable
              as int,
      noOfClients: null == noOfClients
          ? _self.noOfClients
          : noOfClients // ignore: cast_nullable_to_non_nullable
              as int,
      generatedBy: null == generatedBy
          ? _self.generatedBy
          : generatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [MainOrder].
extension MainOrderPatterns on MainOrder {
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
    TResult Function(_MainOrder value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MainOrder() when $default != null:
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
    TResult Function(_MainOrder value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MainOrder():
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
    TResult? Function(_MainOrder value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MainOrder() when $default != null:
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
            @JsonKey(name: 'main_order_id') String mainOrderId,
            @JsonKey(
                name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
            DateTime deliveryDate,
            List<CompanyEntry> companies,
            @JsonKey(name: 'overall_total') double overallTotal,
            @JsonKey(name: 'overall_total_after_dis')
            double overallTotalAfterDis,
            @JsonKey(name: 'service_charges') double serviceCharges,
            @JsonKey(name: 'no_of_products') int noOfProducts,
            @JsonKey(name: 'no_of_clients') int noOfClients,
            @JsonKey(name: 'generated_by') String generatedBy,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MainOrder() when $default != null:
        return $default(
            _that.mainOrderId,
            _that.deliveryDate,
            _that.companies,
            _that.overallTotal,
            _that.overallTotalAfterDis,
            _that.serviceCharges,
            _that.noOfProducts,
            _that.noOfClients,
            _that.generatedBy,
            _that.createdAt);
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
            @JsonKey(name: 'main_order_id') String mainOrderId,
            @JsonKey(
                name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
            DateTime deliveryDate,
            List<CompanyEntry> companies,
            @JsonKey(name: 'overall_total') double overallTotal,
            @JsonKey(name: 'overall_total_after_dis')
            double overallTotalAfterDis,
            @JsonKey(name: 'service_charges') double serviceCharges,
            @JsonKey(name: 'no_of_products') int noOfProducts,
            @JsonKey(name: 'no_of_clients') int noOfClients,
            @JsonKey(name: 'generated_by') String generatedBy,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MainOrder():
        return $default(
            _that.mainOrderId,
            _that.deliveryDate,
            _that.companies,
            _that.overallTotal,
            _that.overallTotalAfterDis,
            _that.serviceCharges,
            _that.noOfProducts,
            _that.noOfClients,
            _that.generatedBy,
            _that.createdAt);
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
            @JsonKey(name: 'main_order_id') String mainOrderId,
            @JsonKey(
                name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
            DateTime deliveryDate,
            List<CompanyEntry> companies,
            @JsonKey(name: 'overall_total') double overallTotal,
            @JsonKey(name: 'overall_total_after_dis')
            double overallTotalAfterDis,
            @JsonKey(name: 'service_charges') double serviceCharges,
            @JsonKey(name: 'no_of_products') int noOfProducts,
            @JsonKey(name: 'no_of_clients') int noOfClients,
            @JsonKey(name: 'generated_by') String generatedBy,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MainOrder() when $default != null:
        return $default(
            _that.mainOrderId,
            _that.deliveryDate,
            _that.companies,
            _that.overallTotal,
            _that.overallTotalAfterDis,
            _that.serviceCharges,
            _that.noOfProducts,
            _that.noOfClients,
            _that.generatedBy,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MainOrder extends MainOrder {
  const _MainOrder(
      {@JsonKey(name: 'main_order_id') required this.mainOrderId,
      @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
      required this.deliveryDate,
      required final List<CompanyEntry> companies,
      @JsonKey(name: 'overall_total') required this.overallTotal,
      @JsonKey(name: 'overall_total_after_dis')
      required this.overallTotalAfterDis,
      @JsonKey(name: 'service_charges') required this.serviceCharges,
      @JsonKey(name: 'no_of_products') required this.noOfProducts,
      @JsonKey(name: 'no_of_clients') required this.noOfClients,
      @JsonKey(name: 'generated_by') required this.generatedBy,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      required this.createdAt})
      : _companies = companies,
        super._();
  factory _MainOrder.fromJson(Map<String, dynamic> json) =>
      _$MainOrderFromJson(json);

  @override
  @JsonKey(name: 'main_order_id')
  final String mainOrderId;
// 📅 Delivery date
  @override
  @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
  final DateTime deliveryDate;
  final List<CompanyEntry> _companies;
  @override
  List<CompanyEntry> get companies {
    if (_companies is EqualUnmodifiableListView) return _companies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_companies);
  }

// smaller keys
  @override
  @JsonKey(name: 'overall_total')
  final double overallTotal;
  @override
  @JsonKey(name: 'overall_total_after_dis')
  final double overallTotalAfterDis;
  @override
  @JsonKey(name: 'service_charges')
  final double serviceCharges;
// extra fields
  @override
  @JsonKey(name: 'no_of_products')
  final int noOfProducts;
  @override
  @JsonKey(name: 'no_of_clients')
  final int noOfClients;
  @override
  @JsonKey(name: 'generated_by')
  final String generatedBy;
  @override
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  final DateTime createdAt;

  /// Create a copy of MainOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MainOrderCopyWith<_MainOrder> get copyWith =>
      __$MainOrderCopyWithImpl<_MainOrder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MainOrderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MainOrder &&
            (identical(other.mainOrderId, mainOrderId) ||
                other.mainOrderId == mainOrderId) &&
            (identical(other.deliveryDate, deliveryDate) ||
                other.deliveryDate == deliveryDate) &&
            const DeepCollectionEquality()
                .equals(other._companies, _companies) &&
            (identical(other.overallTotal, overallTotal) ||
                other.overallTotal == overallTotal) &&
            (identical(other.overallTotalAfterDis, overallTotalAfterDis) ||
                other.overallTotalAfterDis == overallTotalAfterDis) &&
            (identical(other.serviceCharges, serviceCharges) ||
                other.serviceCharges == serviceCharges) &&
            (identical(other.noOfProducts, noOfProducts) ||
                other.noOfProducts == noOfProducts) &&
            (identical(other.noOfClients, noOfClients) ||
                other.noOfClients == noOfClients) &&
            (identical(other.generatedBy, generatedBy) ||
                other.generatedBy == generatedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mainOrderId,
      deliveryDate,
      const DeepCollectionEquality().hash(_companies),
      overallTotal,
      overallTotalAfterDis,
      serviceCharges,
      noOfProducts,
      noOfClients,
      generatedBy,
      createdAt);

  @override
  String toString() {
    return 'MainOrder(mainOrderId: $mainOrderId, deliveryDate: $deliveryDate, companies: $companies, overallTotal: $overallTotal, overallTotalAfterDis: $overallTotalAfterDis, serviceCharges: $serviceCharges, noOfProducts: $noOfProducts, noOfClients: $noOfClients, generatedBy: $generatedBy, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$MainOrderCopyWith<$Res>
    implements $MainOrderCopyWith<$Res> {
  factory _$MainOrderCopyWith(
          _MainOrder value, $Res Function(_MainOrder) _then) =
      __$MainOrderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'main_order_id') String mainOrderId,
      @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
      DateTime deliveryDate,
      List<CompanyEntry> companies,
      @JsonKey(name: 'overall_total') double overallTotal,
      @JsonKey(name: 'overall_total_after_dis') double overallTotalAfterDis,
      @JsonKey(name: 'service_charges') double serviceCharges,
      @JsonKey(name: 'no_of_products') int noOfProducts,
      @JsonKey(name: 'no_of_clients') int noOfClients,
      @JsonKey(name: 'generated_by') String generatedBy,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt});
}

/// @nodoc
class __$MainOrderCopyWithImpl<$Res> implements _$MainOrderCopyWith<$Res> {
  __$MainOrderCopyWithImpl(this._self, this._then);

  final _MainOrder _self;
  final $Res Function(_MainOrder) _then;

  /// Create a copy of MainOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mainOrderId = null,
    Object? deliveryDate = null,
    Object? companies = null,
    Object? overallTotal = null,
    Object? overallTotalAfterDis = null,
    Object? serviceCharges = null,
    Object? noOfProducts = null,
    Object? noOfClients = null,
    Object? generatedBy = null,
    Object? createdAt = null,
  }) {
    return _then(_MainOrder(
      mainOrderId: null == mainOrderId
          ? _self.mainOrderId
          : mainOrderId // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryDate: null == deliveryDate
          ? _self.deliveryDate
          : deliveryDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      companies: null == companies
          ? _self._companies
          : companies // ignore: cast_nullable_to_non_nullable
              as List<CompanyEntry>,
      overallTotal: null == overallTotal
          ? _self.overallTotal
          : overallTotal // ignore: cast_nullable_to_non_nullable
              as double,
      overallTotalAfterDis: null == overallTotalAfterDis
          ? _self.overallTotalAfterDis
          : overallTotalAfterDis // ignore: cast_nullable_to_non_nullable
              as double,
      serviceCharges: null == serviceCharges
          ? _self.serviceCharges
          : serviceCharges // ignore: cast_nullable_to_non_nullable
              as double,
      noOfProducts: null == noOfProducts
          ? _self.noOfProducts
          : noOfProducts // ignore: cast_nullable_to_non_nullable
              as int,
      noOfClients: null == noOfClients
          ? _self.noOfClients
          : noOfClients // ignore: cast_nullable_to_non_nullable
              as int,
      generatedBy: null == generatedBy
          ? _self.generatedBy
          : generatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
