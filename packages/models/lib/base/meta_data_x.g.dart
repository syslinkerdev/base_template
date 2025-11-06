// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_data_x.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MetaData _$MetaDataFromJson(Map<String, dynamic> json) => _MetaData(
      createdAt: TimeStampConverter.fromJsonNullable(json['created_at']),
      createdBy: json['created_by'] as String?,
      updatedAt: TimeStampConverter.fromJsonNullable(json['updated_at']),
      updatedBy: json['updated_by'] as String?,
    );

Map<String, dynamic> _$MetaDataToJson(_MetaData instance) => <String, dynamic>{
      'created_at': instance.createdAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'updated_by': instance.updatedBy,
    };
