// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_type.freezed.dart';
part 'product_type.g.dart';

@freezed
abstract class ProductType with _$ProductType {
  factory ProductType({
    required String id,
    @JsonKey(name: 'short_form') required String shortForm,
    @JsonKey(name: 'full_form') required String fullForm,
  }) = _ProductType;

  factory ProductType.empty() => ProductType(
        id: '',
        shortForm: '',
        fullForm: '',
      );
  factory ProductType.next(int index) {
    final id = 'product_type_${(index + 1).toString().padLeft(3, '0')}';
    return ProductType(
      id: id,
      shortForm: '',
      fullForm: '',
    );
  }
  factory ProductType.fromJson(Map<String, dynamic> json) =>
      _$ProductTypeFromJson(json);
}

extension ProductTypeHelpers on ProductType {
  bool get isEmpty => id.isEmpty && id.isEmpty;
  bool get isNotEmpty => !isEmpty;

  String? validate() {
    if (shortForm.trim().isEmpty) return 'Short form is required';
    if (fullForm.trim().isEmpty) return 'Full form is required';
    return null;
  }
}
