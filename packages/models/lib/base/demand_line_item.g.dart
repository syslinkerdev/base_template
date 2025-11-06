// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demand_line_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DemandProductItem _$DemandProductItemFromJson(Map<String, dynamic> json) =>
    _DemandProductItem(
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      productKey: json['product_key'] as String,
      unitDetails:
          UnitDetail.fromJson(json['unit_details'] as Map<String, dynamic>),
      productType:
          ProductType.fromJson(json['product_type'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
    );

Map<String, dynamic> _$DemandProductItemToJson(_DemandProductItem instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_key': instance.productKey,
      'unit_details': instance.unitDetails,
      'product_type': instance.productType,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'discount': instance.discount,
      'subtotal': instance.subtotal,
    };
