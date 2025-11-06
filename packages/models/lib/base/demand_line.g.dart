// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demand_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DemandLine _$DemandLineFromJson(Map<String, dynamic> json) => _DemandLine(
      createdAt: TimeStampConverter.fromJson(json['created_at']),
      orderId: json['order_id'] as String,
      companyId: json['company_id'] as String,
      companyName: json['company_name'] as String,
      clientId: json['client_id'] as String,
      clientName: json['client_name'] as String,
      shopName: json['shop_name'] as String,
      shopAddress:
          Address.fromJson(json['shop_address'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => DemandLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      clientTotal: (json['client_total'] as num).toDouble(),
    );

Map<String, dynamic> _$DemandLineToJson(_DemandLine instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'order_id': instance.orderId,
      'company_id': instance.companyId,
      'company_name': instance.companyName,
      'client_id': instance.clientId,
      'client_name': instance.clientName,
      'shop_name': instance.shopName,
      'shop_address': instance.shopAddress,
      'products': instance.products,
      'client_total': instance.clientTotal,
    };
