// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Discount _$DiscountFromJson(Map<String, dynamic> json) => _Discount(
      id: json['id'] as String,
      productReference: DocumentReferenceJsonConverter.fromJsonNullable(
          json['product_reference']),
      productKey: json['product_key'] as String,
      discount: (json['discount'] as num).toDouble(),
      status: json['status'] == null
          ? ProductStatus.draft
          : ProductStatusConverter.fromJson(json['status'] as Object),
      maxAllowedDiscount:
          (json['maxAllowedDiscount'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$DiscountToJson(_Discount instance) => <String, dynamic>{
      'id': instance.id,
      'product_reference': DocumentReferenceJsonConverter.toJsonNullable(
          instance.productReference),
      'product_key': instance.productKey,
      'discount': instance.discount,
      'status': ProductStatusConverter.toJson(instance.status),
    };
