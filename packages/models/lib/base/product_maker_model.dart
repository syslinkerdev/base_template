// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'product_maker_model.freezed.dart';
part 'product_maker_model.g.dart';

@freezed
abstract class ProductMaker with _$ProductMaker {
  const ProductMaker._();
  const factory ProductMaker({
    required List<Brand> brands,
    required List<Category> categories,
    @JsonKey(name: 'packaging_types')
    required List<PackagingType> packagingTypes,
    required List<UnitDetail> units,

    // NEW: product types
    @JsonKey(name: 'product_types') required List<ProductType> productTypes,
  }) = _ProductMaker;

  // Add an empty constructor
  factory ProductMaker.empty() => const ProductMaker(
        brands: [],
        categories: [],
        packagingTypes: [],
        units: [],
        productTypes: [],
      );

  bool get isEmpty => this == ProductMaker.empty();
  bool get isNotEmpty => !isEmpty;

  // ProductMaker Doc id
  static const String productMakerDocId = 'product_maker';

  factory ProductMaker.fromJson(Map<String, dynamic> json) =>
      _$ProductMakerFromJson(json);
}

extension ProductMakerApi on ProductMaker {
  Map<String, dynamic> toDocument() => {
        'brands': brands.map((b) => b.toJson()).toList(),
        'categories': categories.map((c) => c.toJson()).toList(),
        'packaging_types': packagingTypes.map((p) => p.toJson()).toList(),
        'units': units.map((u) => u.toJson()).toList(),
        'product_types': productTypes.map((p) => p.toJson()).toList(),
      };
}
