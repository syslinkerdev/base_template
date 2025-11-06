// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      uid: json['uid'] as String,
      role: RoleConverter.fromJsonNullable(json['role']),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      shopName: json['shop_name'] as String,
      shopAddress:
          Address.fromJson(json['shop_address'] as Map<String, dynamic>),
      superuserUid: json['superuser_uid'] as String,
      avatar: json['avatar'] as String,
      hashedPassword: json['hashed_password'] as String?,
      accessCode: json['access_code'] as String,
      isGiven: json['is_given'] as bool,
      disSection: json['dis_section'] == null
          ? null
          : DiscountSection.fromJson(
              json['dis_section'] as Map<String, dynamic>),
      serviceCharges: (json['service_charges'] as num).toDouble(),
      basketLimitNo: (json['basket_limit_no'] as num?)?.toInt(),
      smartBaskets: (json['smart_baskets'] as List<dynamic>?)
          ?.map((e) => SmartBasket.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: UserStatusConverter.fromJsonNullable(json['status']),
      createdAt: TimeStampConverter.fromJson(json['created_at']),
      deletedAt: TimeStampConverter.fromJsonNullable(json['deleted_at']),
      deletedBy: RoleConverter.fromJsonNullable(json['deleted_by']),
      replacedBy: json['replaced_by'] as String?,
      previousUids: (json['previous_uids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      'uid': instance.uid,
      'role': RoleConverter.toJsonNullable(instance.role),
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'shop_name': instance.shopName,
      'shop_address': instance.shopAddress,
      'superuser_uid': instance.superuserUid,
      'avatar': instance.avatar,
      'hashed_password': instance.hashedPassword,
      'access_code': instance.accessCode,
      'is_given': instance.isGiven,
      'dis_section': instance.disSection,
      'service_charges': instance.serviceCharges,
      'basket_limit_no': instance.basketLimitNo,
      'smart_baskets': instance.smartBaskets,
      'status': UserStatusConverter.toJsonNullable(instance.status),
      'created_at': instance.createdAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'deleted_by': RoleConverter.toJsonNullable(instance.deletedBy),
      'replaced_by': instance.replacedBy,
      'previous_uids': instance.previousUids,
    };
