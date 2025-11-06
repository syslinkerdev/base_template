// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Address _$AddressFromJson(Map<String, dynamic> json) => _Address(
      stateName: json['state_name'] as String,
      city: json['city'] as String,
      locality: json['locality'] as String,
      pinCode: json['pin_code'] as String,
      street: json['street'] as String,
      buildingNumber: json['building_number'] as String,
    );

Map<String, dynamic> _$AddressToJson(_Address instance) => <String, dynamic>{
      'state_name': instance.stateName,
      'city': instance.city,
      'locality': instance.locality,
      'pin_code': instance.pinCode,
      'street': instance.street,
      'building_number': instance.buildingNumber,
    };
