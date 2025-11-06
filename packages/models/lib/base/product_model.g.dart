// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
      userSideQuantity: (json['userSideQuantity'] as num?)?.toInt() ?? 0,
      priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toDouble() ?? 0,
      id: json['id'] as String,
      name: json['name'] as String,
      brand: Brand.fromJson(json['brand'] as Map<String, dynamic>),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      productType:
          ProductType.fromJson(json['product_type'] as Map<String, dynamic>),
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'INR',
      searchKey: json['search_key'] as String,
      shortForm: json['short_form'] as String,
      unitDetails:
          UnitDetail.fromJson(json['unit_details'] as Map<String, dynamic>),
      packSize: (json['pack_size'] as num).toInt(),
      quickAddOptions: (json['quick_add_options'] as List<dynamic>)
          .map((e) => PackagingType.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] == null
          ? ProductStatus.draft
          : ProductStatusConverter.fromJson(json['status'] as Object),
      createdAt: TimeStampConverter.fromJson(json['created_at']),
      createdBy: json['created_by'] as String,
      updatedAt: TimeStampConverter.fromJsonNullable(json['updated_at']),
      updatedBy: json['updated_by'] as String?,
      orderFrequency: json['order_frequency'] as String?,
    );

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
      'userSideQuantity': instance.userSideQuantity,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'id': instance.id,
      'name': instance.name,
      'brand': instance.brand,
      'category': instance.category,
      'product_type': instance.productType,
      'image': instance.image,
      'price': instance.price,
      'currency': instance.currency,
      'search_key': instance.searchKey,
      'short_form': instance.shortForm,
      'unit_details': instance.unitDetails,
      'pack_size': instance.packSize,
      'quick_add_options': instance.quickAddOptions,
      'status': ProductStatusConverter.toJson(instance.status),
      'created_at': instance.createdAt.toIso8601String(),
      'created_by': instance.createdBy,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'updated_by': instance.updatedBy,
      'order_frequency': instance.orderFrequency,
    };
