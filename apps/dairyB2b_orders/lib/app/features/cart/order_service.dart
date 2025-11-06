import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  /// Places a new order
  Future<void> placeOrder({required List<CartItem> orderedProducts}) async {
    final user = _getUserOrThrow();
    final enrichedItems = _enrichCartItems(orderedProducts, user);
    final (originalTotalPrice, totalPrice) = _calculatePrices(enrichedItems);
    final createdAt = DFU.now();
    final currStatus = OrderStatus.placed;

    final order = OrderX(
        orderId: _generateId(enrichedItems.length),
        userUid: user.uid,
        superuserUid: user.superuserUid,
        serviceCharges: user.serviceCharges,
        orderedProducts: enrichedItems,
        totalPrice: totalPrice,
        originalTotalPrice: originalTotalPrice,
        createdBy: user.uid,
        createdAt: createdAt,
        deliveryDate: DFU.nextDay(),
        status: currStatus,
        logs: [logDraft(currStatus, createdAt, user.fullName)]);

    _debugOrder("Placing OrderX", order);

    await ref.read(firestoreServiceProvider).setDocument(
          collectionPath: DbPathManager.orders(),
          documentId: order.orderId,
          data: order.toDocument(),
        );
  }

  /// Updates an existing order
  Future<void> updateOrder({
    required String orderId,
    required List<CartItem> updatedProducts,
  }) async {
    final user = _getUserOrThrow();
    final enrichedItems = _enrichCartItems(updatedProducts, user);
    final (originalTotal, finalTotal) = _calculatePrices(enrichedItems);

    // Fetch existing order to retain original metadata
    final existingOrder = await ref
        .read(dairyB2bRepositoryProvider)
        .fetchOrderById(orderId: orderId);

    if (existingOrder == null) throw Exception('Order not found');
    final updatedAt = DFU.now();
    final currStatus = OrderStatus.edited;

    final updatedOrder = existingOrder.copyWith(
      orderedProducts: enrichedItems,
      totalPrice: finalTotal,
      originalTotalPrice: originalTotal,
      serviceCharges: user.serviceCharges,
      status: currStatus,
      updatedAt: updatedAt,
      logs: [
        ...?existingOrder.logs,
        logDraft(currStatus, updatedAt, user.fullName)
      ],
    );
    _debugOrder("Updating OrderX", updatedOrder);

    await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.orders(),
          documentId: orderId,
          data: updatedOrder.toDocument(),
        );
  }

  /// Create a smart basket
  Future<void> createSmartBasket(
      {required String basketName, required List<CartItem> cartList}) async {
    final user = _getUserOrThrow();
    final enrichedItems = _enrichCartItems(cartList, user, noDiscount: true);

    // log("Creating Smart Basket OrderX ${enrichedItems.toList().toString()}");

    final basket = SmartBasket(
        basketId: _generateId(enrichedItems.length, basket: true),
        basketName: basketName,
        items: enrichedItems,
        createdAt: DateTime.now());

    await ref.read(firestoreServiceProvider).updateDocument(
      collectionPath: DbPathManager.users(),
      documentId: user.uid,
      data: {
        DbStandardFields.smartBaskets:
            (user.smartBaskets ?? []).map((b) => b.toDocument()).toList()
              ..add(basket.toDocument())
      },
    );
  }

  /// Updates an existing smart basket
  Future<void> updateSmartBasket({
    required String basketId,
    required String newBasketName,
    required List<CartItem> newCartList,
  }) async {
    final user = _getUserOrThrow();

    // Enrich items
    final enrichedItems = _enrichCartItems(newCartList, user, noDiscount: true);

    // Find old basket
    final existingBasket = (user.smartBaskets ?? []).firstWhere(
        (b) => b.basketId == basketId,
        orElse: () => throw Exception('Basket not found'));

    // Copy with new values
    final updatedBasket = existingBasket.copyWith(
      basketName: newBasketName,
      items: enrichedItems,
      updatedAt: DateTime.now(),
    );

    // Replace old with updated
    final updatedBaskets = (user.smartBaskets ?? [])
        .map((b) => b.basketId == basketId ? updatedBasket : b)
        .toList();

    await ref.read(firestoreServiceProvider).updateDocument(
      collectionPath: DbPathManager.users(),
      documentId: user.uid,
      data: {
        DbStandardFields.smartBaskets:
            updatedBaskets.map((b) => b.toDocument()).toList(),
      },
    );
  }

  // ----------------- PRIVATE HELPERS -----------------

  /// Get user from global cache or throw error
  UserX _getUserOrThrow() {
    final user = GlobalCacheService.instance.getUser();
    if (user == null) throw Exception('User not found in cache');
    return user;
  }

  /// Add name, price, discount to cart items using cache
  List<CartItem> _enrichCartItems(List<CartItem> items, UserX user,
      {bool noDiscount = false}) {
    final products = GlobalCacheService.instance.getAllProducts();
    final userDiscounts = user.disSection?.productDiscounts.values.toList();
    final productMap = {for (var p in products) p.id: p};
    final discountMap = {
      for (var d in (userDiscounts ?? []))
        d.productReference.id: d.discount.toDouble()
    };

    return items.map((item) {
      final product = productMap[item.productReference?.id];
      final discount = discountMap[item.productReference?.id] ?? 0.0;
      final origLabel = product?.unitDetails.formatTotalWithCount(
          (item.origQty).toDouble(),
          countLabel: product.productType.shortForm);
      return item.copyWith(
        productName: (product != null
            ? '${product.brand.label} ${product.name}'
            : item.productName),
        searchKey: product?.searchKey ?? item.searchKey,
        unitPrice: product?.price ?? item.unitPrice,
        unitLabel: product?.unitDetails.displayLabel ?? item.unitLabel,
        origLabel: origLabel ?? item.origLabel,
        discount: noDiscount ? 0 : discount,
      );
    }).toList();
  }

  (double, double) _calculatePrices(List<CartItem> items) {
    double original = 0.0;
    double discounted = 0.0;

    for (var item in items) {
      final price = item.unitPrice ?? 0.0;
      final discount = item.discount;
      original += price * item.origQty;
      discounted += (price - discount) * item.origQty;
    }

    return (original, discounted);
  }

  /// Creates a unique readable order ID
  String _generateId(int itemCount, {bool basket = false}) {
    final now = DateTime.now();
    final datePart = '${now.year % 100}${now.month}${now.day}'; // YYMMDD
    final timeCode =
        now.microsecondsSinceEpoch.toRadixString(36).substring(2, 6);
    final String opening = basket ? 'BAS' : 'ORD';
    return '$opening-$datePart-$itemCount-$timeCode';
  }

  void _debugOrder(String label, OrderX order) {
    //print('✅ $label');
    //print('OrderX: ${order.toJson()}');
  }
}
