// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MainOrder _$MainOrderFromJson(Map<String, dynamic> json) => _MainOrder(
      mainOrderId: json['main_order_id'] as String,
      deliveryDate: TimeStampConverter.fromJson(json['delivery_date']),
      companies: (json['companies'] as List<dynamic>)
          .map((e) => CompanyEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      overallTotal: (json['overall_total'] as num).toDouble(),
      overallTotalAfterDis: (json['overall_total_after_dis'] as num).toDouble(),
      serviceCharges: (json['service_charges'] as num).toDouble(),
      noOfProducts: (json['no_of_products'] as num).toInt(),
      noOfClients: (json['no_of_clients'] as num).toInt(),
      generatedBy: json['generated_by'] as String,
      createdAt: TimeStampConverter.fromJson(json['created_at']),
    );

Map<String, dynamic> _$MainOrderToJson(_MainOrder instance) =>
    <String, dynamic>{
      'main_order_id': instance.mainOrderId,
      'delivery_date': instance.deliveryDate.toIso8601String(),
      'companies': instance.companies,
      'overall_total': instance.overallTotal,
      'overall_total_after_dis': instance.overallTotalAfterDis,
      'service_charges': instance.serviceCharges,
      'no_of_products': instance.noOfProducts,
      'no_of_clients': instance.noOfClients,
      'generated_by': instance.generatedBy,
      'created_at': instance.createdAt.toIso8601String(),
    };
