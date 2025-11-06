// smart_basket_model.dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'smart_basket_model.freezed.dart';
part 'smart_basket_model.g.dart';

@freezed
abstract class SmartBasket with _$SmartBasket {
  const SmartBasket._(); // For custom getters

  const factory SmartBasket({
    @JsonKey(name: 'basket_id') required String basketId,
    @JsonKey(name: 'basket_name') required String basketName,
    @JsonKey(name: 'items') required List<CartItem> items,
    @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? updatedAt,
  }) = _SmartBasket;

  factory SmartBasket.empty() => SmartBasket(
        basketId: '',
        basketName: '',
        items: [],
        createdAt: DateTime.now(),
        updatedAt: null,
      );

  bool get isEmpty => this == SmartBasket.empty();
  bool get isNotEmpty => !isEmpty;
  factory SmartBasket.fromJson(Map<String, dynamic> json) =>
      _$SmartBasketFromJson(json);
}

extension SmartBasketX on SmartBasket {
  Map<String, dynamic> toDocument() => {
        'basket_id': basketId,
        'basket_name': basketName,
        'items': items.map((item) => item.toJson()).toList(),
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
