// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
UserX _$UserXFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$UserX {
  @JsonKey(name: 'uid')
  String get uid; // over
  @JsonKey(
      name: 'role',
      fromJson: RoleConverter.fromJsonNullable,
      toJson: RoleConverter.toJsonNullable)
  Role? get role; // over
  @JsonKey(name: 'first_name')
  String get firstName; // over
  @JsonKey(name: 'last_name')
  String get lastName; // over
  @JsonKey(name: 'phone_number')
  String get phoneNumber; // over
// new section over
  @JsonKey(name: 'shop_name')
  String get shopName;
  @JsonKey(name: 'shop_address')
  Address get shopAddress; //
  @JsonKey(name: 'superuser_uid')
  String get superuserUid;
  @JsonKey(name: 'avatar')
  String get avatar; // over
  @JsonKey(name: 'hashed_password')
  String? get hashedPassword;
  @JsonKey(name: 'access_code')
  String get accessCode; // new section over
  @JsonKey(name: 'is_given')
  bool get isGiven;
  @JsonKey(name: 'dis_section')
  DiscountSection? get disSection; // new section
  @JsonKey(name: 'service_charges')
  double get serviceCharges;
  @JsonKey(name: 'basket_limit_no')
  int? get basketLimitNo; // over
  @JsonKey(name: 'smart_baskets')
  List<SmartBasket>? get smartBaskets; // over
  @JsonKey(
      name: 'status',
      fromJson: UserStatusConverter.fromJsonNullable,
      toJson: UserStatusConverter.toJsonNullable)
  UserStatus? get status; // over
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  DateTime get createdAt; // over
  @JsonKey(name: 'deleted_at', fromJson: TimeStampConverter.fromJsonNullable)
  DateTime? get deletedAt;
  @JsonKey(
      name: 'deleted_by',
      fromJson: RoleConverter.fromJsonNullable,
      toJson: RoleConverter.toJsonNullable)
  Role? get deletedBy;
  @JsonKey(name: 'replaced_by')
  String? get replacedBy;
  @JsonKey(name: 'previous_uids')
  List<String>? get previousUids;

  /// Create a copy of UserX
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserXCopyWith<UserX> get copyWith =>
      _$UserXCopyWithImpl<UserX>(this as UserX, _$identity);

  /// Serializes this UserX to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserX &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName) &&
            (identical(other.shopAddress, shopAddress) ||
                other.shopAddress == shopAddress) &&
            (identical(other.superuserUid, superuserUid) ||
                other.superuserUid == superuserUid) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.hashedPassword, hashedPassword) ||
                other.hashedPassword == hashedPassword) &&
            (identical(other.accessCode, accessCode) ||
                other.accessCode == accessCode) &&
            (identical(other.isGiven, isGiven) || other.isGiven == isGiven) &&
            (identical(other.disSection, disSection) ||
                other.disSection == disSection) &&
            (identical(other.serviceCharges, serviceCharges) ||
                other.serviceCharges == serviceCharges) &&
            (identical(other.basketLimitNo, basketLimitNo) ||
                other.basketLimitNo == basketLimitNo) &&
            const DeepCollectionEquality()
                .equals(other.smartBaskets, smartBaskets) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.deletedBy, deletedBy) ||
                other.deletedBy == deletedBy) &&
            (identical(other.replacedBy, replacedBy) ||
                other.replacedBy == replacedBy) &&
            const DeepCollectionEquality()
                .equals(other.previousUids, previousUids));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        uid,
        role,
        firstName,
        lastName,
        phoneNumber,
        shopName,
        shopAddress,
        superuserUid,
        avatar,
        hashedPassword,
        accessCode,
        isGiven,
        disSection,
        serviceCharges,
        basketLimitNo,
        const DeepCollectionEquality().hash(smartBaskets),
        status,
        createdAt,
        deletedAt,
        deletedBy,
        replacedBy,
        const DeepCollectionEquality().hash(previousUids)
      ]);

  @override
  String toString() {
    return 'UserX(uid: $uid, role: $role, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, shopName: $shopName, shopAddress: $shopAddress, superuserUid: $superuserUid, avatar: $avatar, hashedPassword: $hashedPassword, accessCode: $accessCode, isGiven: $isGiven, disSection: $disSection, serviceCharges: $serviceCharges, basketLimitNo: $basketLimitNo, smartBaskets: $smartBaskets, status: $status, createdAt: $createdAt, deletedAt: $deletedAt, deletedBy: $deletedBy, replacedBy: $replacedBy, previousUids: $previousUids)';
  }
}

/// @nodoc
abstract mixin class $UserXCopyWith<$Res> {
  factory $UserXCopyWith(UserX value, $Res Function(UserX) _then) =
      _$UserXCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'uid') String uid,
      @JsonKey(
          name: 'role',
          fromJson: RoleConverter.fromJsonNullable,
          toJson: RoleConverter.toJsonNullable)
      Role? role,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      @JsonKey(name: 'phone_number') String phoneNumber,
      @JsonKey(name: 'shop_name') String shopName,
      @JsonKey(name: 'shop_address') Address shopAddress,
      @JsonKey(name: 'superuser_uid') String superuserUid,
      @JsonKey(name: 'avatar') String avatar,
      @JsonKey(name: 'hashed_password') String? hashedPassword,
      @JsonKey(name: 'access_code') String accessCode,
      @JsonKey(name: 'is_given') bool isGiven,
      @JsonKey(name: 'dis_section') DiscountSection? disSection,
      @JsonKey(name: 'service_charges') double serviceCharges,
      @JsonKey(name: 'basket_limit_no') int? basketLimitNo,
      @JsonKey(name: 'smart_baskets') List<SmartBasket>? smartBaskets,
      @JsonKey(
          name: 'status',
          fromJson: UserStatusConverter.fromJsonNullable,
          toJson: UserStatusConverter.toJsonNullable)
      UserStatus? status,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(
          name: 'deleted_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? deletedAt,
      @JsonKey(
          name: 'deleted_by',
          fromJson: RoleConverter.fromJsonNullable,
          toJson: RoleConverter.toJsonNullable)
      Role? deletedBy,
      @JsonKey(name: 'replaced_by') String? replacedBy,
      @JsonKey(name: 'previous_uids') List<String>? previousUids});

  $AddressCopyWith<$Res> get shopAddress;
  $DiscountSectionCopyWith<$Res>? get disSection;
}

/// @nodoc
class _$UserXCopyWithImpl<$Res> implements $UserXCopyWith<$Res> {
  _$UserXCopyWithImpl(this._self, this._then);

  final UserX _self;
  final $Res Function(UserX) _then;

  /// Create a copy of UserX
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? role = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? phoneNumber = null,
    Object? shopName = null,
    Object? shopAddress = null,
    Object? superuserUid = null,
    Object? avatar = null,
    Object? hashedPassword = freezed,
    Object? accessCode = null,
    Object? isGiven = null,
    Object? disSection = freezed,
    Object? serviceCharges = null,
    Object? basketLimitNo = freezed,
    Object? smartBaskets = freezed,
    Object? status = freezed,
    Object? createdAt = null,
    Object? deletedAt = freezed,
    Object? deletedBy = freezed,
    Object? replacedBy = freezed,
    Object? previousUids = freezed,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      role: freezed == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role?,
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      shopName: null == shopName
          ? _self.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      shopAddress: null == shopAddress
          ? _self.shopAddress
          : shopAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      superuserUid: null == superuserUid
          ? _self.superuserUid
          : superuserUid // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      hashedPassword: freezed == hashedPassword
          ? _self.hashedPassword
          : hashedPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      accessCode: null == accessCode
          ? _self.accessCode
          : accessCode // ignore: cast_nullable_to_non_nullable
              as String,
      isGiven: null == isGiven
          ? _self.isGiven
          : isGiven // ignore: cast_nullable_to_non_nullable
              as bool,
      disSection: freezed == disSection
          ? _self.disSection
          : disSection // ignore: cast_nullable_to_non_nullable
              as DiscountSection?,
      serviceCharges: null == serviceCharges
          ? _self.serviceCharges
          : serviceCharges // ignore: cast_nullable_to_non_nullable
              as double,
      basketLimitNo: freezed == basketLimitNo
          ? _self.basketLimitNo
          : basketLimitNo // ignore: cast_nullable_to_non_nullable
              as int?,
      smartBaskets: freezed == smartBaskets
          ? _self.smartBaskets
          : smartBaskets // ignore: cast_nullable_to_non_nullable
              as List<SmartBasket>?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedBy: freezed == deletedBy
          ? _self.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as Role?,
      replacedBy: freezed == replacedBy
          ? _self.replacedBy
          : replacedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      previousUids: freezed == previousUids
          ? _self.previousUids
          : previousUids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }

  /// Create a copy of UserX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get shopAddress {
    return $AddressCopyWith<$Res>(_self.shopAddress, (value) {
      return _then(_self.copyWith(shopAddress: value));
    });
  }

  /// Create a copy of UserX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscountSectionCopyWith<$Res>? get disSection {
    if (_self.disSection == null) {
      return null;
    }

    return $DiscountSectionCopyWith<$Res>(_self.disSection!, (value) {
      return _then(_self.copyWith(disSection: value));
    });
  }
}

/// Adds pattern-matching-related methods to [UserX].
extension UserXPatterns on UserX {
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
    TResult Function(_User value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
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
    TResult Function(_User value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User():
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
    TResult? Function(_User value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
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
            @JsonKey(name: 'uid') String uid,
            @JsonKey(
                name: 'role',
                fromJson: RoleConverter.fromJsonNullable,
                toJson: RoleConverter.toJsonNullable)
            Role? role,
            @JsonKey(name: 'first_name') String firstName,
            @JsonKey(name: 'last_name') String lastName,
            @JsonKey(name: 'phone_number') String phoneNumber,
            @JsonKey(name: 'shop_name') String shopName,
            @JsonKey(name: 'shop_address') Address shopAddress,
            @JsonKey(name: 'superuser_uid') String superuserUid,
            @JsonKey(name: 'avatar') String avatar,
            @JsonKey(name: 'hashed_password') String? hashedPassword,
            @JsonKey(name: 'access_code') String accessCode,
            @JsonKey(name: 'is_given') bool isGiven,
            @JsonKey(name: 'dis_section') DiscountSection? disSection,
            @JsonKey(name: 'service_charges') double serviceCharges,
            @JsonKey(name: 'basket_limit_no') int? basketLimitNo,
            @JsonKey(name: 'smart_baskets') List<SmartBasket>? smartBaskets,
            @JsonKey(
                name: 'status',
                fromJson: UserStatusConverter.fromJsonNullable,
                toJson: UserStatusConverter.toJsonNullable)
            UserStatus? status,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(
                name: 'deleted_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? deletedAt,
            @JsonKey(
                name: 'deleted_by',
                fromJson: RoleConverter.fromJsonNullable,
                toJson: RoleConverter.toJsonNullable)
            Role? deletedBy,
            @JsonKey(name: 'replaced_by') String? replacedBy,
            @JsonKey(name: 'previous_uids') List<String>? previousUids)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
        return $default(
            _that.uid,
            _that.role,
            _that.firstName,
            _that.lastName,
            _that.phoneNumber,
            _that.shopName,
            _that.shopAddress,
            _that.superuserUid,
            _that.avatar,
            _that.hashedPassword,
            _that.accessCode,
            _that.isGiven,
            _that.disSection,
            _that.serviceCharges,
            _that.basketLimitNo,
            _that.smartBaskets,
            _that.status,
            _that.createdAt,
            _that.deletedAt,
            _that.deletedBy,
            _that.replacedBy,
            _that.previousUids);
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
            @JsonKey(name: 'uid') String uid,
            @JsonKey(
                name: 'role',
                fromJson: RoleConverter.fromJsonNullable,
                toJson: RoleConverter.toJsonNullable)
            Role? role,
            @JsonKey(name: 'first_name') String firstName,
            @JsonKey(name: 'last_name') String lastName,
            @JsonKey(name: 'phone_number') String phoneNumber,
            @JsonKey(name: 'shop_name') String shopName,
            @JsonKey(name: 'shop_address') Address shopAddress,
            @JsonKey(name: 'superuser_uid') String superuserUid,
            @JsonKey(name: 'avatar') String avatar,
            @JsonKey(name: 'hashed_password') String? hashedPassword,
            @JsonKey(name: 'access_code') String accessCode,
            @JsonKey(name: 'is_given') bool isGiven,
            @JsonKey(name: 'dis_section') DiscountSection? disSection,
            @JsonKey(name: 'service_charges') double serviceCharges,
            @JsonKey(name: 'basket_limit_no') int? basketLimitNo,
            @JsonKey(name: 'smart_baskets') List<SmartBasket>? smartBaskets,
            @JsonKey(
                name: 'status',
                fromJson: UserStatusConverter.fromJsonNullable,
                toJson: UserStatusConverter.toJsonNullable)
            UserStatus? status,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(
                name: 'deleted_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? deletedAt,
            @JsonKey(
                name: 'deleted_by',
                fromJson: RoleConverter.fromJsonNullable,
                toJson: RoleConverter.toJsonNullable)
            Role? deletedBy,
            @JsonKey(name: 'replaced_by') String? replacedBy,
            @JsonKey(name: 'previous_uids') List<String>? previousUids)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User():
        return $default(
            _that.uid,
            _that.role,
            _that.firstName,
            _that.lastName,
            _that.phoneNumber,
            _that.shopName,
            _that.shopAddress,
            _that.superuserUid,
            _that.avatar,
            _that.hashedPassword,
            _that.accessCode,
            _that.isGiven,
            _that.disSection,
            _that.serviceCharges,
            _that.basketLimitNo,
            _that.smartBaskets,
            _that.status,
            _that.createdAt,
            _that.deletedAt,
            _that.deletedBy,
            _that.replacedBy,
            _that.previousUids);
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
            @JsonKey(name: 'uid') String uid,
            @JsonKey(
                name: 'role',
                fromJson: RoleConverter.fromJsonNullable,
                toJson: RoleConverter.toJsonNullable)
            Role? role,
            @JsonKey(name: 'first_name') String firstName,
            @JsonKey(name: 'last_name') String lastName,
            @JsonKey(name: 'phone_number') String phoneNumber,
            @JsonKey(name: 'shop_name') String shopName,
            @JsonKey(name: 'shop_address') Address shopAddress,
            @JsonKey(name: 'superuser_uid') String superuserUid,
            @JsonKey(name: 'avatar') String avatar,
            @JsonKey(name: 'hashed_password') String? hashedPassword,
            @JsonKey(name: 'access_code') String accessCode,
            @JsonKey(name: 'is_given') bool isGiven,
            @JsonKey(name: 'dis_section') DiscountSection? disSection,
            @JsonKey(name: 'service_charges') double serviceCharges,
            @JsonKey(name: 'basket_limit_no') int? basketLimitNo,
            @JsonKey(name: 'smart_baskets') List<SmartBasket>? smartBaskets,
            @JsonKey(
                name: 'status',
                fromJson: UserStatusConverter.fromJsonNullable,
                toJson: UserStatusConverter.toJsonNullable)
            UserStatus? status,
            @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
            DateTime createdAt,
            @JsonKey(
                name: 'deleted_at',
                fromJson: TimeStampConverter.fromJsonNullable)
            DateTime? deletedAt,
            @JsonKey(
                name: 'deleted_by',
                fromJson: RoleConverter.fromJsonNullable,
                toJson: RoleConverter.toJsonNullable)
            Role? deletedBy,
            @JsonKey(name: 'replaced_by') String? replacedBy,
            @JsonKey(name: 'previous_uids') List<String>? previousUids)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _User() when $default != null:
        return $default(
            _that.uid,
            _that.role,
            _that.firstName,
            _that.lastName,
            _that.phoneNumber,
            _that.shopName,
            _that.shopAddress,
            _that.superuserUid,
            _that.avatar,
            _that.hashedPassword,
            _that.accessCode,
            _that.isGiven,
            _that.disSection,
            _that.serviceCharges,
            _that.basketLimitNo,
            _that.smartBaskets,
            _that.status,
            _that.createdAt,
            _that.deletedAt,
            _that.deletedBy,
            _that.replacedBy,
            _that.previousUids);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _User extends UserX {
  const _User(
      {@JsonKey(name: 'uid') required this.uid,
      @JsonKey(
          name: 'role',
          fromJson: RoleConverter.fromJsonNullable,
          toJson: RoleConverter.toJsonNullable)
      this.role,
      @JsonKey(name: 'first_name') required this.firstName,
      @JsonKey(name: 'last_name') required this.lastName,
      @JsonKey(name: 'phone_number') required this.phoneNumber,
      @JsonKey(name: 'shop_name') required this.shopName,
      @JsonKey(name: 'shop_address') required this.shopAddress,
      @JsonKey(name: 'superuser_uid') required this.superuserUid,
      @JsonKey(name: 'avatar') required this.avatar,
      @JsonKey(name: 'hashed_password') this.hashedPassword,
      @JsonKey(name: 'access_code') required this.accessCode,
      @JsonKey(name: 'is_given') required this.isGiven,
      @JsonKey(name: 'dis_section') required this.disSection,
      @JsonKey(name: 'service_charges') required this.serviceCharges,
      @JsonKey(name: 'basket_limit_no') this.basketLimitNo,
      @JsonKey(name: 'smart_baskets') final List<SmartBasket>? smartBaskets,
      @JsonKey(
          name: 'status',
          fromJson: UserStatusConverter.fromJsonNullable,
          toJson: UserStatusConverter.toJsonNullable)
      this.status,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      required this.createdAt,
      @JsonKey(
          name: 'deleted_at', fromJson: TimeStampConverter.fromJsonNullable)
      this.deletedAt,
      @JsonKey(
          name: 'deleted_by',
          fromJson: RoleConverter.fromJsonNullable,
          toJson: RoleConverter.toJsonNullable)
      this.deletedBy,
      @JsonKey(name: 'replaced_by') this.replacedBy,
      @JsonKey(name: 'previous_uids') final List<String>? previousUids})
      : _smartBaskets = smartBaskets,
        _previousUids = previousUids,
        super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  @JsonKey(name: 'uid')
  final String uid;
// over
  @override
  @JsonKey(
      name: 'role',
      fromJson: RoleConverter.fromJsonNullable,
      toJson: RoleConverter.toJsonNullable)
  final Role? role;
// over
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
// over
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
// over
  @override
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
// over
// new section over
  @override
  @JsonKey(name: 'shop_name')
  final String shopName;
  @override
  @JsonKey(name: 'shop_address')
  final Address shopAddress;
//
  @override
  @JsonKey(name: 'superuser_uid')
  final String superuserUid;
  @override
  @JsonKey(name: 'avatar')
  final String avatar;
// over
  @override
  @JsonKey(name: 'hashed_password')
  final String? hashedPassword;
  @override
  @JsonKey(name: 'access_code')
  final String accessCode;
// new section over
  @override
  @JsonKey(name: 'is_given')
  final bool isGiven;
  @override
  @JsonKey(name: 'dis_section')
  final DiscountSection? disSection;
// new section
  @override
  @JsonKey(name: 'service_charges')
  final double serviceCharges;
  @override
  @JsonKey(name: 'basket_limit_no')
  final int? basketLimitNo;
// over
  final List<SmartBasket>? _smartBaskets;
// over
  @override
  @JsonKey(name: 'smart_baskets')
  List<SmartBasket>? get smartBaskets {
    final value = _smartBaskets;
    if (value == null) return null;
    if (_smartBaskets is EqualUnmodifiableListView) return _smartBaskets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// over
  @override
  @JsonKey(
      name: 'status',
      fromJson: UserStatusConverter.fromJsonNullable,
      toJson: UserStatusConverter.toJsonNullable)
  final UserStatus? status;
// over
  @override
  @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
  final DateTime createdAt;
// over
  @override
  @JsonKey(name: 'deleted_at', fromJson: TimeStampConverter.fromJsonNullable)
  final DateTime? deletedAt;
  @override
  @JsonKey(
      name: 'deleted_by',
      fromJson: RoleConverter.fromJsonNullable,
      toJson: RoleConverter.toJsonNullable)
  final Role? deletedBy;
  @override
  @JsonKey(name: 'replaced_by')
  final String? replacedBy;
  final List<String>? _previousUids;
  @override
  @JsonKey(name: 'previous_uids')
  List<String>? get previousUids {
    final value = _previousUids;
    if (value == null) return null;
    if (_previousUids is EqualUnmodifiableListView) return _previousUids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of UserX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName) &&
            (identical(other.shopAddress, shopAddress) ||
                other.shopAddress == shopAddress) &&
            (identical(other.superuserUid, superuserUid) ||
                other.superuserUid == superuserUid) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.hashedPassword, hashedPassword) ||
                other.hashedPassword == hashedPassword) &&
            (identical(other.accessCode, accessCode) ||
                other.accessCode == accessCode) &&
            (identical(other.isGiven, isGiven) || other.isGiven == isGiven) &&
            (identical(other.disSection, disSection) ||
                other.disSection == disSection) &&
            (identical(other.serviceCharges, serviceCharges) ||
                other.serviceCharges == serviceCharges) &&
            (identical(other.basketLimitNo, basketLimitNo) ||
                other.basketLimitNo == basketLimitNo) &&
            const DeepCollectionEquality()
                .equals(other._smartBaskets, _smartBaskets) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.deletedBy, deletedBy) ||
                other.deletedBy == deletedBy) &&
            (identical(other.replacedBy, replacedBy) ||
                other.replacedBy == replacedBy) &&
            const DeepCollectionEquality()
                .equals(other._previousUids, _previousUids));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        uid,
        role,
        firstName,
        lastName,
        phoneNumber,
        shopName,
        shopAddress,
        superuserUid,
        avatar,
        hashedPassword,
        accessCode,
        isGiven,
        disSection,
        serviceCharges,
        basketLimitNo,
        const DeepCollectionEquality().hash(_smartBaskets),
        status,
        createdAt,
        deletedAt,
        deletedBy,
        replacedBy,
        const DeepCollectionEquality().hash(_previousUids)
      ]);

  @override
  String toString() {
    return 'UserX(uid: $uid, role: $role, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, shopName: $shopName, shopAddress: $shopAddress, superuserUid: $superuserUid, avatar: $avatar, hashedPassword: $hashedPassword, accessCode: $accessCode, isGiven: $isGiven, disSection: $disSection, serviceCharges: $serviceCharges, basketLimitNo: $basketLimitNo, smartBaskets: $smartBaskets, status: $status, createdAt: $createdAt, deletedAt: $deletedAt, deletedBy: $deletedBy, replacedBy: $replacedBy, previousUids: $previousUids)';
  }
}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserXCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) =
      __$UserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'uid') String uid,
      @JsonKey(
          name: 'role',
          fromJson: RoleConverter.fromJsonNullable,
          toJson: RoleConverter.toJsonNullable)
      Role? role,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'last_name') String lastName,
      @JsonKey(name: 'phone_number') String phoneNumber,
      @JsonKey(name: 'shop_name') String shopName,
      @JsonKey(name: 'shop_address') Address shopAddress,
      @JsonKey(name: 'superuser_uid') String superuserUid,
      @JsonKey(name: 'avatar') String avatar,
      @JsonKey(name: 'hashed_password') String? hashedPassword,
      @JsonKey(name: 'access_code') String accessCode,
      @JsonKey(name: 'is_given') bool isGiven,
      @JsonKey(name: 'dis_section') DiscountSection? disSection,
      @JsonKey(name: 'service_charges') double serviceCharges,
      @JsonKey(name: 'basket_limit_no') int? basketLimitNo,
      @JsonKey(name: 'smart_baskets') List<SmartBasket>? smartBaskets,
      @JsonKey(
          name: 'status',
          fromJson: UserStatusConverter.fromJsonNullable,
          toJson: UserStatusConverter.toJsonNullable)
      UserStatus? status,
      @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
      DateTime createdAt,
      @JsonKey(
          name: 'deleted_at', fromJson: TimeStampConverter.fromJsonNullable)
      DateTime? deletedAt,
      @JsonKey(
          name: 'deleted_by',
          fromJson: RoleConverter.fromJsonNullable,
          toJson: RoleConverter.toJsonNullable)
      Role? deletedBy,
      @JsonKey(name: 'replaced_by') String? replacedBy,
      @JsonKey(name: 'previous_uids') List<String>? previousUids});

  @override
  $AddressCopyWith<$Res> get shopAddress;
  @override
  $DiscountSectionCopyWith<$Res>? get disSection;
}

/// @nodoc
class __$UserCopyWithImpl<$Res> implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

  /// Create a copy of UserX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? role = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? phoneNumber = null,
    Object? shopName = null,
    Object? shopAddress = null,
    Object? superuserUid = null,
    Object? avatar = null,
    Object? hashedPassword = freezed,
    Object? accessCode = null,
    Object? isGiven = null,
    Object? disSection = freezed,
    Object? serviceCharges = null,
    Object? basketLimitNo = freezed,
    Object? smartBaskets = freezed,
    Object? status = freezed,
    Object? createdAt = null,
    Object? deletedAt = freezed,
    Object? deletedBy = freezed,
    Object? replacedBy = freezed,
    Object? previousUids = freezed,
  }) {
    return _then(_User(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      role: freezed == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as Role?,
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      shopName: null == shopName
          ? _self.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      shopAddress: null == shopAddress
          ? _self.shopAddress
          : shopAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      superuserUid: null == superuserUid
          ? _self.superuserUid
          : superuserUid // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      hashedPassword: freezed == hashedPassword
          ? _self.hashedPassword
          : hashedPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      accessCode: null == accessCode
          ? _self.accessCode
          : accessCode // ignore: cast_nullable_to_non_nullable
              as String,
      isGiven: null == isGiven
          ? _self.isGiven
          : isGiven // ignore: cast_nullable_to_non_nullable
              as bool,
      disSection: freezed == disSection
          ? _self.disSection
          : disSection // ignore: cast_nullable_to_non_nullable
              as DiscountSection?,
      serviceCharges: null == serviceCharges
          ? _self.serviceCharges
          : serviceCharges // ignore: cast_nullable_to_non_nullable
              as double,
      basketLimitNo: freezed == basketLimitNo
          ? _self.basketLimitNo
          : basketLimitNo // ignore: cast_nullable_to_non_nullable
              as int?,
      smartBaskets: freezed == smartBaskets
          ? _self._smartBaskets
          : smartBaskets // ignore: cast_nullable_to_non_nullable
              as List<SmartBasket>?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedBy: freezed == deletedBy
          ? _self.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as Role?,
      replacedBy: freezed == replacedBy
          ? _self.replacedBy
          : replacedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      previousUids: freezed == previousUids
          ? _self._previousUids
          : previousUids // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }

  /// Create a copy of UserX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get shopAddress {
    return $AddressCopyWith<$Res>(_self.shopAddress, (value) {
      return _then(_self.copyWith(shopAddress: value));
    });
  }

  /// Create a copy of UserX
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscountSectionCopyWith<$Res>? get disSection {
    if (_self.disSection == null) {
      return null;
    }

    return $DiscountSectionCopyWith<$Res>(_self.disSection!, (value) {
      return _then(_self.copyWith(disSection: value));
    });
  }
}

// dart format on
