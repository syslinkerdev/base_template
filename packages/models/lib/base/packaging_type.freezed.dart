// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'packaging_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PackagingType {
  String get id;
  String get label; // Tray, Packet, Buckets
  int get quantity;

  /// Create a copy of PackagingType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PackagingTypeCopyWith<PackagingType> get copyWith =>
      _$PackagingTypeCopyWithImpl<PackagingType>(
          this as PackagingType, _$identity);

  /// Serializes this PackagingType to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PackagingType &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, quantity);

  @override
  String toString() {
    return 'PackagingType(id: $id, label: $label, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class $PackagingTypeCopyWith<$Res> {
  factory $PackagingTypeCopyWith(
          PackagingType value, $Res Function(PackagingType) _then) =
      _$PackagingTypeCopyWithImpl;
  @useResult
  $Res call({String id, String label, int quantity});
}

/// @nodoc
class _$PackagingTypeCopyWithImpl<$Res>
    implements $PackagingTypeCopyWith<$Res> {
  _$PackagingTypeCopyWithImpl(this._self, this._then);

  final PackagingType _self;
  final $Res Function(PackagingType) _then;

  /// Create a copy of PackagingType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? quantity = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [PackagingType].
extension PackagingTypePatterns on PackagingType {
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
    TResult Function(_PackagingType value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PackagingType() when $default != null:
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
    TResult Function(_PackagingType value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackagingType():
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
    TResult? Function(_PackagingType value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackagingType() when $default != null:
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
    TResult Function(String id, String label, int quantity)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PackagingType() when $default != null:
        return $default(_that.id, _that.label, _that.quantity);
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
    TResult Function(String id, String label, int quantity) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackagingType():
        return $default(_that.id, _that.label, _that.quantity);
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
    TResult? Function(String id, String label, int quantity)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackagingType() when $default != null:
        return $default(_that.id, _that.label, _that.quantity);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PackagingType implements PackagingType {
  _PackagingType(
      {required this.id, required this.label, required this.quantity});
  factory _PackagingType.fromJson(Map<String, dynamic> json) =>
      _$PackagingTypeFromJson(json);

  @override
  final String id;
  @override
  final String label;
// Tray, Packet, Buckets
  @override
  final int quantity;

  /// Create a copy of PackagingType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PackagingTypeCopyWith<_PackagingType> get copyWith =>
      __$PackagingTypeCopyWithImpl<_PackagingType>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PackagingTypeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PackagingType &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, quantity);

  @override
  String toString() {
    return 'PackagingType(id: $id, label: $label, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class _$PackagingTypeCopyWith<$Res>
    implements $PackagingTypeCopyWith<$Res> {
  factory _$PackagingTypeCopyWith(
          _PackagingType value, $Res Function(_PackagingType) _then) =
      __$PackagingTypeCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String label, int quantity});
}

/// @nodoc
class __$PackagingTypeCopyWithImpl<$Res>
    implements _$PackagingTypeCopyWith<$Res> {
  __$PackagingTypeCopyWithImpl(this._self, this._then);

  final _PackagingType _self;
  final $Res Function(_PackagingType) _then;

  /// Create a copy of PackagingType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? quantity = null,
  }) {
    return _then(_PackagingType(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
