import 'package:freezed_annotation/freezed_annotation.dart';
part 'brand.freezed.dart';
part 'brand.g.dart';

@freezed
abstract class Brand with _$Brand {
  factory Brand({
    required String id, // e.g. 'b123'
    required String label, // e.g. 'Amul'
    String? image, // optional logo/icon URL
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
  factory Brand.empty() => Brand(id: '', label: '', image: null);
  factory Brand.next(int index) {
    final id = 'brand_${(index + 1).toString().padLeft(3, '0')}';
    return Brand(id: id, label: '', image: null);
  }
}

extension BrandHelpers on Brand {
  bool get isEmpty => this.id == Brand.empty().id;
  bool get isNotEmpty => !isEmpty;
  String? validate() {
    if (label.trim().isEmpty) return 'Brand name is required';
    if (image == null || image!.trim().isEmpty)
      return 'Image is required for brand';
    return null;
  }
}
