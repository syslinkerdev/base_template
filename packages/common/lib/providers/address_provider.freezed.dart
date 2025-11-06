// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddressState {
  String? get address;
  Placemark? get placemark;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressStateCopyWith<AddressState> get copyWith =>
      _$AddressStateCopyWithImpl<AddressState>(
          this as AddressState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddressState &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.placemark, placemark) ||
                other.placemark == placemark));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, placemark);

  @override
  String toString() {
    return 'AddressState(address: $address, placemark: $placemark)';
  }
}

/// @nodoc
abstract mixin class $AddressStateCopyWith<$Res> {
  factory $AddressStateCopyWith(
          AddressState value, $Res Function(AddressState) _then) =
      _$AddressStateCopyWithImpl;
  @useResult
  $Res call({String? address, Placemark? placemark});
}

/// @nodoc
class _$AddressStateCopyWithImpl<$Res> implements $AddressStateCopyWith<$Res> {
  _$AddressStateCopyWithImpl(this._self, this._then);

  final AddressState _self;
  final $Res Function(AddressState) _then;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? placemark = freezed,
  }) {
    return _then(_self.copyWith(
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      placemark: freezed == placemark
          ? _self.placemark
          : placemark // ignore: cast_nullable_to_non_nullable
              as Placemark?,
    ));
  }
}

/// @nodoc

class _AddressState implements AddressState {
  const _AddressState({this.address, this.placemark});

  @override
  final String? address;
  @override
  final Placemark? placemark;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddressStateCopyWith<_AddressState> get copyWith =>
      __$AddressStateCopyWithImpl<_AddressState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddressState &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.placemark, placemark) ||
                other.placemark == placemark));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, placemark);

  @override
  String toString() {
    return 'AddressState(address: $address, placemark: $placemark)';
  }
}

/// @nodoc
abstract mixin class _$AddressStateCopyWith<$Res>
    implements $AddressStateCopyWith<$Res> {
  factory _$AddressStateCopyWith(
          _AddressState value, $Res Function(_AddressState) _then) =
      __$AddressStateCopyWithImpl;
  @override
  @useResult
  $Res call({String? address, Placemark? placemark});
}

/// @nodoc
class __$AddressStateCopyWithImpl<$Res>
    implements _$AddressStateCopyWith<$Res> {
  __$AddressStateCopyWithImpl(this._self, this._then);

  final _AddressState _self;
  final $Res Function(_AddressState) _then;

  /// Create a copy of AddressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? address = freezed,
    Object? placemark = freezed,
  }) {
    return _then(_AddressState(
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      placemark: freezed == placemark
          ? _self.placemark
          : placemark // ignore: cast_nullable_to_non_nullable
              as Placemark?,
    ));
  }
}

// dart format on
