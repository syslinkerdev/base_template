import 'dart:convert';
import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repo/repo.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';

part 'filter_products_stream.g.dart';

@riverpod
Future<List<ProductWithDiscount>> filteredProductsStream(
  Ref ref, {
  required Brand brand,
  required Category category,
  required ProductStatus status,
  Duration? updatedWithin,
}) async {
  final products = await ref.watch(productsStreamXProvider.future);

  final discountSections =
      await ref.watch(discountSectionsStreamXProvider.future);

  final globalSection = discountSections.firstWhere(
    (section) => section.id == DiscountSectionHelpers.GlobalDiscountsDocId,
    orElse: () {
      return DiscountSection.empty();
    },
  );

  final now = DateTime.now();

  final filteredProducts = products.where((product) {
    final sameBrand = product.brand.id == brand.id;
    final sameCategory = product.category.id == category.id;
    final sameStatus = product.status == status;

    final passesUpdatedFilter = updatedWithin == null ||
        (product.updatedAt != null &&
            now.difference(product.updatedAt!).inDays <= updatedWithin.inDays);

    return sameBrand && sameCategory && sameStatus && passesUpdatedFilter;
  }).toList();

  final productWithDiscounts = filteredProducts.map((product) {
    final discount = globalSection.nonDeleteDiscounts.values.firstWhere(
      (d) {
        final refId = d.productReference?.id;
        final productId = product.id;

        return refId == productId;
      },
      orElse: () {
        return Discount.empty();
      },
    );

    return ProductWithDiscount(
      product: product,
      discount: discount.isEmpty ? null : discount,
    );
  }).toList();

  //print('🎯 Final productWithDiscounts count: ${productWithDiscounts.length}');
  return productWithDiscounts;
}

@riverpod
class ForJsonXX extends _$ForJsonXX {
  @override
  FutureOr<void> build() {}

  Future<void> makeJsonProPage(List<Product> products) async {
    print("▶️ Starting makeJsonProPage...");

    // 1. Get products from provider
    print("⏳ Fetching products from provider...");
    print("✅ Fetched ${products.length} products");

    // 2. Convert to JSON List
    print("🔄 Converting products to JSON...");
    final jsonList = products.map((p) => p.toJson()).toList();
    print("✅ Converted to JSON list with ${jsonList.length} items");

    final jsonString = const JsonEncoder.withIndent('  ').convert(jsonList);
    print("📝 JSON String generated (length: ${jsonString.length})");

    // 3. Get app documents directory

    // 4. Write file
    print("💾 Products JSON written to file");
    final dir = await getDownloadsDirectory();
    print("📂 Documents directory: ${dir?.path}");
    if (dir == null) throw Exception("Download directory not available");

    final file = File("${dir.path}/products.json");
    print("📄 File path set: ${file.path}");
    await file.writeAsString(jsonString, flush: true);
    await OpenFilex.open(file.path);

    // 5. Confirm
    print('🎉 Done! Products JSON saved at: ${file.path}');
  }
}
