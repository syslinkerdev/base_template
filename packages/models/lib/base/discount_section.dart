// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'discount_section.freezed.dart';
part 'discount_section.g.dart';

@freezed
abstract class DiscountSection with _$DiscountSection {
  const DiscountSection._();

  factory DiscountSection({
    required String id,
    required String name,
    @JsonKey(name: 'product_discounts')
    @Default(<String, Discount>{})
    Map<String, Discount> productDiscounts,
    @JsonKey(
        name: 'status',
        fromJson: DiscountSectionStatusConverter.fromJson,
        toJson: DiscountSectionStatusConverter.toJson)
    @Default(DiscountSectionStatus.custom)
    DiscountSectionStatus status,
    @JsonKey(name: 'meta') MetaDataX? meta,
  }) = _DiscountSection;

  factory DiscountSection.fromJson(Map<String, dynamic> json) =>
      _$DiscountSectionFromJson(json);

  factory DiscountSection.empty() => DiscountSection(
        id: '',
        name: '',
        productDiscounts: const {},
        status: DiscountSectionStatus.custom,
        meta: MetaDataX(),
      );
}

extension DiscountSectionApi on DiscountSection {
  Map<String, dynamic> toDocument() => {
        'id': id,
        'name': name,
        'product_discounts': productDiscounts.map(
          (key, discount) => MapEntry(key, discount.toDocument()),
        ),
        'status': DiscountSectionStatusConverter.toJson(status),
        'meta': meta?.toJson(),
      };
}

extension DiscountSectionHelpers on DiscountSection {
  bool get isEmpty => this.id == DiscountSection.empty().id;
  bool get isNotEmpty => !isEmpty;

  /// ✅ Only non-deleted product discounts
  Map<String, Discount> get nonDeleteDiscounts => Map.fromEntries(
        productDiscounts.entries
            .where((e) => e.value.status != ProductStatus.deleted),
      );

  static const String GlobalDiscountsDocId = 'global_discounts';
  String? validate() {
    if (name.trim().isEmpty) return 'Discount Section name is required';
    if (productDiscounts.isEmpty) return 'At least one discount is required';
    return null;
  }
}
