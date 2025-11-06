import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';

part 'order_service.g.dart';

@riverpod
OrderService orderService(Ref ref) {
  return OrderService(ref: ref);
}

class OrderService {
  OrderService({required this.ref});
  final Ref ref;

  String logDraft(OrderStatus status, DateTime date, String editorName) {
    final draft =
        '${status.emoji} Order ${status.label.toLowerCase()} by $editorName '
        'at ${DFU.ddMMyyyy(date)} ${DFU.timeOnly12h(date)}';
    return draft;
  }

  /// Places a new order for client by admin
  Future<void> placeOrder(
      {required List<Product> orderedProducts, required UserX user}) async {
    final enrichedItems = _getCartItems(orderedProducts, user);
    final (originalTotal, finalTotal) = _calculatePrices(enrichedItems);
    final createdAt = DFU.now();
    final currStatus = OrderStatus.placed;
    final editorDetails = await _getEditorDetails();
    if (editorDetails == null) throw Exception('Editor details not found');
    final order = OrderX(
        orderId: _generateId(enrichedItems.length),
        userUid: user.uid,
        superuserUid: user.superuserUid,
        serviceCharges: user.serviceCharges,
        orderedProducts: enrichedItems,
        totalPrice: finalTotal,
        originalTotalPrice: originalTotal,
        createdBy: editorDetails.uid,
        createdAt: createdAt,
        deliveryDate: DFU.nextDay(),
        status: currStatus,
        logs: [logDraft(currStatus, createdAt, editorDetails.fullName)]);

    _debugOrder("Placing OrderX For User", order);

    await ref.read(firestoreServiceProvider).setDocument(
          collectionPath: DbPathManager.orders(),
          documentId: order.orderId,
          data: order.toDocument(),
        );
  }

  /// Updates an existing order
  Future<void> modifyOrder({
    required List<Product> orderedProducts,
    required UserX user,
    required OrderX previousOrder,
  }) async {
    // Get enriched items
    final enrichedItems = _getCartItems(orderedProducts, user);
    // Calculate totals
    final (originalTotal, finalTotal) = _calculatePrices(enrichedItems);
    // Get editor details
    final updatedAt = DFU.now();
    final currStatus = OrderStatus.modified;
    final editorDetails = await _getEditorDetails();
    if (editorDetails == null) {
      throw Exception('Editor details not found');
    }
    // Build modified order
    final modifiedOrder = previousOrder.copyWith(
      orderedProducts: enrichedItems,
      totalPrice: finalTotal,
      originalTotalPrice: originalTotal,
      updatedAt: updatedAt,
      serviceCharges: user.serviceCharges,
      status: currStatus,
      logs: [
        ...?previousOrder.logs,
        logDraft(currStatus, updatedAt, editorDetails.fullName)
      ],
    );
    // Debug detailed order info (if your method prints product details)
    _debugOrder("modifying OrderX For User", modifiedOrder);
    // Firestore update
    await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.orders(),
          documentId: modifiedOrder.orderId,
          data: modifiedOrder.toDocument(),
        );
  }

  /// Adjusting an existing order
  Future<void> adjustOrder({
    required List<Product> orderedProducts,
    required UserX user,
    required OrderX previousOrder,
  }) async {
    // Get enriched items
    final enrichedItems =
        _prepareAdjustedCartItems(orderedProducts, user, previousOrder);
    // Calculate totals
    final (originalTotal, finalTotal) = _calculatePrices(enrichedItems);
    // Get editor details
    final updatedAt = DFU.now();
    final currStatus = OrderStatus.adjusted;
    final editorDetails = await _getEditorDetails();
    if (editorDetails == null) {
      throw Exception('Editor details not found');
    }
    // Build adjusted order
    final adjustedOrder = previousOrder.copyWith(
      orderedProducts: enrichedItems,
      totalPrice: finalTotal,
      originalTotalPrice: originalTotal,
      updatedAt: updatedAt,
      serviceCharges: user.serviceCharges,
      status: currStatus,
      logs: [
        ...?previousOrder.logs,
        logDraft(currStatus, updatedAt, editorDetails.fullName)
      ],
    );
    // Debug detailed order info (if your method prints product details)
    _debugOrder("Adjusting OrderX For User", adjustedOrder);
    // Firestore update
    await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.orders(),
          documentId: adjustedOrder.orderId,
          data: adjustedOrder.toDocument(),
        );
  }

  /// Soft-delete an existing order while preserving history
  Future<void> deleteOrder({required OrderX order}) async {
    // Get editor details
    final updatedAt = DFU.now();
    final currStatus = OrderStatus.deleted;
    final editorDetails = await _getEditorDetails();
    if (editorDetails == null) {
      throw Exception('Editor details not found');
    }

    // Mark all items as deleted
    final deletedItems = order.orderedProducts.map((item) {
      return item.copyWith(
        adjQty: 0, // totals calculation ignores this
        adjLabel: 'Deleted', // shows deletion in UI
        origQty: 0, // totals calculation ignores this
      );
    }).toList();

    // Build updated order with status deleted
    final deletedOrder = order.copyWith(
      orderedProducts: deletedItems,
      totalPrice: 0.0,
      originalTotalPrice: 0.0,
      serviceCharges: 0.0,
      status: currStatus,
      updatedAt: updatedAt,
      logs: [
        ...?order.logs,
        logDraft(currStatus, updatedAt, editorDetails.fullName)
      ],
    );

    _debugOrder("Deleting OrderX For User", deletedOrder);

    // Firestore update
    await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.orders(),
          documentId: deletedOrder.orderId,
          data: deletedOrder.toDocument(),
        );
  }

  // ----------------- PRIVATE HELPERS -----------------

  /// Gets Editor Details
  Future<UserX?> _getEditorDetails() async {
    final editorId = ref.read(appStateXProvider).uId; // synchronous
    final userAsync =
        await ref.read(fetchUserProvider(documentId: editorId).future);
    return userAsync; // UserX or null if provider returns empty
  }

  /// Gets enriched cart items with discounts and formatted labels
  List<CartItem> _getCartItems(List<Product> orderedProducts, UserX user) {
    final discounts = user.disSection?.productDiscounts.values ?? [];
    final discountMap = {
      for (final d in discounts) d.productReference?.id: d.discount.toDouble(),
    };

    final firestore = FirebaseFirestore.instance;

    return orderedProducts
        .where((pro) => (pro.userSideQuantity ?? 0) > 0) // Skip zero quantity
        .map((pro) {
      final discount = discountMap[pro.id] ?? 0.0;
      final unitDetails = pro.unitDetails;
      final origLabel = unitDetails.formatTotalWithCount(
        (pro.userSideQuantity ?? 0).toDouble(),
        countLabel: pro.productType.shortForm,
      );
      final productName = '${pro.brand.label} ${pro.name}';

      return CartItem(
        origQty: pro.userSideQuantity ?? 0,
        productReference:
            firestore.doc(DbPathManager.product(productId: pro.id)),
        productName: productName,
        searchKey: pro.searchKey,
        unitPrice: pro.price,
        unitLabel: unitDetails.displayLabel,
        origLabel: origLabel,
        discount: discount,
      );
    }).toList();
  }

  /// Prepares enriched cart items for Adjust Order with discounts and formatted labels
  List<CartItem> _prepareAdjustedCartItems(
    List<Product> orderedProducts,
    UserX user,
    OrderX? previousOrder,
  ) {
    final firestore = FirebaseFirestore.instance;

    // Map of product discounts for quick access
    final discounts = user.disSection?.productDiscounts.values ?? [];
    final discountMap = {
      for (final d in discounts) d.productReference?.id: d.discount.toDouble(),
    };

    // Map of new products by ID for quick lookup
    final newProductsMap = {for (final p in orderedProducts) p.id: p};

    // Set of previous product IDs (to efficiently check deletions)
    final prevIds = previousOrder?.orderedProducts
            .map((item) => item.productReference?.id)
            .toSet() ??
        {};

    final allProducts = <CartItem>[];

    // 1️⃣ Handle previous items (adjusted or deleted)
    if (previousOrder != null) {
      for (final prevItem in previousOrder.orderedProducts) {
        final prodId = prevItem.productReference?.id;
        final newPro = newProductsMap[prodId];

        // 🧹 CASE 1: Newly added item (origQty == 0) now deleted → skip completely
        if (newPro == null && prevItem.origQty == 0) {
          print(
              '🧹 Removing new item that was deleted: ${prevItem.productName}');
          continue;
        }

        // 🗑 CASE 2: Existing old item now deleted → mark as Deleted
        if (newPro == null) {
          print('❌ Marking old item as deleted: ${prevItem.productName}');
          allProducts.add(prevItem.copyWith(
            adjQty: 0,
            adjLabel: 'Deleted',
          ));
          continue;
        }

        // 🧾 CASE 3: Existing item still present
        final userQty = newPro.userSideQuantity ?? 0;

        // 🧹 CASE 4: Previously new item reset to 0 → skip it
        if (prevItem.origQty == 0 && userQty == 0) {
          print(
              '🧹 Removing newly added item that was reset to 0: ${newPro.name}');
          continue;
        }

        // Determine if quantity actually changed
        final adjQty = (prevItem.origQty == userQty) ? null : userQty;

        // Prepare label for adjustment
        final adjLabel = adjQty != null
            ? newPro.unitDetails.formatTotalWithCount(
                adjQty.toDouble(),
                countLabel: newPro.productType.shortForm,
              )
            : null;

        // If quantity becomes 0 → mark as Deleted (retain history)
        final adjLabelX = userQty == 0 ? 'Deleted' : adjLabel;
        final adjQtyX = userQty == 0 ? 0 : adjQty;

        print(
            '📦 Updating item: ${newPro.name}, userQty=$userQty, origQty=${prevItem.origQty}, adjQty=$adjQtyX, adjLabel=$adjLabelX');

        allProducts.add(CartItem(
          origQty: prevItem.origQty,
          adjQty: adjQtyX,
          productReference: prevItem.productReference,
          productName: '${newPro.brand.label} ${newPro.name}',
          searchKey: newPro.searchKey,
          unitPrice: newPro.price,
          unitLabel: newPro.unitDetails.displayLabel,
          origLabel: prevItem.origLabel,
          adjLabel: adjLabelX,
          discount: prevItem.discount, // ✅ Keep old day’s discount
        ));
      }
    }

    // 2️⃣ Handle new items (not present in previous order)
    for (final pro in orderedProducts) {
      if (!prevIds.contains(pro.id)) {
        final userQty = pro.userSideQuantity ?? 0;
        if (userQty == 0) {
          print('⚠️ Skipping new item with 0 qty: ${pro.name}');
          continue; // ✅ Prevents accidental 0-qty new entries
        }

        final adjLabel = pro.unitDetails.formatTotalWithCount(
          userQty.toDouble(),
          countLabel: pro.productType.shortForm,
        );

        allProducts.add(CartItem(
          origQty: 0,
          adjQty: userQty,
          productReference:
              firestore.doc(DbPathManager.product(productId: pro.id)),
          productName: '${pro.brand.label} ${pro.name}',
          searchKey: pro.searchKey,
          unitPrice: pro.price,
          unitLabel: pro.unitDetails.displayLabel,
          origLabel: 'New',
          adjLabel: adjLabel,
          discount: discountMap[pro.id] ?? 0.0,
        ));
      }
    }

    print('✅ Final prepared cart items count: ${allProducts.length}');
    return allProducts;
  }

  (double, double) _calculatePrices(List<CartItem> items) {
    double original = 0.0;
    double discounted = 0.0;

    for (var pro in items) {
      final price = pro.unitPrice ?? 0.0;
      final discount = pro.discount;
      original += price * (pro.adjQty ?? pro.origQty);
      discounted += (price - discount) * (pro.adjQty ?? pro.origQty);
    }

    return (original, discounted);
  }

  /// Creates a unique readable order ID
  String _generateId(int itemCount) {
    final now = DateTime.now();
    final datePart = '${now.year % 100}${now.month}${now.day}'; // YYMMDD
    final timeCode =
        now.microsecondsSinceEpoch.toRadixString(36).substring(2, 6);
    final String opening = 'ORD';
    return '$opening-$datePart-$itemCount-$timeCode';
  }

  void _debugOrder(String label, OrderX order) {
    print('✅ $label ------------------------');
    // print('OrderX: ${order.toJson()}');
  }
}
