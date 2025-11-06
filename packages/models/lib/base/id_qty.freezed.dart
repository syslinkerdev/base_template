// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'id_qty.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IdQty {
  String get id;
  int? get qty;

  /// Create a copy of IdQty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IdQtyCopyWith<IdQty> get copyWith =>
      _$IdQtyCopyWithImpl<IdQty>(this as IdQty, _$identity);

  /// Serializes this IdQty to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IdQty &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.qty, qty) || other.qty == qty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, qty);

  @override
  String toString() {
    return 'IdQty(id: $id, qty: $qty)';
  }
}

/// @nodoc
abstract mixin class $IdQtyCopyWith<$Res> {
  factory $IdQtyCopyWith(IdQty value, $Res Function(IdQty) _then) =
      _$IdQtyCopyWithImpl;
  @useResult
  $Res call({String id, int? qty});
}

/// @nodoc
class _$IdQtyCopyWithImpl<$Res> implements $IdQtyCopyWith<$Res> {
  _$IdQtyCopyWithImpl(this._self, this._then);

  final IdQty _self;
  final $Res Function(IdQty) _then;

  /// Create a copy of IdQty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? qty = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      qty: freezed == qty
          ? _self.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [IdQty].
extension IdQtyPatterns on IdQty {
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
    TResult Function(_IdQty value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IdQty() when $default != null:
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
    TResult Function(_IdQty value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IdQty():
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
    TResult? Function(_IdQty value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IdQty() when $default != null:
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
    TResult Function(String id, int? qty)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IdQty() when $default != null:
        return $default(_that.id, _that.qty);
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
    TResult Function(String id, int? qty) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IdQty():
        return $default(_that.id, _that.qty);
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
    TResult? Function(String id, int? qty)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IdQty() when $default != null:
        return $default(_that.id, _that.qty);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _IdQty extends IdQty {
  _IdQty({required this.id, this.qty}) : super._();
  factory _IdQty.fromJson(Map<String, dynamic> json) => _$IdQtyFromJson(json);

  @override
  final String id;
  @override
  final int? qty;

  /// Create a copy of IdQty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IdQtyCopyWith<_IdQty> get copyWith =>
      __$IdQtyCopyWithImpl<_IdQty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IdQtyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IdQty &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.qty, qty) || other.qty == qty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, qty);

  @override
  String toString() {
    return 'IdQty(id: $id, qty: $qty)';
  }
}

/// @nodoc
abstract mixin class _$IdQtyCopyWith<$Res> implements $IdQtyCopyWith<$Res> {
  factory _$IdQtyCopyWith(_IdQty value, $Res Function(_IdQty) _then) =
      __$IdQtyCopyWithImpl;
  @override
  @useResult
  $Res call({String id, int? qty});
}

/// @nodoc
class __$IdQtyCopyWithImpl<$Res> implements _$IdQtyCopyWith<$Res> {
  __$IdQtyCopyWithImpl(this._self, this._then);

  final _IdQty _self;
  final $Res Function(_IdQty) _then;

  /// Create a copy of IdQty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? qty = freezed,
  }) {
    return _then(_IdQty(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      qty: freezed == qty
          ? _self.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
