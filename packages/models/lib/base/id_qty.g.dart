// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_qty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IdQty _$IdQtyFromJson(Map<String, dynamic> json) => _IdQty(
      id: json['id'] as String,
      qty: (json['qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$IdQtyToJson(_IdQty instance) => <String, dynamic>{
      'id': instance.id,
      'qty': instance.qty,
    };
