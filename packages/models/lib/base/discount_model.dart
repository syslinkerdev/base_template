// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';

part 'discount_model.freezed.dart';
part 'discount_model.g.dart';

@freezed
abstract class Discount with _$Discount {
  const Discount._();

  factory Discount({
    required String id,
    @JsonKey(
        name: 'product_reference',
        fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
        toJson: DocumentReferenceJsonConverter.toJsonNullable)
    DocumentReference? productReference,
    @JsonKey(name: 'product_key') required String productKey,
    required double discount,
    @JsonKey(
        name: 'status',
        fromJson: ProductStatusConverter.fromJson,
        toJson: ProductStatusConverter.toJson)
    @Default(ProductStatus.draft)
    ProductStatus status,
    @JsonKey(includeToJson: false) @Default(0.0) double maxAllowedDiscount,
  }) = _Discount;

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
  factory Discount.empty() => Discount(
        id: '',
        productKey: '',
        discount: 0,
        status: ProductStatus.draft,
      );

  /// 👇 Factory to create a new discount for a given product
  factory Discount.next(Product product,
          {required String productPath, required double discount}) =>
      Discount(
        id: '${product.id}_DIS',
        productReference: FirebaseFirestore.instance.doc(productPath),
        productKey: product.searchKey,
        discount: discount,
        status: ProductStatus.draft,
      );
}

extension DiscountApi on Discount {
  Map<String, dynamic> toDocument() => {
        'id': id,
        'product_reference':
            DocumentReferenceJsonConverter.toJson(productReference!),
        'product_key': productKey,
        'discount': discount,
        'status': ProductStatusConverter.toJson(status),
      };
}

extension DiscountHelpers on Discount {
  bool get isEmpty => this.id == Discount.empty().id;
  bool get isNotEmpty => !isEmpty;

  String? validate() {
    if (discount < 0) return 'Discount must be non-negative';
    return null;
  }
}

// extension DiscountMapHelpers on Map<String, Discount> {
//   /// ✅ Only non deleted discounts as Map
//   Map<String, Discount> get nonDeleteDiscounts => Map.fromEntries(
//       entries.where((e) => e.value.status != ProductStatus.deleted));
// }
