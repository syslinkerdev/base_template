import 'package:flutter/material.dart';
import 'package:models/models.dart';

class ProductWithDiscount {
  final Product product;
  final Discount? discount;
  ProductWithDiscount({
    required this.product,
    this.discount,
  });
}

enum ProductsViewMode { view, edit }

class ProductStatusFilter {
  final ProductStatus value;
  final String label;
  final IconData icon;

  const ProductStatusFilter({
    required this.value,
    required this.label,
    required this.icon,
  });
}

final List<ProductStatusFilter> productStatusFilters = [
  ProductStatusFilter(
    value: ProductStatus.activePublic,
    label: ProductStatus.activePublic.label,
    icon: ProductStatus.activePublic.icon,
  ),
  // ProductStatusFilter(
  //   value: ProductStatus.activePrivate,
  //   label: ProductStatus.activePrivate.label,
  //   icon: ProductStatus.activePrivate.icon,
  // ),
  ProductStatusFilter(
    value: ProductStatus.archived,
    label: ProductStatus.archived.label,
    icon: ProductStatus.archived.icon,
  ),
  ProductStatusFilter(
    value: ProductStatus.draft,
    label: ProductStatus.draft.label,
    icon: ProductStatus.draft.icon,
  ),
];
ProductStatusFilter productStatusToFilter(ProductStatus value) =>
    productStatusFilters.firstWhere((filter) => filter.value == value,
        orElse: () => productStatusFilters.first);

enum UpdatedWithin {
  anytime,
  lastDay,
  last7Days,
  last30Days,
}

class UpdatedWithinFilter {
  final UpdatedWithin value;
  final String label;
  final IconData icon;
  final Duration? duration;

  const UpdatedWithinFilter({
    required this.value,
    required this.label,
    required this.icon,
    this.duration,
  });
}

const List<UpdatedWithinFilter> updatedWithinFilters = [
  UpdatedWithinFilter(
    value: UpdatedWithin.anytime,
    label: 'Anytime',
    icon: Icons.all_inclusive,
    duration: null,
  ),
  UpdatedWithinFilter(
    value: UpdatedWithin.lastDay,
    label: 'Last 24 Hours',
    icon: Icons.today,
    duration: Duration(days: 1),
  ),
  UpdatedWithinFilter(
    value: UpdatedWithin.last7Days,
    label: 'Last 7 Days',
    icon: Icons.calendar_view_week,
    duration: Duration(days: 7),
  ),
  UpdatedWithinFilter(
    value: UpdatedWithin.last30Days,
    label: 'Last 30 Days',
    icon: Icons.calendar_month,
    duration: Duration(days: 30),
  ),
];
UpdatedWithinFilter updatedWithinToFilter(UpdatedWithin value) =>
    updatedWithinFilters.firstWhere((filter) => filter.value == value,
        orElse: () => updatedWithinFilters.first);

List<PackagingType> generateQuickAddOptions(PackagingType packaging) {
  return List.generate(4, (index) {
    final count = index + 1;
    return PackagingType(
      id: '${packaging.label.toLowerCase().replaceAll(' ', '_')}_${(count).toString().padLeft(3, '0')}',
      label: '$count ${packaging.label}',
      quantity: packaging.quantity * count,
    );
  });
}

PackagingType? findBasePackagingFromQuickAddList({
  required List<PackagingType> quickAddOptions,
  required List<PackagingType> allBasePackagingList,
}) {
  if (quickAddOptions.isEmpty) return null;

  final first = quickAddOptions.first;
  final labelParts = first.label.trim().split(' ');
  if (labelParts.length < 2) return null;

  final label = labelParts.sublist(1).join(' ').toLowerCase();
  final quantity = first.quantity;

  final pack = allBasePackagingList.firstWhere(
    (pkg) => pkg.label.toLowerCase() == label && pkg.quantity == quantity,
    orElse: () => PackagingType.empty(), // or null, if you prefer
  );
  return pack.isNotEmpty ? pack : null;
}

T? nullIfEmpty<T>(T? item) {
  if (item == null) return null;

  if (item is String && item.isEmpty) return null;
  if (item is Iterable && item.isEmpty) return null;
  if (item is Map && item.isEmpty) return null;
  if (item is Brand && item.isEmpty) return null;
  if (item is Category && item.isEmpty) return null;
  if (item is UnitDetail && item.isEmpty) return null;
  if (item is PackagingType && item.isEmpty) return null;
  if (item is ProductType && item.isEmpty) return null;

  return item;
}

String formatDouble(double value) {
  if (value == 0) return '';
  return value == value.roundToDouble()
      ? value.toStringAsFixed(0)
      : value.toString();
}
