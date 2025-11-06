import 'package:freezed_annotation/freezed_annotation.dart';
part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class Category with _$Category {
  factory Category({
    required String id, // e.g. 'c456'
    required String label, // e.g. 'Milk Products'
    String? image, // optional category image
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  factory Category.empty() => Category(id: '', label: '', image: null);
  factory Category.next(int index) {
    final id = 'category_${(index + 1).toString().padLeft(3, '0')}';
    return Category(id: id, label: '', image: null);
  }
}

extension CategoryHelpers on Category {
  bool get isEmpty => this.id == Category.empty().id;
  bool get isNotEmpty => !isEmpty;
  String? validate() {
    if (label.trim().isEmpty) return 'Category name is required';
    if (image == null || image!.trim().isEmpty)
      return 'Image is required for category';
    return null;
  }
}
