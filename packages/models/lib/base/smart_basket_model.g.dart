// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_basket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SmartBasket _$SmartBasketFromJson(Map<String, dynamic> json) => _SmartBasket(
      basketId: json['basket_id'] as String,
      basketName: json['basket_name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: TimeStampConverter.fromJsonNullable(json['created_at']),
      updatedAt: TimeStampConverter.fromJsonNullable(json['updated_at']),
    );

Map<String, dynamic> _$SmartBasketToJson(_SmartBasket instance) =>
    <String, dynamic>{
      'basket_id': instance.basketId,
      'basket_name': instance.basketName,
      'items': instance.items,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
