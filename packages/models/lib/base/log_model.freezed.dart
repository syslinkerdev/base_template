// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LogModel {
  String get id;
  @JsonKey(
      name: 'type',
      fromJson: LogTypeConverter.fromJson,
      toJson: LogTypeConverter.toJson)
  LogType get type;
  String get message;
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  DateTime get createdAt; // Optional user info
  @JsonKey(name: 'user_id')
  String? get userId;
  @JsonKey(name: 'user_name')
  String? get userName;
  @JsonKey(
      name: 'user_role',
      fromJson: RoleConverter.fromJsonNullable,
      toJson: RoleConverter.toJsonNullable)
  Role? get userRole;
  @JsonKey(name: 'route')
  String? get route;
  @JsonKey(name: 'metadata')
  Map<String, dynamic>? get metadata;

  /// Create a copy of LogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LogModelCopyWith<LogModel> get copyWith =>
      _$LogModelCopyWithImpl<LogModel>(this as LogModel, _$identity);

  /// Serializes this LogModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userRole, userRole) ||
                other.userRole == userRole) &&
            (identical(other.route, route) || other.route == route) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      message,
      createdAt,
      userId,
      userName,
      userRole,
      route,
      const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'LogModel(id: $id, type: $type, message: $message, createdAt: $createdAt, userId: $userId, userName: $userName, userRole: $userRole, route: $route, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $LogModelCopyWith<$Res> {
  factory $LogModelCopyWith(LogModel value, $Res Function(LogModel) _then) =
      _$LogModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(
          name: 'type',
          fromJson: LogTypeConverter.fromJson,
          toJson: LogTypeConverter.toJson)
      LogType type,
      String message,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(
          name: 'user_role',
          fromJson: RoleConverter.fromJsonNullable,
          toJson: RoleConverter.toJsonNullable)
      Role? userRole,
      @JsonKey(name: 'route') String? route,
      @JsonKey(name: 'metadata') Map<String, dynamic>? metadata});
}

/// @nodoc
class _$LogModelCopyWithImpl<$Res> implements $LogModelCopyWith<$Res> {
  _$LogModelCopyWithImpl(this._self, this._then);

  final LogModel _self;
  final $Res Function(LogModel) _then;

  /// Create a copy of LogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? createdAt = null,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userRole = freezed,
    Object? route = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as LogType,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userRole: freezed == userRole
          ? _self.userRole
          : userRole // ignore: cast_nullable_to_non_nullable
              as Role?,
      route: freezed == route
          ? _self.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LogModel].
extension LogModelPatterns on LogModel {
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
    TResult Function(_LogModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LogModel() when $default != null:
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
    TResult Function(_LogModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LogModel():
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
    TResult? Function(_LogModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LogModel() when $default != null:
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
            String id,
            @JsonKey(
                name: 'type',
                fromJson: LogTypeConverter.fromJson,
                toJson: LogTypeConverter.toJson)
            LogType type,
            String message,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(name: 'user_id') String? userId,
            @JsonKey(name: 'user_name') String? userName,
            @JsonKey(
                name: 'user_role',
                fromJson: RoleConverter.fromJsonNullable,
                toJson: RoleConverter.toJsonNullable)
            Role? userRole,
            @JsonKey(name: 'route') String? route,
            @JsonKey(name: 'metadata') Map<String, dynamic>? metadata)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LogModel() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.message,
            _that.createdAt,
            _that.userId,
            _that.userName,
            _that.userRole,
            _that.route,
            _that.metadata);
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
            String id,
            @JsonKey(
                name: 'type',
                fromJson: LogTypeConverter.fromJson,
                toJson: LogTypeConverter.toJson)
            LogType type,
            String message,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(name: 'user_id') String? userId,
            @JsonKey(name: 'user_name') String? userName,
            @JsonKey(
                name: 'user_role',
                fromJson: RoleConverter.fromJsonNullable,
                toJson: RoleConverter.toJsonNullable)
            Role? userRole,
            @JsonKey(name: 'route') String? route,
            @JsonKey(name: 'metadata') Map<String, dynamic>? metadata)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LogModel():
        return $default(
            _that.id,
            _that.type,
            _that.message,
            _that.createdAt,
            _that.userId,
            _that.userName,
            _that.userRole,
            _that.route,
            _that.metadata);
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
            String id,
            @JsonKey(
                name: 'type',
                fromJson: LogTypeConverter.fromJson,
                toJson: LogTypeConverter.toJson)
            LogType type,
            String message,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(name: 'user_id') String? userId,
            @JsonKey(name: 'user_name') String? userName,
            @JsonKey(
                name: 'user_role',
                fromJson: RoleConverter.fromJsonNullable,
                toJson: RoleConverter.toJsonNullable)
            Role? userRole,
            @JsonKey(name: 'route') String? route,
            @JsonKey(name: 'metadata') Map<String, dynamic>? metadata)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LogModel() when $default != null:
        return $default(
            _that.id,
            _that.type,
            _that.message,
            _that.createdAt,
            _that.userId,
            _that.userName,
            _that.userRole,
            _that.route,
            _that.metadata);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LogModel extends LogModel {
  const _LogModel(
      {required this.id,
      @JsonKey(
          name: 'type',
          fromJson: LogTypeConverter.fromJson,
          toJson: LogTypeConverter.toJson)
      required this.type,
      required this.message,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      required this.createdAt,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(
          name: 'user_role',
          fromJson: RoleConverter.fromJsonNullable,
          toJson: RoleConverter.toJsonNullable)
      this.userRole,
      @JsonKey(name: 'route') this.route,
      @JsonKey(name: 'metadata') final Map<String, dynamic>? metadata})
      : _metadata = metadata,
        super._();
  factory _LogModel.fromJson(Map<String, dynamic> json) =>
      _$LogModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(
      name: 'type',
      fromJson: LogTypeConverter.fromJson,
      toJson: LogTypeConverter.toJson)
  final LogType type;
  @override
  final String message;
  @override
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  final DateTime createdAt;
// Optional user info
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  @JsonKey(
      name: 'user_role',
      fromJson: RoleConverter.fromJsonNullable,
      toJson: RoleConverter.toJsonNullable)
  final Role? userRole;
  @override
  @JsonKey(name: 'route')
  final String? route;
  final Map<String, dynamic>? _metadata;
  @override
  @JsonKey(name: 'metadata')
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of LogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LogModelCopyWith<_LogModel> get copyWith =>
      __$LogModelCopyWithImpl<_LogModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LogModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LogModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userRole, userRole) ||
                other.userRole == userRole) &&
            (identical(other.route, route) || other.route == route) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      message,
      createdAt,
      userId,
      userName,
      userRole,
      route,
      const DeepCollectionEquality().hash(_metadata));

  @override
  String toString() {
    return 'LogModel(id: $id, type: $type, message: $message, createdAt: $createdAt, userId: $userId, userName: $userName, userRole: $userRole, route: $route, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$LogModelCopyWith<$Res>
    implements $LogModelCopyWith<$Res> {
  factory _$LogModelCopyWith(_LogModel value, $Res Function(_LogModel) _then) =
      __$LogModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(
          name: 'type',
          fromJson: LogTypeConverter.fromJson,
          toJson: LogTypeConverter.toJson)
      LogType type,
      String message,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(
          name: 'user_role',
          fromJson: RoleConverter.fromJsonNullable,
          toJson: RoleConverter.toJsonNullable)
      Role? userRole,
      @JsonKey(name: 'route') String? route,
      @JsonKey(name: 'metadata') Map<String, dynamic>? metadata});
}

/// @nodoc
class __$LogModelCopyWithImpl<$Res> implements _$LogModelCopyWith<$Res> {
  __$LogModelCopyWithImpl(this._self, this._then);

  final _LogModel _self;
  final $Res Function(_LogModel) _then;

  /// Create a copy of LogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? createdAt = null,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userRole = freezed,
    Object? route = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_LogModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as LogType,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userRole: freezed == userRole
          ? _self.userRole
          : userRole // ignore: cast_nullable_to_non_nullable
              as Role?,
      route: freezed == route
          ? _self.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

// dart format on
