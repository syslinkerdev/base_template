import 'package:freezed_annotation/freezed_annotation.dart';

part 'packaging_type.freezed.dart';
part 'packaging_type.g.dart';

@freezed
abstract class PackagingType with _$PackagingType {
  factory PackagingType({
    required String id,
    required String label, // Tray, Packet, Buckets
    required int quantity, // e.g. 12 per Tray
  }) = _PackagingType;

  factory PackagingType.fromJson(Map<String, dynamic> json) =>
      _$PackagingTypeFromJson(json);
  factory PackagingType.empty() => PackagingType(
        id: '',
        label: '',
        quantity: 0,
      );
  factory PackagingType.next(int index) {
    final id = 'packaging_type_${(index + 1).toString().padLeft(3, '0')}';
    return PackagingType(
      id: id,
      label: '',
      quantity: 0,
    );
  }
}

extension PackagingTypeHelpers on PackagingType {
  bool get isEmpty => this.id == PackagingType.empty().id;
  bool get isNotEmpty => !isEmpty;
  String? validate() {
    if (label.trim().isEmpty) return 'Packaging type label is required';
    if (quantity <= 0) return 'Quantity must be greater than zero';
    return null;
  }
}
