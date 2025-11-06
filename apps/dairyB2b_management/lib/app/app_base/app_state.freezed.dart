// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppState {
  String get uId;
  @JsonKey(
      fromJson: AppStatusConverter.fromJson, toJson: AppStatusConverter.toJson)
  AppStatus get status;
  @JsonKey(fromJson: RoleConverter.fromJson, toJson: RoleConverter.toJson)
  Role get role;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppStateCopyWith<AppState> get copyWith =>
      _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);

  /// Serializes this AppState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppState &&
            (identical(other.uId, uId) || other.uId == uId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uId, status, role);

  @override
  String toString() {
    return 'AppState(uId: $uId, status: $status, role: $role)';
  }
}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) =
      _$AppStateCopyWithImpl;
  @useResult
  $Res call(
      {String uId,
      @JsonKey(
          fromJson: AppStatusConverter.fromJson,
          toJson: AppStatusConverter.toJson)
      AppStatus status,
      @JsonKey(fromJson: RoleConverter.fromJson, toJson: RoleConverter.toJson)
      Role role});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uId = null,
    Object? status = null,
    Object? role = null,
  }) {
    return _then(_self.copyWith(
      uId: null == uId
          ? _self.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppStatus,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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
    TResult Function(_AppState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppState() when $default != null:
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
    TResult Function(_AppState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppState():
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
    TResult? Function(_AppState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppState() when $default != null:
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
            String uId,
            @JsonKey(
                fromJson: AppStatusConverter.fromJson,
                toJson: AppStatusConverter.toJson)
            AppStatus status,
            @JsonKey(
                fromJson: RoleConverter.fromJson, toJson: RoleConverter.toJson)
            Role role)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppState() when $default != null:
        return $default(_that.uId, _that.status, _that.role);
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
            String uId,
            @JsonKey(
                fromJson: AppStatusConverter.fromJson,
                toJson: AppStatusConverter.toJson)
            AppStatus status,
            @JsonKey(
                fromJson: RoleConverter.fromJson, toJson: RoleConverter.toJson)
            Role role)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppState():
        return $default(_that.uId, _that.status, _that.role);
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
            String uId,
            @JsonKey(
                fromJson: AppStatusConverter.fromJson,
                toJson: AppStatusConverter.toJson)
            AppStatus status,
            @JsonKey(
                fromJson: RoleConverter.fromJson, toJson: RoleConverter.toJson)
            Role role)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppState() when $default != null:
        return $default(_that.uId, _that.status, _that.role);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppState implements AppState {
  const _AppState(
      {this.uId = 'empty user',
      @JsonKey(
          fromJson: AppStatusConverter.fromJson,
          toJson: AppStatusConverter.toJson)
      this.status = AppStatus.unknown,
      @JsonKey(fromJson: RoleConverter.fromJson, toJson: RoleConverter.toJson)
      this.role = Role.admin});
  factory _AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  @override
  @JsonKey()
  final String uId;
  @override
  @JsonKey(
      fromJson: AppStatusConverter.fromJson, toJson: AppStatusConverter.toJson)
  final AppStatus status;
  @override
  @JsonKey(fromJson: RoleConverter.fromJson, toJson: RoleConverter.toJson)
  final Role role;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppStateCopyWith<_AppState> get copyWith =>
      __$AppStateCopyWithImpl<_AppState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppState &&
            (identical(other.uId, uId) || other.uId == uId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uId, status, role);

  @override
  String toString() {
    return 'AppState(uId: $uId, status: $status, role: $role)';
  }
}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) =
      __$AppStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uId,
      @JsonKey(
          fromJson: AppStatusConverter.fromJson,
          toJson: AppStatusConverter.toJson)
      AppStatus status,
      @JsonKey(fromJson: RoleConverter.fromJson, toJson: RoleConverter.toJson)
      Role role});
}

/// @nodoc
class __$AppStateCopyWithImpl<$Res> implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uId = null,
    Object? status = null,
    Object? role = null,
  }) {
    return _then(_AppState(
      uId: null == uId
          ? _self.uId
          : uId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppStatus,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role,
    ));
  }
}

// dart format on
