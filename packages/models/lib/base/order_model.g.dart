// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderX _$OrderXFromJson(Map<String, dynamic> json) => _OrderX(
      orderId: json['order_id'] as String,
      userUid: json['user_uid'] as String,
      superuserUid: json['superuser_uid'] as String,
      logs: (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      totalPrice: (json['total_price'] as num).toDouble(),
      originalTotalPrice: (json['original_total_price'] as num).toDouble(),
      serviceCharges: (json['service_charges'] as num).toDouble(),
      orderedProducts: (json['ordered_products'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['created_by'] as String,
      createdAt: TimeStampConverter.fromJson(json['created_at']),
      updatedAt: TimeStampConverter.fromJsonNullable(json['updated_at']),
      deliveryDate: TimeStampConverter.fromJson(json['delivery_date']),
      status: json['status'] == null
          ? OrderStatus.placed
          : OrderStatusConverter.fromJson(json['status'] as Object),
    );

Map<String, dynamic> _$OrderXToJson(_OrderX instance) => <String, dynamic>{
      'order_id': instance.orderId,
      'user_uid': instance.userUid,
      'superuser_uid': instance.superuserUid,
      'logs': instance.logs,
      'total_price': instance.totalPrice,
      'original_total_price': instance.originalTotalPrice,
      'service_charges': instance.serviceCharges,
      'ordered_products': instance.orderedProducts,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'delivery_date': instance.deliveryDate.toIso8601String(),
      'status': OrderStatusConverter.toJson(instance.status),
    };
