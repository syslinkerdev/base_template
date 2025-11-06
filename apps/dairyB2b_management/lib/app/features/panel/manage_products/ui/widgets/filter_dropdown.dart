import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';

class BrandFilterDropdown extends ConsumerWidget {
  final List<Brand> brands;
  final Brand? selectedBrand;
  final void Function(Brand) onChanged;

  const BrandFilterDropdown({
    super.key,
    required this.brands,
    required this.selectedBrand,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => PopUpDropdown<Brand>(
        hintText: 'Select Brand',
        tooltip: 'Brands',
        items: brands,
        value: selectedBrand,
        itemLabel: (f) => f.label,
        onSelected: onChanged,
      );
}

class CategoryFilterDropdown extends ConsumerWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final void Function(Category) onChanged;

  const CategoryFilterDropdown({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => PopUpDropdown<Category>(
        hintText: 'Select Category',
        tooltip: 'Categories',
        items: categories,
        value: selectedCategory,
        itemLabel: (f) => f.label,
        onSelected: onChanged,
      );
}

class UpdatedWithinFilterDropdown extends StatelessWidget {
  final List<UpdatedWithinFilter> updatedWithins;
  final UpdatedWithinFilter? selectedUpdatedWithin;
  final void Function(UpdatedWithinFilter) onChanged;

  const UpdatedWithinFilterDropdown({
    super.key,
    required this.updatedWithins,
    required this.selectedUpdatedWithin,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopUpDropdown<UpdatedWithinFilter>(
      hintText: 'Updated Range',
      tooltip: 'Time Gaps',
      items: updatedWithins,
      value: selectedUpdatedWithin,
      itemLabel: (f) => f.label,
      onSelected: onChanged,
    );
  }
}

class ProductStatusFilterDropdown extends StatelessWidget {
  final List<ProductStatusFilter> productStatuses;
  final ProductStatusFilter? selectedProductStatus;
  final void Function(ProductStatusFilter) onChanged;

  const ProductStatusFilterDropdown({
    super.key,
    required this.productStatuses,
    required this.selectedProductStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopUpDropdown<ProductStatusFilter>(
      hintText: 'Select Status',
      tooltip: 'Statuses',
      items: productStatuses,
      value: selectedProductStatus,
      itemLabel: (f) => f.label,
      onSelected: onChanged,
    );
  }
}
