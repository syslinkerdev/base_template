import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:repo/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generator_provider.g.dart';

@riverpod
class GeneratorX extends _$GeneratorX {
  @override
  FutureOr<String?> build() => null;

  Future<void> generateCompanyOrder(
      {required String companyId, bool forActualDelivery = false}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _generateCompanyOrderCore(
          companyId: companyId, forActualDelivery: forActualDelivery);
      return null;
    });
  }

  Future<void> generateAllCompanyOrders(
      {
      // 🔑 Option A = only companies with orders, Option B = all brands
      bool processAllBrands = false,
      bool forActualDelivery = false}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Load master catalog
      _updateCommentary('📚 Loading master catalog...');
      final maker = await ref.read(fetchProductMakerProvider.future);

      // Load today’s orders + products
      _updateCommentary('📥 Fetching today\'s orders...');
      final orders = await ref.read(
          OrdersStreamXProvider(forActualDelivery: forActualDelivery).future);
      print('⚠️ Orders length ${orders.length}');

      _updateCommentary('📦 Fetching product list...');
      final products = await ref.read(productsStreamXProvider.future);

      // Determine companies
      final companyIds = <String>{};
      if (!processAllBrands) {
        _updateCommentary('🏷️ Finding companies with active orders...');
        for (final order in orders) {
          for (final item in order.orderedProducts) {
            final product = products.firstWhere(
              (p) => p.id == item.productReference?.id,
              orElse: () => Product.empty(),
            );
            if (product.isNotEmpty) {
              companyIds.add(product.brand.id);
            } else {
              print(
                  '⚠️ Product not found for item: ${item.productReference?.id}');
            }
          }
        }
        _updateCommentary(
            '📑 Found ${companyIds.length} companies with orders.');
      } else {
        _updateCommentary('🏷️ Selecting all catalog companies...');
        for (final brand in maker?.brands ?? []) {
          companyIds.add(brand.id);
        }
        _updateCommentary(
            '📑 Selected ${companyIds.length} companies from catalog.');
      }

      // Generate reports
      for (final companyId in companyIds) {
        _updateCommentary('📝 Generating order for company: $companyId...');
        await _generateCompanyOrderCore(
            companyId: companyId, forActualDelivery: forActualDelivery);
      }

      _updateCommentary('✅ All company orders generated successfully!');
      return null;
    });
  }

  Future<void> _generateCompanyOrderCore({
    required String companyId,
    bool forActualDelivery = false,
  }) async {
    final id = forActualDelivery
        ? IdGenerator.actualDeliveryId()
        : IdGenerator.mainOrderId();

    final path = forActualDelivery
        ? DbPathManager.actualDeliveries()
        : DbPathManager.masterOrders();
    final pathWithId = forActualDelivery
        ? DbPathManager.actualDelivery(id: id)
        : DbPathManager.masterOrder(id: id);
    final now = DFU.now();
    final deliveryDate = forActualDelivery ? now : DFU.nextDay();
    try {
      // Step 1: Orders
      _updateCommentary(
          "📥 [1/8] Fetching today's orders for company: $companyId...");
      final orders = await ref.read(
          OrdersStreamXProvider(forActualDelivery: forActualDelivery).future);
      print("[1/8] Fetched ${orders.length} orders");

      // Step 2: Discounts
      _updateCommentary('💸 [2/8] Fetching global discount sections...');
      final discountSections =
          await ref.read(discountSectionsStreamXProvider.future);
      print("[2/8] Discount sections fetched: ${discountSections.length}");

      final globalDiscounts = discountSections
          .firstWhere(
            (section) =>
                section.id == DiscountSectionHelpers.GlobalDiscountsDocId,
            orElse: () => DiscountSection.empty(),
          )
          .nonDeleteDiscounts;
      print("[2/8] Global discounts count: ${globalDiscounts.length}");

      // Step 3: Catalog
      _updateCommentary('📚 [3/8] Fetching product catalog...');
      final products = await ref.read(productsStreamXProvider.future);
      print("[3/8] Products fetched: ${products.length}");

      final fs = ref.read(firestoreServiceProvider);

      // Step 4: Build product lines
      _updateCommentary('🛠 [4/8] Building product lines...');
      final productLines = await _buildProductLines(
          orders: orders,
          companyId: companyId,
          globalDiscounts: globalDiscounts,
          products: products,
          now: now,
          forActualDelivery: forActualDelivery);
      print("[4/8] Product lines built: ${productLines.length}");

      // Step 5: Build demand lines
      _updateCommentary('🛠 [5/8] Building demand lines...');
      final demandLines = await _buildDemandLines(
          orders: orders,
          companyId: companyId,
          companyName: productLines.isNotEmpty
              ? productLines.first.companyName
              : "Unknown",
          globalDiscounts: globalDiscounts,
          products: products,
          id: id,
          now: now,
          forActualDelivery: forActualDelivery);
      print("[5/8] Demand lines built: ${demandLines.length}");

      if (productLines.isEmpty) {
        _updateCommentary('⚠️ No products found for $companyId. Skipping...');
        print("[⚠️] No product lines found for $companyId");
        return;
      }

      // Step 6: Totals
      _updateCommentary('🧮 [6/8] Calculating totals...');
      final double companyTotal = productLines.fold(
          0, (sum, p) => sum + (p.unitPrice * p.totalQuantity));
      final double companyTotalAfterDis = productLines.fold(
          0, (sum, p) => sum + ((p.unitPrice - p.discount) * p.totalQuantity));
      final double totalServiceCharges =
          orders.fold<double>(0, (sum, o) => sum + (o.serviceCharges));

      final int prodCount =
          productLines.fold(0, (sum, p) => sum + p.totalQuantity);
      final whoOrdered = orders.map((o) => o.userUid).toSet();
      final whoOrderedForThisCom = demandLines.map((d) => d.clientId).toSet();
      final companyName = productLines.first.companyName;

      print(
          "[6/8] Totals calculated: companyTotal=$companyTotal, afterDiscount=$companyTotalAfterDis");

      // Step 7: MainOrder
      _updateCommentary('📝 [7/8] Updating main order document...');
      final existing = await fs.getDocument(
        collectionPath: path,
        documentId: id,
        converter: (s) =>
            s.data() == null ? null : MainOrder.fromJson(s.data()!),
      );
      print("[7/8] Existing main order fetched: ${existing != null}");

      final companyEntry = CompanyEntry(
        companyId: companyId,
        companyName: companyName,
        total: companyTotal,
        totalAfterDis: companyTotalAfterDis,
        prodCount: prodCount,
        clientCount: whoOrderedForThisCom.length,
        createdAt: now,
      );

      MainOrder updated;
      if (existing == null || existing.isEmpty) {
        updated = MainOrder(
          mainOrderId: id,
          deliveryDate: deliveryDate,
          companies: [companyEntry],
          overallTotal: companyTotal,
          overallTotalAfterDis: companyTotalAfterDis,
          serviceCharges: totalServiceCharges,
          noOfProducts: prodCount,
          noOfClients: whoOrdered.length,
          generatedBy: ref.read(appStateXProvider).uId,
          createdAt: now,
        );
      } else {
        final companies = [...existing.companies]
          ..removeWhere((c) => c.companyId == companyId)
          ..add(companyEntry);

        final newOverall = companies.fold(0.0, (sum, c) => sum + c.total);
        final newOverallAfter =
            companies.fold(0.0, (sum, c) => sum + c.totalAfterDis);
        final newNoProducts = companies.fold(0, (sum, c) => sum + c.prodCount);

        updated = existing.copyWith(
          companies: companies,
          overallTotal: newOverall,
          overallTotalAfterDis: newOverallAfter,
          serviceCharges: totalServiceCharges,
          noOfProducts: newNoProducts,
          noOfClients: whoOrdered.length,
        );
      }

      _updateCommentary('💾 [7a] Saving main order...');
      await fs.setDocument(
        collectionPath: path,
        documentId: id,
        data: updated.toDocument(),
      );
      print("[7a] Main order saved for $companyName");

      // Step 8: Children
      _updateCommentary('📦 [8/8] Saving product & demand lines...');
      final operations = <void Function(WriteBatch)>[];

      for (final pl in productLines) {
        operations.add((batch) {
          final doc = fs.firestore
              .collection(DbPathManager.productLines(path: pathWithId))
              .doc("${pl.companyId}_${pl.productId}");
          batch.set(doc, pl.toDocument());
        });
      }

      for (final dl in demandLines) {
        operations.add((batch) {
          final doc = fs.firestore
              .collection(DbPathManager.demandLines(path: pathWithId))
              .doc("${dl.companyId}_${dl.clientId}");
          batch.set(doc, dl.toDocument());
        });
      }

      await fs.runBatchedWrites(operations);
      print("[8/8] Product & demand lines saved successfully");

      _updateCommentary('✅ Done! Order generated for $companyName.');
    } catch (e, st) {
      print("❌ Error in _generateCompanyOrderCore: $e");
      print(st);
      rethrow;
    }
  }

  void _updateCommentary(String message) {
    // If state is loading or has data, replace with updated message
    state = AsyncData(message);
    debugPrint('💬 $message');
  }

  Future<List<ProductLine>> _buildProductLines({
    required List<OrderX> orders,
    required String companyId,
    required Map<String, Discount> globalDiscounts,
    required List<Product> products,
    required DateTime now,
    bool forActualDelivery = false,
  }) async {
    final productLines = <ProductLine>[];

    for (final order in orders) {
      for (final item in order.orderedProducts) {
        final product = products.firstWhere(
          (p) => p.id == item.productReference?.id,
          orElse: () => Product.empty(),
        );

        // Skip if product invalid or not of this company
        if (product.isEmpty || product.brand.id != companyId) continue;

        // ✅ Prefer adjQty when forActualDelivery = true
        final quantity =
            forActualDelivery ? (item.adjQty ?? item.origQty) : item.origQty;

        // Skip if quantity is 0 or less
        if (quantity <= 0) continue;

        // Discount
        final discount = globalDiscounts.values.firstWhere(
          (gd) => gd.productReference?.id == product.id,
          orElse: () => Discount.empty(),
        );

        final subtotal = product.price * quantity;

        final existingIndex = productLines.indexWhere(
          (pl) => pl.productId == product.id && pl.companyId == companyId,
        );

        if (existingIndex >= 0) {
          final existing = productLines[existingIndex];
          productLines[existingIndex] = existing.copyWith(
            totalQuantity: existing.totalQuantity + quantity,
            subtotal: existing.subtotal + subtotal,
          );
        } else {
          productLines.add(ProductLine(
            companyId: companyId,
            companyName: product.brand.label,
            productId: product.id,
            productName: product.name,
            productKey: product.searchKey,
            unitDetails: product.unitDetails,
            productType: product.productType,
            totalQuantity: quantity,
            unitPrice: product.price,
            discount: discount.discount,
            subtotal: subtotal,
          ));
        }
      }
    }

    return productLines;
  }

  Future<List<DemandLine>> _buildDemandLines({
    required List<OrderX> orders,
    required String companyId,
    required String companyName,
    required Map<String, Discount> globalDiscounts,
    required List<Product> products,
    required String id,
    required DateTime now,
    bool forActualDelivery = false,
  }) async {
    final demandLines = <DemandLine>[];

    // preload users for lookup
    final allUsers = await ref.watch(usersStreamProvider.future);

    for (final order in orders) {
      final clientProducts = <DemandLineItem>[];
      double clientTotal = 0;

      for (final item in order.orderedProducts) {
        final product = products.firstWhere(
          (p) => p.id == item.productReference?.id,
          orElse: () => Product.empty(),
        );

        // Skip invalid or other-company products
        if (product.isEmpty || product.brand.id != companyId) continue;

        // ✅ Prefer adjusted quantity if enabled
        final quantity =
            forActualDelivery ? (item.adjQty ?? item.origQty) : item.origQty;

        // Skip if quantity invalid or zero
        if (quantity <= 0) continue;

        final discount = globalDiscounts.values.firstWhere(
          (gd) => gd.productReference?.id == product.id,
          orElse: () => Discount.empty(),
        );

        final subtotal = product.price * quantity;

        clientProducts.add(DemandLineItem(
          productId: product.id,
          productName: product.name,
          productKey: product.searchKey,
          unitDetails: product.unitDetails,
          productType: product.productType,
          quantity: quantity,
          unitPrice: product.price,
          discount: discount.discount,
          subtotal: subtotal,
        ));

        clientTotal += subtotal;
      }

      if (clientProducts.isEmpty) continue;

      // lookup client details
      final user = allUsers.firstWhere(
        (u) => u.uid == order.userUid,
        orElse: () => UserX.empty(),
      );

      demandLines.add(DemandLine(
        createdAt: now,
        orderId: "${id}_${order.orderId}",
        companyId: companyId,
        companyName: companyName,
        clientId: order.userUid,
        clientName: '${user.firstName} ${user.lastName}',
        shopName: user.shopName,
        shopAddress: user.shopAddress,
        products: clientProducts,
        clientTotal: clientTotal,
      ));
    }

    return demandLines;
  }
}
