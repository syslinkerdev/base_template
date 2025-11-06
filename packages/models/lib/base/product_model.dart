// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class Product with _$Product {
  const Product._();

  factory Product({
    // CLIENT-SIDE SELECTION
    @Default(0) int? userSideQuantity, // user-selected quantity
    @Default(0) double? priceAfterDiscount, // calculated after discount

    // CORE DETAILS
    required String id,
    required String name,
    required Brand brand,
    required Category category,
    @JsonKey(name: 'product_type') required ProductType productType,
    required String image, // URL or asset path
    required double price,
    @Default('INR') String currency,
    @JsonKey(name: 'search_key') required String searchKey,
    @JsonKey(name: 'short_form') required String shortForm, // SKU

    // UNIT INFO
    @JsonKey(name: 'unit_details') required UnitDetail unitDetails,

    // ORDERING CONSTRAINTS
    // @JsonKey(name: 'min_buy_quantity') required int minBuyQuantity,
    @JsonKey(name: 'pack_size') required int packSize,
    @JsonKey(name: 'quick_add_options')
    required List<PackagingType> quickAddOptions,

    // SYSTEM STATUS
    @JsonKey(
        name: 'status',
        fromJson: ProductStatusConverter.fromJson,
        toJson: ProductStatusConverter.toJson)
    @Default(ProductStatus.draft)
    ProductStatus status,

    // META
    @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
    required DateTime createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? updatedAt,
    @JsonKey(name: 'updated_by') String? updatedBy,
    @JsonKey(name: 'order_frequency') String? orderFrequency,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.empty() => Product(
        id: '',
        name: '',
        price: 1,
        image: '',
        unitDetails: UnitDetail.empty(),
        brand: Brand.empty(),
        category: Category.empty(),
        productType: ProductType.empty(),
        searchKey: '',
        shortForm: '',
        packSize: 1,
        quickAddOptions: [],
        createdAt: DateTime.now(),
        createdBy: '',
      );

  bool get isEmpty => this.id == Product.empty().id;
  bool get isNotEmpty => !isEmpty;
}

extension ProductApiX on Product {
  Map<String, dynamic> toDocument() => {
        // CLIENT-SIDE SELECTION (ignored in Firestore document)
        // 'user_side_quantity': userSideQuantity,
        // 'price_after_discount': priceAfterDiscount,

        // CORE DETAILS
        'id': id,
        'name': name,
        'brand': brand.toJson(),
        'category': category.toJson(),
        'product_type': productType.toJson(),
        'image': image,
        'price': price,
        'currency': currency,
        'search_key': searchKey,
        'short_form': shortForm,

        // UNIT INFO
        'unit_details': unitDetails.toJson(),

        // ORDERING CONSTRAINTS
        'pack_size': packSize,
        'quick_add_options': quickAddOptions.map((e) => e.toJson()).toList(),

        // SYSTEM STATUS
        'status': ProductStatusConverter.toJsonNullable(status),

        // META
        'created_at': createdAt,
        'created_by': createdBy,
        'updated_at': updatedAt,
        'updated_by': updatedBy,
        'order_frequency': orderFrequency,
      };
}

extension ProductListHelpers on List<Product> {
  /// Only Non Delete Products
  List<Product> get nonDeleteProducts =>
      where((p) => p.status != ProductStatus.deleted).toList();
}
