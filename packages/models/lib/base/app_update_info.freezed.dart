// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_update_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUpdateInfo {
  @JsonKey(name: 'app_name')
  String get appName; // the identifier of the app (e.g., "orders")
  String get version; // the latest version string (e.g., "v1.2.0")
  String get url;

  /// Create a copy of AppUpdateInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppUpdateInfoCopyWith<AppUpdateInfo> get copyWith =>
      _$AppUpdateInfoCopyWithImpl<AppUpdateInfo>(
          this as AppUpdateInfo, _$identity);

  /// Serializes this AppUpdateInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppUpdateInfo &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appName, version, url);

  @override
  String toString() {
    return 'AppUpdateInfo(appName: $appName, version: $version, url: $url)';
  }
}

/// @nodoc
abstract mixin class $AppUpdateInfoCopyWith<$Res> {
  factory $AppUpdateInfoCopyWith(
          AppUpdateInfo value, $Res Function(AppUpdateInfo) _then) =
      _$AppUpdateInfoCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'app_name') String appName, String version, String url});
}

/// @nodoc
class _$AppUpdateInfoCopyWithImpl<$Res>
    implements $AppUpdateInfoCopyWith<$Res> {
  _$AppUpdateInfoCopyWithImpl(this._self, this._then);

  final AppUpdateInfo _self;
  final $Res Function(AppUpdateInfo) _then;

  /// Create a copy of AppUpdateInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appName = null,
    Object? version = null,
    Object? url = null,
  }) {
    return _then(_self.copyWith(
      appName: null == appName
          ? _self.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppUpdateInfo].
extension AppUpdateInfoPatterns on AppUpdateInfo {
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
    TResult Function(_AppUpdateInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppUpdateInfo() when $default != null:
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
    TResult Function(_AppUpdateInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUpdateInfo():
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
    TResult? Function(_AppUpdateInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUpdateInfo() when $default != null:
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
    TResult Function(@JsonKey(name: 'app_name') String appName, String version,
            String url)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppUpdateInfo() when $default != null:
        return $default(_that.appName, _that.version, _that.url);
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
    TResult Function(@JsonKey(name: 'app_name') String appName, String version,
            String url)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUpdateInfo():
        return $default(_that.appName, _that.version, _that.url);
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
    TResult? Function(@JsonKey(name: 'app_name') String appName, String version,
            String url)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUpdateInfo() when $default != null:
        return $default(_that.appName, _that.version, _that.url);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppUpdateInfo extends AppUpdateInfo {
  _AppUpdateInfo(
      {@JsonKey(name: 'app_name') required this.appName,
      required this.version,
      required this.url})
      : super._();
  factory _AppUpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateInfoFromJson(json);

  @override
  @JsonKey(name: 'app_name')
  final String appName;
// the identifier of the app (e.g., "orders")
  @override
  final String version;
// the latest version string (e.g., "v1.2.0")
  @override
  final String url;

  /// Create a copy of AppUpdateInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppUpdateInfoCopyWith<_AppUpdateInfo> get copyWith =>
      __$AppUpdateInfoCopyWithImpl<_AppUpdateInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppUpdateInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppUpdateInfo &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appName, version, url);

  @override
  String toString() {
    return 'AppUpdateInfo(appName: $appName, version: $version, url: $url)';
  }
}

/// @nodoc
abstract mixin class _$AppUpdateInfoCopyWith<$Res>
    implements $AppUpdateInfoCopyWith<$Res> {
  factory _$AppUpdateInfoCopyWith(
          _AppUpdateInfo value, $Res Function(_AppUpdateInfo) _then) =
      __$AppUpdateInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'app_name') String appName, String version, String url});
}

/// @nodoc
class __$AppUpdateInfoCopyWithImpl<$Res>
    implements _$AppUpdateInfoCopyWith<$Res> {
  __$AppUpdateInfoCopyWithImpl(this._self, this._then);

  final _AppUpdateInfo _self;
  final $Res Function(_AppUpdateInfo) _then;

  /// Create a copy of AppUpdateInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? appName = null,
    Object? version = null,
    Object? url = null,
  }) {
    return _then(_AppUpdateInfo(
      appName: null == appName
          ? _self.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
