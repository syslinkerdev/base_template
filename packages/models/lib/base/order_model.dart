// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
abstract class OrderX with _$OrderX {
  const OrderX._();
  factory OrderX({
    // 🧾 Order Info
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'user_uid') required String userUid,
    @JsonKey(name: 'superuser_uid') required String superuserUid,
    @JsonKey(name: 'logs') List<String>? logs,

    // 💰 Pricing
    @JsonKey(name: 'total_price') required double totalPrice,
    @JsonKey(name: 'original_total_price') required double originalTotalPrice,
    @JsonKey(name: 'service_charges') required double serviceCharges,

    // 🧺 Products
    @JsonKey(name: 'ordered_products') required List<CartItem> orderedProducts,

    // 🕒 Metadata
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
    required DateTime createdAt,
    @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? updatedAt,

    // 📅 Delivery date
    @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
    required DateTime deliveryDate,

    // 🔁 Status: placed | adjusted | deleted
    @JsonKey(
        fromJson: OrderStatusConverter.fromJson,
        toJson: OrderStatusConverter.toJson)
    @Default(OrderStatus.placed)
    OrderStatus status,
  }) = _OrderX;

  factory OrderX.fromJson(Map<String, dynamic> json) => _$OrderXFromJson(json);

  factory OrderX.empty() => OrderX(
        orderId: '',
        userUid: '',
        superuserUid: '',
        logs: [],
        orderedProducts: [],
        totalPrice: 0.0,
        originalTotalPrice: 0.0,
        serviceCharges: 0.0,
        createdBy: '',
        createdAt: DateTime.now(),
        updatedAt: null,
        deliveryDate: DateTime.now().add(const Duration(days: 1)),
        status: OrderStatus.placed,
      );
  bool get isEmpty => orderId.isEmpty; // ✅ FIXED
  bool get isNotEmpty => orderId.isNotEmpty;
}

extension OrderXApi on OrderX {
  Map<String, dynamic> toDocument() => {
        'order_id': orderId,
        'user_uid': userUid,
        'superuser_uid': superuserUid,
        'logs': logs,
        'total_price': totalPrice,
        'original_total_price': originalTotalPrice,
        'service_charges': serviceCharges,
        'ordered_products':
            orderedProducts.map((item) => item.toJson()).toList(),
        'created_by': createdBy,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'delivery_date': deliveryDate,
        'status': OrderStatusConverter.toJson(status),
      };
}
