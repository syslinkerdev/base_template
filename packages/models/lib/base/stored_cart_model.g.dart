// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoredCart _$StoredCartFromJson(Map<String, dynamic> json) => _StoredCart(
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      mode: $enumDecode(_$CartModeEnumMap, json['mode']),
      editId: json['editId'] as String?,
      basketName: json['basketName'] as String?,
      clientUid: json['clientUid'] as String?,
    );

Map<String, dynamic> _$StoredCartToJson(_StoredCart instance) =>
    <String, dynamic>{
      'items': instance.items,
      'mode': _$CartModeEnumMap[instance.mode]!,
      'editId': instance.editId,
      'basketName': instance.basketName,
      'clientUid': instance.clientUid,
    };

const _$CartModeEnumMap = {
  CartMode.newOrder: 'newOrder',
  CartMode.edit: 'edit',
  CartMode.basket: 'basket',
  CartMode.editBasket: 'editBasket',
};
