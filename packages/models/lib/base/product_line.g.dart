// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductLine _$ProductLineFromJson(Map<String, dynamic> json) => _ProductLine(
      companyId: json['company_id'] as String,
      companyName: json['company_name'] as String,
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      productKey: json['product_key'] as String,
      unitDetails:
          UnitDetail.fromJson(json['unit_details'] as Map<String, dynamic>),
      productType:
          ProductType.fromJson(json['product_type'] as Map<String, dynamic>),
      totalQuantity: (json['total_quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductLineToJson(_ProductLine instance) =>
    <String, dynamic>{
      'company_id': instance.companyId,
      'company_name': instance.companyName,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_key': instance.productKey,
      'unit_details': instance.unitDetails,
      'product_type': instance.productType,
      'total_quantity': instance.totalQuantity,
      'unit_price': instance.unitPrice,
      'discount': instance.discount,
      'subtotal': instance.subtotal,
    };
