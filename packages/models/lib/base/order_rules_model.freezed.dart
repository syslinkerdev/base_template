// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_rules_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderRules {
  @JsonKey(name: 'order_start', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get orderStart;
  @JsonKey(name: 'order_end', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get orderEnd;
  @JsonKey(
      name: 'default_order_start',
      fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get defaultOrderStart;
  @JsonKey(
      name: 'default_order_end', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get defaultOrderEnd;
  @JsonKey(name: 'override_date', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get overrideDate;
  @JsonKey(name: 'enabled')
  bool? get enabled;
  @JsonKey(name: 'last_updated', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get lastUpdated;

  /// Create a copy of OrderRules
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderRulesCopyWith<OrderRules> get copyWith =>
      _$OrderRulesCopyWithImpl<OrderRules>(this as OrderRules, _$identity);

  /// Serializes this OrderRules to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderRules &&
            (identical(other.orderStart, orderStart) ||
                other.orderStart == orderStart) &&
            (identical(other.orderEnd, orderEnd) ||
                other.orderEnd == orderEnd) &&
            (identical(other.defaultOrderStart, defaultOrderStart) ||
                other.defaultOrderStart == defaultOrderStart) &&
            (identical(other.defaultOrderEnd, defaultOrderEnd) ||
                other.defaultOrderEnd == defaultOrderEnd) &&
            (identical(other.overrideDate, overrideDate) ||
                other.overrideDate == overrideDate) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, orderStart, orderEnd,
      defaultOrderStart, defaultOrderEnd, overrideDate, enabled, lastUpdated);

  @override
  String toString() {
    return 'OrderRules(orderStart: $orderStart, orderEnd: $orderEnd, defaultOrderStart: $defaultOrderStart, defaultOrderEnd: $defaultOrderEnd, overrideDate: $overrideDate, enabled: $enabled, lastUpdated: $lastUpdated)';
  }
}

/// @nodoc
abstract mixin class $OrderRulesCopyWith<$Res> {
  factory $OrderRulesCopyWith(
          OrderRules value, $Res Function(OrderRules) _then) =
      _$OrderRulesCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(
          name: 'order_start', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? orderStart,
      @JsonKey(name: 'order_end', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? orderEnd,
      @JsonKey(
          name: 'default_order_start',
          fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? defaultOrderStart,
      @JsonKey(
          name: 'default_order_end',
          fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? defaultOrderEnd,
      @JsonKey(
          name: 'override_date', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? overrideDate,
      @JsonKey(name: 'enabled') bool? enabled,
      @JsonKey(
          name: 'last_updated', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? lastUpdated});
}

/// @nodoc
class _$OrderRulesCopyWithImpl<$Res> implements $OrderRulesCopyWith<$Res> {
  _$OrderRulesCopyWithImpl(this._self, this._then);

  final OrderRules _self;
  final $Res Function(OrderRules) _then;

  /// Create a copy of OrderRules
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderStart = freezed,
    Object? orderEnd = freezed,
    Object? defaultOrderStart = freezed,
    Object? defaultOrderEnd = freezed,
    Object? overrideDate = freezed,
    Object? enabled = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_self.copyWith(
      orderStart: freezed == orderStart
          ? _self.orderStart
          : orderStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderEnd: freezed == orderEnd
          ? _self.orderEnd
          : orderEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      defaultOrderStart: freezed == defaultOrderStart
          ? _self.defaultOrderStart
          : defaultOrderStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      defaultOrderEnd: freezed == defaultOrderEnd
          ? _self.defaultOrderEnd
          : defaultOrderEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      overrideDate: freezed == overrideDate
          ? _self.overrideDate
          : overrideDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      enabled: freezed == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastUpdated: freezed == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [OrderRules].
extension OrderRulesPatterns on OrderRules {
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
    TResult Function(_OrderRules value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrderRules() when $default != null:
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
    TResult Function(_OrderRules value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderRules():
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
    TResult? Function(_OrderRules value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderRules() when $default != null:
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
                name: 'order_start',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? orderStart,
            @JsonKey(
                name: 'order_end',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? orderEnd,
            @JsonKey(
                name: 'default_order_start',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? defaultOrderStart,
            @JsonKey(
                name: 'default_order_end',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? defaultOrderEnd,
            @JsonKey(
                name: 'override_date',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? overrideDate,
            @JsonKey(name: 'enabled') bool? enabled,
            @JsonKey(
                name: 'last_updated',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? lastUpdated)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OrderRules() when $default != null:
        return $default(
            _that.orderStart,
            _that.orderEnd,
            _that.defaultOrderStart,
            _that.defaultOrderEnd,
            _that.overrideDate,
            _that.enabled,
            _that.lastUpdated);
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
                name: 'order_start',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? orderStart,
            @JsonKey(
                name: 'order_end',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? orderEnd,
            @JsonKey(
                name: 'default_order_start',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? defaultOrderStart,
            @JsonKey(
                name: 'default_order_end',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? defaultOrderEnd,
            @JsonKey(
                name: 'override_date',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? overrideDate,
            @JsonKey(name: 'enabled') bool? enabled,
            @JsonKey(
                name: 'last_updated',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? lastUpdated)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderRules():
        return $default(
            _that.orderStart,
            _that.orderEnd,
            _that.defaultOrderStart,
            _that.defaultOrderEnd,
            _that.overrideDate,
            _that.enabled,
            _that.lastUpdated);
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
                name: 'order_start',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? orderStart,
            @JsonKey(
                name: 'order_end',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? orderEnd,
            @JsonKey(
                name: 'default_order_start',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? defaultOrderStart,
            @JsonKey(
                name: 'default_order_end',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? defaultOrderEnd,
            @JsonKey(
                name: 'override_date',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? overrideDate,
            @JsonKey(name: 'enabled') bool? enabled,
            @JsonKey(
                name: 'last_updated',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? lastUpdated)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OrderRules() when $default != null:
        return $default(
            _that.orderStart,
            _that.orderEnd,
            _that.defaultOrderStart,
            _that.defaultOrderEnd,
            _that.overrideDate,
            _that.enabled,
            _that.lastUpdated);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OrderRules extends OrderRules {
  _OrderRules(
      {@JsonKey(
          name: 'order_start', fromJson: TimeStampConverter.fromJsonNullable)
      this.orderStart,
      @JsonKey(name: 'order_end', fromJson: TimeStampConverter.fromJsonNullable)
      this.orderEnd,
      @JsonKey(
          name: 'default_order_start',
          fromJson: TimeStampConverter.fromJsonNullable)
      this.defaultOrderStart,
      @JsonKey(
          name: 'default_order_end',
          fromJson: TimeStampConverter.fromJsonNullable)
      this.defaultOrderEnd,
      @JsonKey(
          name: 'override_date', fromJson: TimeStampConverter.fromJsonNullable)
      this.overrideDate,
      @JsonKey(name: 'enabled') this.enabled,
      @JsonKey(
          name: 'last_updated', fromJson: TimeStampConverter.fromJsonNullable)
      this.lastUpdated})
      : super._();
  factory _OrderRules.fromJson(Map<String, dynamic> json) =>
      _$OrderRulesFromJson(json);

  @override
  @JsonKey(name: 'order_start', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? orderStart;
  @override
  @JsonKey(name: 'order_end', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? orderEnd;
  @override
  @JsonKey(
      name: 'default_order_start',
      fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? defaultOrderStart;
  @override
  @JsonKey(
      name: 'default_order_end', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? defaultOrderEnd;
  @override
  @JsonKey(name: 'override_date', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? overrideDate;
  @override
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @override
  @JsonKey(name: 'last_updated', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? lastUpdated;

  /// Create a copy of OrderRules
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderRulesCopyWith<_OrderRules> get copyWith =>
      __$OrderRulesCopyWithImpl<_OrderRules>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OrderRulesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderRules &&
            (identical(other.orderStart, orderStart) ||
                other.orderStart == orderStart) &&
            (identical(other.orderEnd, orderEnd) ||
                other.orderEnd == orderEnd) &&
            (identical(other.defaultOrderStart, defaultOrderStart) ||
                other.defaultOrderStart == defaultOrderStart) &&
            (identical(other.defaultOrderEnd, defaultOrderEnd) ||
                other.defaultOrderEnd == defaultOrderEnd) &&
            (identical(other.overrideDate, overrideDate) ||
                other.overrideDate == overrideDate) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, orderStart, orderEnd,
      defaultOrderStart, defaultOrderEnd, overrideDate, enabled, lastUpdated);

  @override
  String toString() {
    return 'OrderRules(orderStart: $orderStart, orderEnd: $orderEnd, defaultOrderStart: $defaultOrderStart, defaultOrderEnd: $defaultOrderEnd, overrideDate: $overrideDate, enabled: $enabled, lastUpdated: $lastUpdated)';
  }
}

/// @nodoc
abstract mixin class _$OrderRulesCopyWith<$Res>
    implements $OrderRulesCopyWith<$Res> {
  factory _$OrderRulesCopyWith(
          _OrderRules value, $Res Function(_OrderRules) _then) =
      __$OrderRulesCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          name: 'order_start', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? orderStart,
      @JsonKey(name: 'order_end', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? orderEnd,
      @JsonKey(
          name: 'default_order_start',
          fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? defaultOrderStart,
      @JsonKey(
          name: 'default_order_end',
          fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? defaultOrderEnd,
      @JsonKey(
          name: 'override_date', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? overrideDate,
      @JsonKey(name: 'enabled') bool? enabled,
      @JsonKey(
          name: 'last_updated', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? lastUpdated});
}

/// @nodoc
class __$OrderRulesCopyWithImpl<$Res> implements _$OrderRulesCopyWith<$Res> {
  __$OrderRulesCopyWithImpl(this._self, this._then);

  final _OrderRules _self;
  final $Res Function(_OrderRules) _then;

  /// Create a copy of OrderRules
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? orderStart = freezed,
    Object? orderEnd = freezed,
    Object? defaultOrderStart = freezed,
    Object? defaultOrderEnd = freezed,
    Object? overrideDate = freezed,
    Object? enabled = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_OrderRules(
      orderStart: freezed == orderStart
          ? _self.orderStart
          : orderStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderEnd: freezed == orderEnd
          ? _self.orderEnd
          : orderEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      defaultOrderStart: freezed == defaultOrderStart
          ? _self.defaultOrderStart
          : defaultOrderStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      defaultOrderEnd: freezed == defaultOrderEnd
          ? _self.defaultOrderEnd
          : defaultOrderEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      overrideDate: freezed == overrideDate
          ? _self.overrideDate
          : overrideDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      enabled: freezed == enabled
          ? _self.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastUpdated: freezed == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
