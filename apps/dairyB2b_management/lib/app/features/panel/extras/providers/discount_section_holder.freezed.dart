// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discount_section_holder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiscountSectionHolderState {
  DiscountSection get disSection;
  DiscountSectionMode get mode;

  /// Create a copy of DiscountSectionHolderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DiscountSectionHolderStateCopyWith<DiscountSectionHolderState>
      get copyWith =>
          _$DiscountSectionHolderStateCopyWithImpl<DiscountSectionHolderState>(
              this as DiscountSectionHolderState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DiscountSectionHolderState &&
            (identical(other.disSection, disSection) ||
                other.disSection == disSection) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, disSection, mode);

  @override
  String toString() {
    return 'DiscountSectionHolderState(disSection: $disSection, mode: $mode)';
  }
}

/// @nodoc
abstract mixin class $DiscountSectionHolderStateCopyWith<$Res> {
  factory $DiscountSectionHolderStateCopyWith(DiscountSectionHolderState value,
          $Res Function(DiscountSectionHolderState) _then) =
      _$DiscountSectionHolderStateCopyWithImpl;
  @useResult
  $Res call({DiscountSection disSection, DiscountSectionMode mode});

  $DiscountSectionCopyWith<$Res> get disSection;
}

/// @nodoc
class _$DiscountSectionHolderStateCopyWithImpl<$Res>
    implements $DiscountSectionHolderStateCopyWith<$Res> {
  _$DiscountSectionHolderStateCopyWithImpl(this._self, this._then);

  final DiscountSectionHolderState _self;
  final $Res Function(DiscountSectionHolderState) _then;

  /// Create a copy of DiscountSectionHolderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? disSection = null,
    Object? mode = null,
  }) {
    return _then(_self.copyWith(
      disSection: null == disSection
          ? _self.disSection
          : disSection // ignore: cast_nullable_to_non_nullable
              as DiscountSection,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as DiscountSectionMode,
    ));
  }

  /// Create a copy of DiscountSectionHolderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscountSectionCopyWith<$Res> get disSection {
    return $DiscountSectionCopyWith<$Res>(_self.disSection, (value) {
      return _then(_self.copyWith(disSection: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DiscountSectionHolderState].
extension DiscountSectionHolderStatePatterns on DiscountSectionHolderState {
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
    TResult Function(_DiscountSectionHolderState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiscountSectionHolderState() when $default != null:
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
    TResult Function(_DiscountSectionHolderState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscountSectionHolderState():
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
    TResult? Function(_DiscountSectionHolderState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscountSectionHolderState() when $default != null:
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
    TResult Function(DiscountSection disSection, DiscountSectionMode mode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DiscountSectionHolderState() when $default != null:
        return $default(_that.disSection, _that.mode);
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
    TResult Function(DiscountSection disSection, DiscountSectionMode mode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscountSectionHolderState():
        return $default(_that.disSection, _that.mode);
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
    TResult? Function(DiscountSection disSection, DiscountSectionMode mode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DiscountSectionHolderState() when $default != null:
        return $default(_that.disSection, _that.mode);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DiscountSectionHolderState implements DiscountSectionHolderState {
  const _DiscountSectionHolderState(
      {required this.disSection, required this.mode});

  @override
  final DiscountSection disSection;
  @override
  final DiscountSectionMode mode;

  /// Create a copy of DiscountSectionHolderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DiscountSectionHolderStateCopyWith<_DiscountSectionHolderState>
      get copyWith => __$DiscountSectionHolderStateCopyWithImpl<
          _DiscountSectionHolderState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DiscountSectionHolderState &&
            (identical(other.disSection, disSection) ||
                other.disSection == disSection) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, disSection, mode);

  @override
  String toString() {
    return 'DiscountSectionHolderState(disSection: $disSection, mode: $mode)';
  }
}

/// @nodoc
abstract mixin class _$DiscountSectionHolderStateCopyWith<$Res>
    implements $DiscountSectionHolderStateCopyWith<$Res> {
  factory _$DiscountSectionHolderStateCopyWith(
          _DiscountSectionHolderState value,
          $Res Function(_DiscountSectionHolderState) _then) =
      __$DiscountSectionHolderStateCopyWithImpl;
  @override
  @useResult
  $Res call({DiscountSection disSection, DiscountSectionMode mode});

  @override
  $DiscountSectionCopyWith<$Res> get disSection;
}

/// @nodoc
class __$DiscountSectionHolderStateCopyWithImpl<$Res>
    implements _$DiscountSectionHolderStateCopyWith<$Res> {
  __$DiscountSectionHolderStateCopyWithImpl(this._self, this._then);

  final _DiscountSectionHolderState _self;
  final $Res Function(_DiscountSectionHolderState) _then;

  /// Create a copy of DiscountSectionHolderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? disSection = null,
    Object? mode = null,
  }) {
    return _then(_DiscountSectionHolderState(
      disSection: null == disSection
          ? _self.disSection
          : disSection // ignore: cast_nullable_to_non_nullable
              as DiscountSection,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as DiscountSectionMode,
    ));
  }

  /// Create a copy of DiscountSectionHolderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscountSectionCopyWith<$Res> get disSection {
    return $DiscountSectionCopyWith<$Res>(_self.disSection, (value) {
      return _then(_self.copyWith(disSection: value));
    });
  }
}

// dart format on
