// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompanyEntry {
  @JsonKey(name: 'company_id')
  String get companyId;
  @JsonKey(name: 'company_name')
  String get companyName;

  /// Total value before discount
  @JsonKey(name: 'total')
  double get total;

  /// Total after discount (net payable)
  @JsonKey(name: 'total_after_dis')
  double get totalAfterDis;

  /// No. of products ordered for this company
  @JsonKey(name: 'prod_count')
  int get prodCount;

  /// No. of distinct clients who ordered
  @JsonKey(name: 'client_count')
  int get clientCount;

  /// Optional: if you want to store timestamp of this company’s entry
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  DateTime get createdAt;

  /// Create a copy of CompanyEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CompanyEntryCopyWith<CompanyEntry> get copyWith =>
      _$CompanyEntryCopyWithImpl<CompanyEntry>(
          this as CompanyEntry, _$identity);

  /// Serializes this CompanyEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CompanyEntry &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalAfterDis, totalAfterDis) ||
                other.totalAfterDis == totalAfterDis) &&
            (identical(other.prodCount, prodCount) ||
                other.prodCount == prodCount) &&
            (identical(other.clientCount, clientCount) ||
                other.clientCount == clientCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, companyId, companyName, total,
      totalAfterDis, prodCount, clientCount, createdAt);

  @override
  String toString() {
    return 'CompanyEntry(companyId: $companyId, companyName: $companyName, total: $total, totalAfterDis: $totalAfterDis, prodCount: $prodCount, clientCount: $clientCount, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $CompanyEntryCopyWith<$Res> {
  factory $CompanyEntryCopyWith(
          CompanyEntry value, $Res Function(CompanyEntry) _then) =
      _$CompanyEntryCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'company_id') String companyId,
      @JsonKey(name: 'company_name') String companyName,
      @JsonKey(name: 'total') double total,
      @JsonKey(name: 'total_after_dis') double totalAfterDis,
      @JsonKey(name: 'prod_count') int prodCount,
      @JsonKey(name: 'client_count') int clientCount,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt});
}

/// @nodoc
class _$CompanyEntryCopyWithImpl<$Res> implements $CompanyEntryCopyWith<$Res> {
  _$CompanyEntryCopyWithImpl(this._self, this._then);

  final CompanyEntry _self;
  final $Res Function(CompanyEntry) _then;

  /// Create a copy of CompanyEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyId = null,
    Object? companyName = null,
    Object? total = null,
    Object? totalAfterDis = null,
    Object? prodCount = null,
    Object? clientCount = null,
    Object? createdAt = null,
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
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      totalAfterDis: null == totalAfterDis
          ? _self.totalAfterDis
          : totalAfterDis // ignore: cast_nullable_to_non_nullable
              as double,
      prodCount: null == prodCount
          ? _self.prodCount
          : prodCount // ignore: cast_nullable_to_non_nullable
              as int,
      clientCount: null == clientCount
          ? _self.clientCount
          : clientCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [CompanyEntry].
extension CompanyEntryPatterns on CompanyEntry {
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
    TResult Function(_CompanyEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CompanyEntry() when $default != null:
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
    TResult Function(_CompanyEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CompanyEntry():
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
    TResult? Function(_CompanyEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CompanyEntry() when $default != null:
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
            @JsonKey(name: 'total') double total,
            @JsonKey(name: 'total_after_dis') double totalAfterDis,
            @JsonKey(name: 'prod_count') int prodCount,
            @JsonKey(name: 'client_count') int clientCount,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CompanyEntry() when $default != null:
        return $default(
            _that.companyId,
            _that.companyName,
            _that.total,
            _that.totalAfterDis,
            _that.prodCount,
            _that.clientCount,
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
            @JsonKey(name: 'company_id') String companyId,
            @JsonKey(name: 'company_name') String companyName,
            @JsonKey(name: 'total') double total,
            @JsonKey(name: 'total_after_dis') double totalAfterDis,
            @JsonKey(name: 'prod_count') int prodCount,
            @JsonKey(name: 'client_count') int clientCount,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CompanyEntry():
        return $default(
            _that.companyId,
            _that.companyName,
            _that.total,
            _that.totalAfterDis,
            _that.prodCount,
            _that.clientCount,
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
            @JsonKey(name: 'company_id') String companyId,
            @JsonKey(name: 'company_name') String companyName,
            @JsonKey(name: 'total') double total,
            @JsonKey(name: 'total_after_dis') double totalAfterDis,
            @JsonKey(name: 'prod_count') int prodCount,
            @JsonKey(name: 'client_count') int clientCount,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CompanyEntry() when $default != null:
        return $default(
            _that.companyId,
            _that.companyName,
            _that.total,
            _that.totalAfterDis,
            _that.prodCount,
            _that.clientCount,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CompanyEntry extends CompanyEntry {
  const _CompanyEntry(
      {@JsonKey(name: 'company_id') required this.companyId,
      @JsonKey(name: 'company_name') required this.companyName,
      @JsonKey(name: 'total') required this.total,
      @JsonKey(name: 'total_after_dis') required this.totalAfterDis,
      @JsonKey(name: 'prod_count') required this.prodCount,
      @JsonKey(name: 'client_count') required this.clientCount,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      required this.createdAt})
      : super._();
  factory _CompanyEntry.fromJson(Map<String, dynamic> json) =>
      _$CompanyEntryFromJson(json);

  @override
  @JsonKey(name: 'company_id')
  final String companyId;
  @override
  @JsonKey(name: 'company_name')
  final String companyName;

  /// Total value before discount
  @override
  @JsonKey(name: 'total')
  final double total;

  /// Total after discount (net payable)
  @override
  @JsonKey(name: 'total_after_dis')
  final double totalAfterDis;

  /// No. of products ordered for this company
  @override
  @JsonKey(name: 'prod_count')
  final int prodCount;

  /// No. of distinct clients who ordered
  @override
  @JsonKey(name: 'client_count')
  final int clientCount;

  /// Optional: if you want to store timestamp of this company’s entry
  @override
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  final DateTime createdAt;

  /// Create a copy of CompanyEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CompanyEntryCopyWith<_CompanyEntry> get copyWith =>
      __$CompanyEntryCopyWithImpl<_CompanyEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CompanyEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompanyEntry &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalAfterDis, totalAfterDis) ||
                other.totalAfterDis == totalAfterDis) &&
            (identical(other.prodCount, prodCount) ||
                other.prodCount == prodCount) &&
            (identical(other.clientCount, clientCount) ||
                other.clientCount == clientCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, companyId, companyName, total,
      totalAfterDis, prodCount, clientCount, createdAt);

  @override
  String toString() {
    return 'CompanyEntry(companyId: $companyId, companyName: $companyName, total: $total, totalAfterDis: $totalAfterDis, prodCount: $prodCount, clientCount: $clientCount, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$CompanyEntryCopyWith<$Res>
    implements $CompanyEntryCopyWith<$Res> {
  factory _$CompanyEntryCopyWith(
          _CompanyEntry value, $Res Function(_CompanyEntry) _then) =
      __$CompanyEntryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'company_id') String companyId,
      @JsonKey(name: 'company_name') String companyName,
      @JsonKey(name: 'total') double total,
      @JsonKey(name: 'total_after_dis') double totalAfterDis,
      @JsonKey(name: 'prod_count') int prodCount,
      @JsonKey(name: 'client_count') int clientCount,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt});
}

/// @nodoc
class __$CompanyEntryCopyWithImpl<$Res>
    implements _$CompanyEntryCopyWith<$Res> {
  __$CompanyEntryCopyWithImpl(this._self, this._then);

  final _CompanyEntry _self;
  final $Res Function(_CompanyEntry) _then;

  /// Create a copy of CompanyEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? companyId = null,
    Object? companyName = null,
    Object? total = null,
    Object? totalAfterDis = null,
    Object? prodCount = null,
    Object? clientCount = null,
    Object? createdAt = null,
  }) {
    return _then(_CompanyEntry(
      companyId: null == companyId
          ? _self.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      totalAfterDis: null == totalAfterDis
          ? _self.totalAfterDis
          : totalAfterDis // ignore: cast_nullable_to_non_nullable
              as double,
      prodCount: null == prodCount
          ? _self.prodCount
          : prodCount // ignore: cast_nullable_to_non_nullable
              as int,
      clientCount: null == clientCount
          ? _self.clientCount
          : clientCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
