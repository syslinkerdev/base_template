// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompanyEntry _$CompanyEntryFromJson(Map<String, dynamic> json) =>
    _CompanyEntry(
      companyId: json['company_id'] as String,
      companyName: json['company_name'] as String,
      total: (json['total'] as num).toDouble(),
      totalAfterDis: (json['total_after_dis'] as num).toDouble(),
      prodCount: (json['prod_count'] as num).toInt(),
      clientCount: (json['client_count'] as num).toInt(),
      createdAt: TimeStampConverter.fromJson(json['created_at']),
    );

Map<String, dynamic> _$CompanyEntryToJson(_CompanyEntry instance) =>
    <String, dynamic>{
      'company_id': instance.companyId,
      'company_name': instance.companyName,
      'total': instance.total,
      'total_after_dis': instance.totalAfterDis,
      'prod_count': instance.prodCount,
      'client_count': instance.clientCount,
      'created_at': instance.createdAt.toIso8601String(),
    };
