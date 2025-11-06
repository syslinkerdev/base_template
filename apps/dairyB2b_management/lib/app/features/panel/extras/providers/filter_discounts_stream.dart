import 'package:flutter/material.dart';
import 'package:repo/repo.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_discounts_stream.g.dart';

@riverpod
Future<List<Discount>> filteredDiscountsStream(Ref ref,
    {String? disSectionId, DiscountFillFilter? discountFillFilter}) async {
  final allDiscounts =
      await _resolveDiscounts(ref, disSectionId, discountFillFilter);

  return allDiscounts;
}

@riverpod
Future<String> discountProgress(Ref ref, String? disSectionId) async {
  final allDiscounts =
      await _resolveDiscounts(ref, disSectionId, DiscountFillFilter.filled);
  final allGlobalDiscounts = await _resolveDiscounts(ref,
      DiscountSectionHelpers.GlobalDiscountsDocId, DiscountFillFilter.filled);

  final allProducts = await ref.watch(productsStreamXProvider.future);

  final productCount = allProducts.length;
  final discountCount = allDiscounts.length;
  final globalDiscountCount = allGlobalDiscounts.length;

  if (discountCount == 0) return "$productCount / -";
  if (disSectionId == DiscountSectionHelpers.GlobalDiscountsDocId) {
    return "$productCount / $discountCount";
  }
  return "$globalDiscountCount / $discountCount";
}

Future<List<Discount>> _resolveDiscounts(
  Ref ref,
  String? disSectionId,
  DiscountFillFilter? discountFillFilter,
) async {
  // Get all discount sections
  final allSections = await ref.watch(discountSectionsStreamXProvider.future);
  final globalSection = await ref
      .watch(discountSectionsStreamXProvider.notifier)
      .globalDisSection;

  // Identify active (target) section
  final activeSection = allSections.firstWhere(
    (section) =>
        section.id ==
        (disSectionId ?? DiscountSectionHelpers.GlobalDiscountsDocId),
    orElse: () => DiscountSection.empty(),
  );

  final filled = activeSection.nonDeleteDiscounts;
  final global = globalSection.nonDeleteDiscounts;

  late final List<Discount> result;

  switch (discountFillFilter) {
    case DiscountFillFilter.filled:
      result = filled.values.toList();
      break;

    case DiscountFillFilter.unfilled:
      result = global.entries
          .where((entry) => !filled.containsKey(entry.key))
          .map((entry) => entry.value
              .copyWith(discount: 0)) // Set percent to 0 for missing ones
          .toList();
      break;

    case DiscountFillFilter.all:
    default:
      // Combine: use filled where available, else from global with percent = 0
      final all = <String, Discount>{};

      for (final entry in global.entries) {
        all[entry.key] = filled[entry.key] ?? entry.value.copyWith(discount: 0);
      }

      result = all.values.toList();
      break;
  }

  // Sort alphabetically by productKey
  result.sort((a, b) =>
      a.productKey.toLowerCase().compareTo(b.productKey.toLowerCase()));

  return result;
}

enum DiscountFillFilter {
  all,
  filled,
  unfilled,
}

extension DiscountFillFilterApi on DiscountFillFilter {
  String get label => switch (this) {
        DiscountFillFilter.all => 'All',
        DiscountFillFilter.filled => 'Filled',
        DiscountFillFilter.unfilled => 'Unfilled',
      };

  IconData get icon => switch (this) {
        DiscountFillFilter.all => Icons.list_alt,
        DiscountFillFilter.filled => Icons.check_circle,
        DiscountFillFilter.unfilled => Icons.radio_button_unchecked,
      };
}
