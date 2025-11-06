// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_maker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductMaker _$ProductMakerFromJson(Map<String, dynamic> json) =>
    _ProductMaker(
      brands: (json['brands'] as List<dynamic>)
          .map((e) => Brand.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      packagingTypes: (json['packaging_types'] as List<dynamic>)
          .map((e) => PackagingType.fromJson(e as Map<String, dynamic>))
          .toList(),
      units: (json['units'] as List<dynamic>)
          .map((e) => UnitDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      productTypes: (json['product_types'] as List<dynamic>)
          .map((e) => ProductType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductMakerToJson(_ProductMaker instance) =>
    <String, dynamic>{
      'brands': instance.brands,
      'categories': instance.categories,
      'packaging_types': instance.packagingTypes,
      'units': instance.units,
      'product_types': instance.productTypes,
    };
