// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
abstract class CartItem with _$CartItem {
  const CartItem._();

  factory CartItem({
    @JsonKey(
      name: 'product_reference',
      fromJson: DocumentReferenceJsonConverter.fromJsonNullable,
      toJson: DocumentReferenceJsonConverter.toJsonNullable,
    )
    DocumentReference? productReference,

    // Original client order
    @JsonKey(name: 'orig_qty') required int origQty,
    @JsonKey(name: 'orig_label') String? origLabel,

    // Admin adjustments
    @JsonKey(name: 'adj_qty') int? adjQty,
    @JsonKey(name: 'adj_label') String? adjLabel,

    // Other product metadata
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'search_key') String? searchKey,
    @JsonKey(name: 'unit_price') double? unitPrice,
    @JsonKey(name: 'unit_label') String? unitLabel,
    @JsonKey(name: 'discount') @Default(0.0) double discount,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  factory CartItem.empty() => CartItem(
        origQty: 0,
        origLabel: '',
        adjQty: 0,
        adjLabel: '',
        productName: '',
        searchKey: '',
        unitLabel: '',
        unitPrice: 0.0,
        discount: 0.0,
      );

  bool get isEmpty => this == CartItem.empty();
  bool get isNotEmpty => !isEmpty;
}
