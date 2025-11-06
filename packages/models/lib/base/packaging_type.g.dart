// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PackagingType _$PackagingTypeFromJson(Map<String, dynamic> json) =>
    _PackagingType(
      id: json['id'] as String,
      label: json['label'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$PackagingTypeToJson(_PackagingType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'quantity': instance.quantity,
    };
