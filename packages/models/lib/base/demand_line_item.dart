// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'demand_line_item.freezed.dart';
part 'demand_line_item.g.dart';

@freezed
abstract class DemandLineItem with _$DemandLineItem {
  const DemandLineItem._();
  const factory DemandLineItem({
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_key') required String productKey,
    @JsonKey(name: 'unit_details') required UnitDetail unitDetails,
    @JsonKey(name: 'product_type') required ProductType productType,
    @JsonKey(name: 'quantity') required int quantity,
    @JsonKey(name: 'unit_price') required double unitPrice,
    @JsonKey(name: 'discount') required double discount,
    @JsonKey(name: 'subtotal') required double subtotal,
  }) = _DemandProductItem;

  factory DemandLineItem.fromJson(Map<String, dynamic> json) =>
      _$DemandProductItemFromJson(json);

  /// ✅ Empty factory
  factory DemandLineItem.empty() => DemandLineItem(
        productId: '',
        productName: '',
        productKey: '',
        unitDetails: UnitDetail.empty(),
        productType: ProductType.empty(),
        quantity: 0,
        unitPrice: 0.0,
        discount: 0.0,
        subtotal: 0.0,
      );
}

/// ✅ Helpers
extension DemandLineItemApi on DemandLineItem {
  bool get isEmpty => productId.isEmpty;
  bool get isNotEmpty => productId.isNotEmpty;
}

/// ✅ Firestore-friendly converter
extension DemandLineItemApiX on DemandLineItem {
  Map<String, dynamic> toDocument() => {
        'product_id': productId,
        'product_name': productName,
        'product_key': productKey,
        'unit_details': unitDetails.toJson(),
        'product_type': productType.toJson(),
        'quantity': quantity,
        'unit_price': unitPrice,
        'discount': discount,
        'subtotal': subtotal,
      };
}
