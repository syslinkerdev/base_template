// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_no_verify_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneNoVerifyState {
  bool get longLoading;
  bool get otpTimedOut;
  String? get verificationId;
  String? get phoneNumber;
  DateTime? get otpStartTime;

  /// Create a copy of PhoneNoVerifyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PhoneNoVerifyStateCopyWith<PhoneNoVerifyState> get copyWith =>
      _$PhoneNoVerifyStateCopyWithImpl<PhoneNoVerifyState>(
          this as PhoneNoVerifyState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PhoneNoVerifyState &&
            (identical(other.longLoading, longLoading) ||
                other.longLoading == longLoading) &&
            (identical(other.otpTimedOut, otpTimedOut) ||
                other.otpTimedOut == otpTimedOut) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.otpStartTime, otpStartTime) ||
                other.otpStartTime == otpStartTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, longLoading, otpTimedOut,
      verificationId, phoneNumber, otpStartTime);

  @override
  String toString() {
    return 'PhoneNoVerifyState(longLoading: $longLoading, otpTimedOut: $otpTimedOut, verificationId: $verificationId, phoneNumber: $phoneNumber, otpStartTime: $otpStartTime)';
  }
}

/// @nodoc
abstract mixin class $PhoneNoVerifyStateCopyWith<$Res> {
  factory $PhoneNoVerifyStateCopyWith(
          PhoneNoVerifyState value, $Res Function(PhoneNoVerifyState) _then) =
      _$PhoneNoVerifyStateCopyWithImpl;
  @useResult
  $Res call(
      {bool longLoading,
      bool otpTimedOut,
      String? verificationId,
      String? phoneNumber,
      DateTime? otpStartTime});
}

/// @nodoc
class _$PhoneNoVerifyStateCopyWithImpl<$Res>
    implements $PhoneNoVerifyStateCopyWith<$Res> {
  _$PhoneNoVerifyStateCopyWithImpl(this._self, this._then);

  final PhoneNoVerifyState _self;
  final $Res Function(PhoneNoVerifyState) _then;

  /// Create a copy of PhoneNoVerifyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? longLoading = null,
    Object? otpTimedOut = null,
    Object? verificationId = freezed,
    Object? phoneNumber = freezed,
    Object? otpStartTime = freezed,
  }) {
    return _then(_self.copyWith(
      longLoading: null == longLoading
          ? _self.longLoading
          : longLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      otpTimedOut: null == otpTimedOut
          ? _self.otpTimedOut
          : otpTimedOut // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationId: freezed == verificationId
          ? _self.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      otpStartTime: freezed == otpStartTime
          ? _self.otpStartTime
          : otpStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PhoneNoVerifyState].
extension PhoneNoVerifyStatePatterns on PhoneNoVerifyState {
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
    TResult Function(_PhoneNoVerifyState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PhoneNoVerifyState() when $default != null:
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
    TResult Function(_PhoneNoVerifyState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PhoneNoVerifyState():
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
    TResult? Function(_PhoneNoVerifyState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PhoneNoVerifyState() when $default != null:
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
    TResult Function(bool longLoading, bool otpTimedOut, String? verificationId,
            String? phoneNumber, DateTime? otpStartTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PhoneNoVerifyState() when $default != null:
        return $default(_that.longLoading, _that.otpTimedOut,
            _that.verificationId, _that.phoneNumber, _that.otpStartTime);
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
    TResult Function(bool longLoading, bool otpTimedOut, String? verificationId,
            String? phoneNumber, DateTime? otpStartTime)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PhoneNoVerifyState():
        return $default(_that.longLoading, _that.otpTimedOut,
            _that.verificationId, _that.phoneNumber, _that.otpStartTime);
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
            bool longLoading,
            bool otpTimedOut,
            String? verificationId,
            String? phoneNumber,
            DateTime? otpStartTime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PhoneNoVerifyState() when $default != null:
        return $default(_that.longLoading, _that.otpTimedOut,
            _that.verificationId, _that.phoneNumber, _that.otpStartTime);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PhoneNoVerifyState implements PhoneNoVerifyState {
  const _PhoneNoVerifyState(
      {this.longLoading = false,
      this.otpTimedOut = false,
      this.verificationId,
      this.phoneNumber,
      this.otpStartTime});

  @override
  @JsonKey()
  final bool longLoading;
  @override
  @JsonKey()
  final bool otpTimedOut;
  @override
  final String? verificationId;
  @override
  final String? phoneNumber;
  @override
  final DateTime? otpStartTime;

  /// Create a copy of PhoneNoVerifyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PhoneNoVerifyStateCopyWith<_PhoneNoVerifyState> get copyWith =>
      __$PhoneNoVerifyStateCopyWithImpl<_PhoneNoVerifyState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PhoneNoVerifyState &&
            (identical(other.longLoading, longLoading) ||
                other.longLoading == longLoading) &&
            (identical(other.otpTimedOut, otpTimedOut) ||
                other.otpTimedOut == otpTimedOut) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.otpStartTime, otpStartTime) ||
                other.otpStartTime == otpStartTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, longLoading, otpTimedOut,
      verificationId, phoneNumber, otpStartTime);

  @override
  String toString() {
    return 'PhoneNoVerifyState(longLoading: $longLoading, otpTimedOut: $otpTimedOut, verificationId: $verificationId, phoneNumber: $phoneNumber, otpStartTime: $otpStartTime)';
  }
}

/// @nodoc
abstract mixin class _$PhoneNoVerifyStateCopyWith<$Res>
    implements $PhoneNoVerifyStateCopyWith<$Res> {
  factory _$PhoneNoVerifyStateCopyWith(
          _PhoneNoVerifyState value, $Res Function(_PhoneNoVerifyState) _then) =
      __$PhoneNoVerifyStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool longLoading,
      bool otpTimedOut,
      String? verificationId,
      String? phoneNumber,
      DateTime? otpStartTime});
}

/// @nodoc
class __$PhoneNoVerifyStateCopyWithImpl<$Res>
    implements _$PhoneNoVerifyStateCopyWith<$Res> {
  __$PhoneNoVerifyStateCopyWithImpl(this._self, this._then);

  final _PhoneNoVerifyState _self;
  final $Res Function(_PhoneNoVerifyState) _then;

  /// Create a copy of PhoneNoVerifyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? longLoading = null,
    Object? otpTimedOut = null,
    Object? verificationId = freezed,
    Object? phoneNumber = freezed,
    Object? otpStartTime = freezed,
  }) {
    return _then(_PhoneNoVerifyState(
      longLoading: null == longLoading
          ? _self.longLoading
          : longLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      otpTimedOut: null == otpTimedOut
          ? _self.otpTimedOut
          : otpTimedOut // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationId: freezed == verificationId
          ? _self.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      otpStartTime: freezed == otpStartTime
          ? _self.otpStartTime
          : otpStartTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
