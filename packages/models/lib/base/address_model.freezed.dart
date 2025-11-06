// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Address {
  @JsonKey(name: 'state_name')
  String get stateName;
  @JsonKey(name: 'city')
  String get city;
  @JsonKey(name: 'locality')
  String get locality;
  @JsonKey(name: 'pin_code')
  String get pinCode;
  @JsonKey(name: 'street')
  String get street;
  @JsonKey(name: 'building_number')
  String get buildingNumber;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressCopyWith<Address> get copyWith =>
      _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Address &&
            (identical(other.stateName, stateName) ||
                other.stateName == stateName) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.pinCode, pinCode) || other.pinCode == pinCode) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.buildingNumber, buildingNumber) ||
                other.buildingNumber == buildingNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, stateName, city, locality, pinCode, street, buildingNumber);

  @override
  String toString() {
    return 'Address(stateName: $stateName, city: $city, locality: $locality, pinCode: $pinCode, street: $street, buildingNumber: $buildingNumber)';
  }
}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) =
      _$AddressCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'state_name') String stateName,
      @JsonKey(name: 'city') String city,
      @JsonKey(name: 'locality') String locality,
      @JsonKey(name: 'pin_code') String pinCode,
      @JsonKey(name: 'street') String street,
      @JsonKey(name: 'building_number') String buildingNumber});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res> implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stateName = null,
    Object? city = null,
    Object? locality = null,
    Object? pinCode = null,
    Object? street = null,
    Object? buildingNumber = null,
  }) {
    return _then(_self.copyWith(
      stateName: null == stateName
          ? _self.stateName
          : stateName // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      locality: null == locality
          ? _self.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String,
      pinCode: null == pinCode
          ? _self.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
      street: null == street
          ? _self.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      buildingNumber: null == buildingNumber
          ? _self.buildingNumber
          : buildingNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [Address].
extension AddressPatterns on Address {
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
    TResult Function(_Address value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
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
    TResult Function(_Address value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address():
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
    TResult? Function(_Address value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
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
            @JsonKey(name: 'state_name') String stateName,
            @JsonKey(name: 'city') String city,
            @JsonKey(name: 'locality') String locality,
            @JsonKey(name: 'pin_code') String pinCode,
            @JsonKey(name: 'street') String street,
            @JsonKey(name: 'building_number') String buildingNumber)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
        return $default(_that.stateName, _that.city, _that.locality,
            _that.pinCode, _that.street, _that.buildingNumber);
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
            @JsonKey(name: 'state_name') String stateName,
            @JsonKey(name: 'city') String city,
            @JsonKey(name: 'locality') String locality,
            @JsonKey(name: 'pin_code') String pinCode,
            @JsonKey(name: 'street') String street,
            @JsonKey(name: 'building_number') String buildingNumber)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address():
        return $default(_that.stateName, _that.city, _that.locality,
            _that.pinCode, _that.street, _that.buildingNumber);
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
            @JsonKey(name: 'state_name') String stateName,
            @JsonKey(name: 'city') String city,
            @JsonKey(name: 'locality') String locality,
            @JsonKey(name: 'pin_code') String pinCode,
            @JsonKey(name: 'street') String street,
            @JsonKey(name: 'building_number') String buildingNumber)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Address() when $default != null:
        return $default(_that.stateName, _that.city, _that.locality,
            _that.pinCode, _that.street, _that.buildingNumber);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Address implements Address {
  const _Address(
      {@JsonKey(name: 'state_name') required this.stateName,
      @JsonKey(name: 'city') required this.city,
      @JsonKey(name: 'locality') required this.locality,
      @JsonKey(name: 'pin_code') required this.pinCode,
      @JsonKey(name: 'street') required this.street,
      @JsonKey(name: 'building_number') required this.buildingNumber});
  factory _Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  @override
  @JsonKey(name: 'state_name')
  final String stateName;
  @override
  @JsonKey(name: 'city')
  final String city;
  @override
  @JsonKey(name: 'locality')
  final String locality;
  @override
  @JsonKey(name: 'pin_code')
  final String pinCode;
  @override
  @JsonKey(name: 'street')
  final String street;
  @override
  @JsonKey(name: 'building_number')
  final String buildingNumber;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddressCopyWith<_Address> get copyWith =>
      __$AddressCopyWithImpl<_Address>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AddressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Address &&
            (identical(other.stateName, stateName) ||
                other.stateName == stateName) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.pinCode, pinCode) || other.pinCode == pinCode) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.buildingNumber, buildingNumber) ||
                other.buildingNumber == buildingNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, stateName, city, locality, pinCode, street, buildingNumber);

  @override
  String toString() {
    return 'Address(stateName: $stateName, city: $city, locality: $locality, pinCode: $pinCode, street: $street, buildingNumber: $buildingNumber)';
  }
}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) =
      __$AddressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'state_name') String stateName,
      @JsonKey(name: 'city') String city,
      @JsonKey(name: 'locality') String locality,
      @JsonKey(name: 'pin_code') String pinCode,
      @JsonKey(name: 'street') String street,
      @JsonKey(name: 'building_number') String buildingNumber});
}

/// @nodoc
class __$AddressCopyWithImpl<$Res> implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? stateName = null,
    Object? city = null,
    Object? locality = null,
    Object? pinCode = null,
    Object? street = null,
    Object? buildingNumber = null,
  }) {
    return _then(_Address(
      stateName: null == stateName
          ? _self.stateName
          : stateName // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      locality: null == locality
          ? _self.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String,
      pinCode: null == pinCode
          ? _self.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String,
      street: null == street
          ? _self.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      buildingNumber: null == buildingNumber
          ? _self.buildingNumber
          : buildingNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
