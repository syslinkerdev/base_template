// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiscountSection _$DiscountSectionFromJson(Map<String, dynamic> json) =>
    _DiscountSection(
      id: json['id'] as String,
      name: json['name'] as String,
      productDiscounts:
          (json['product_discounts'] as Map<String, dynamic>?)?.map(
                (k, e) =>
                    MapEntry(k, Discount.fromJson(e as Map<String, dynamic>)),
              ) ??
              const <String, Discount>{},
      status: json['status'] == null
          ? DiscountSectionStatus.custom
          : DiscountSectionStatusConverter.fromJson(json['status'] as Object),
      meta: json['meta'] == null
          ? null
          : MetaDataX.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiscountSectionToJson(_DiscountSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'product_discounts': instance.productDiscounts,
      'status': DiscountSectionStatusConverter.toJson(instance.status),
      'meta': instance.meta,
    };
