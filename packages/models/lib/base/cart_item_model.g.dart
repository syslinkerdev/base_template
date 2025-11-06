// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItem _$CartItemFromJson(Map<String, dynamic> json) => _CartItem(
      productReference: DocumentReferenceJsonConverter.fromJsonNullable(
          json['product_reference']),
      origQty: (json['orig_qty'] as num).toInt(),
      origLabel: json['orig_label'] as String?,
      adjQty: (json['adj_qty'] as num?)?.toInt(),
      adjLabel: json['adj_label'] as String?,
      productName: json['product_name'] as String?,
      searchKey: json['search_key'] as String?,
      unitPrice: (json['unit_price'] as num?)?.toDouble(),
      unitLabel: json['unit_label'] as String?,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$CartItemToJson(_CartItem instance) => <String, dynamic>{
      'product_reference': DocumentReferenceJsonConverter.toJsonNullable(
          instance.productReference),
      'orig_qty': instance.origQty,
      'orig_label': instance.origLabel,
      'adj_qty': instance.adjQty,
      'adj_label': instance.adjLabel,
      'product_name': instance.productName,
      'search_key': instance.searchKey,
      'unit_price': instance.unitPrice,
      'unit_label': instance.unitLabel,
      'discount': instance.discount,
    };
