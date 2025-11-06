// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'label_with_image_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LabelWithImage {
  String get id;
  String get label;
  String get image;

  /// Create a copy of LabelWithImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LabelWithImageCopyWith<LabelWithImage> get copyWith =>
      _$LabelWithImageCopyWithImpl<LabelWithImage>(
          this as LabelWithImage, _$identity);

  /// Serializes this LabelWithImage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LabelWithImage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, image);

  @override
  String toString() {
    return 'LabelWithImage(id: $id, label: $label, image: $image)';
  }
}

/// @nodoc
abstract mixin class $LabelWithImageCopyWith<$Res> {
  factory $LabelWithImageCopyWith(
          LabelWithImage value, $Res Function(LabelWithImage) _then) =
      _$LabelWithImageCopyWithImpl;
  @useResult
  $Res call({String id, String label, String image});
}

/// @nodoc
class _$LabelWithImageCopyWithImpl<$Res>
    implements $LabelWithImageCopyWith<$Res> {
  _$LabelWithImageCopyWithImpl(this._self, this._then);

  final LabelWithImage _self;
  final $Res Function(LabelWithImage) _then;

  /// Create a copy of LabelWithImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? image = null,
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
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [LabelWithImage].
extension LabelWithImagePatterns on LabelWithImage {
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
    TResult Function(_LabelWithImage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LabelWithImage() when $default != null:
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
    TResult Function(_LabelWithImage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LabelWithImage():
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
    TResult? Function(_LabelWithImage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LabelWithImage() when $default != null:
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
    TResult Function(String id, String label, String image)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LabelWithImage() when $default != null:
        return $default(_that.id, _that.label, _that.image);
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
    TResult Function(String id, String label, String image) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LabelWithImage():
        return $default(_that.id, _that.label, _that.image);
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
    TResult? Function(String id, String label, String image)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LabelWithImage() when $default != null:
        return $default(_that.id, _that.label, _that.image);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LabelWithImage extends LabelWithImage {
  const _LabelWithImage(
      {required this.id, required this.label, required this.image})
      : super._();
  factory _LabelWithImage.fromJson(Map<String, dynamic> json) =>
      _$LabelWithImageFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String image;

  /// Create a copy of LabelWithImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LabelWithImageCopyWith<_LabelWithImage> get copyWith =>
      __$LabelWithImageCopyWithImpl<_LabelWithImage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LabelWithImageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LabelWithImage &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, label, image);

  @override
  String toString() {
    return 'LabelWithImage(id: $id, label: $label, image: $image)';
  }
}

/// @nodoc
abstract mixin class _$LabelWithImageCopyWith<$Res>
    implements $LabelWithImageCopyWith<$Res> {
  factory _$LabelWithImageCopyWith(
          _LabelWithImage value, $Res Function(_LabelWithImage) _then) =
      __$LabelWithImageCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String label, String image});
}

/// @nodoc
class __$LabelWithImageCopyWithImpl<$Res>
    implements _$LabelWithImageCopyWith<$Res> {
  __$LabelWithImageCopyWithImpl(this._self, this._then);

  final _LabelWithImage _self;
  final $Res Function(_LabelWithImage) _then;

  /// Create a copy of LabelWithImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? image = null,
  }) {
    return _then(_LabelWithImage(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
