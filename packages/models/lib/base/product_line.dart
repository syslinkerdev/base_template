// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'product_line.freezed.dart';
part 'product_line.g.dart';

@freezed
abstract class ProductLine with _$ProductLine {
  const ProductLine._();
  const factory ProductLine({
    @JsonKey(name: 'company_id') required String companyId,
    @JsonKey(name: 'company_name') required String companyName,
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'product_name') required String productName,
    @JsonKey(name: 'product_key') required String productKey,
    @JsonKey(name: 'unit_details') required UnitDetail unitDetails,
    @JsonKey(name: 'product_type') required ProductType productType,
    @JsonKey(name: 'total_quantity') required int totalQuantity,
    @JsonKey(name: 'unit_price') required double unitPrice,
    @JsonKey(name: 'discount') required double discount,
    @JsonKey(name: 'subtotal') required double subtotal,
  }) = _ProductLine;

  factory ProductLine.fromJson(Map<String, dynamic> json) =>
      _$ProductLineFromJson(json);

  /// ✅ Empty factory
  factory ProductLine.empty() => ProductLine(
        companyId: '',
        companyName: '',
        productId: '',
        productName: '',
        productKey: '',
        unitDetails: UnitDetail.empty(),
        productType: ProductType.empty(),
        totalQuantity: 0,
        unitPrice: 0.0,
        discount: 0.0,
        subtotal: 0.0,
      );
}

extension ProductLineApi on ProductLine {
  /// ✅ Helpers
  bool get isEmpty => companyId.isEmpty;
  bool get isNotEmpty => companyId.isNotEmpty;
}

extension ProductLineApiX on ProductLine {
  /// ✅ Convert ProductLine to Firestore-friendly document
  Map<String, dynamic> toDocument() => {
        'company_id': companyId,
        'company_name': companyName,
        'product_id': productId,
        'product_name': productName,
        'product_key': productKey,
        'unit_details': unitDetails.toJson(),
        'product_type':productType.toJson(),
        'total_quantity': totalQuantity,
        'unit_price': unitPrice,
        'discount': discount,
        'subtotal': subtotal,
      };
}
