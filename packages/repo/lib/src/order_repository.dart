part of 'package:repo/repo.dart';

extension OrderRepository on DairyB2bRepository {
  Future<List<OrderX>> fetchOrdersLast3days({required String uId}) async {
    // print('📦 API: fetchOrdersLast3days called');

    final nextDay = DateTime.now().add(const Duration(days: 1));
    final threeDaysAgo = nextDay.subtract(const Duration(days: 2));

    // Start and end timestamps based on deliveryDate
    final fromTimestamp = Timestamp.fromDate(
        DateTime(threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day));
    final toTimestamp = Timestamp.fromDate(
        DateTime(nextDay.year, nextDay.month, nextDay.day)
            .add(const Duration(days: 1)));

    // print('📅 Current Time: $nextDay');
    // print('📅 3 Days Ago Cutoff: $threeDaysAgo');
    final response = await _service.getDocumentsWithQuery<OrderX>(
      collectionPath: DbPathManager.orders(),
      converter: (snapshot) => OrderX.fromJson(snapshot.data()),
      buildQuery: (collectionRef) => collectionRef
          .where(DbStandardFields.userUid, isEqualTo: uId)
          .where(DbStandardFields.deliveryDate,
              isGreaterThanOrEqualTo: fromTimestamp)
          .where(DbStandardFields.deliveryDate,
              isLessThanOrEqualTo: toTimestamp)
          .orderBy(DbStandardFields.deliveryDate, descending: true),
    );
    // for (final order in response) {
    //   print('📝 Order Time: ${order.deliveryDate}');
    // }

    return response;
  }

  Future<List<MainOrder>> fetchMainOrdersLast3days(
      {bool forActualDelivery = false}) async {
    //print('📦 API: fetchOrdersLast3days called');
    final path = forActualDelivery
        ? DbPathManager.actualDeliveries()
        : DbPathManager.masterOrders();
    final nextDay = DateTime.now().add(const Duration(days: 1));
    final threeDaysAgo = nextDay.subtract(const Duration(days: 2));
    // Start and end timestamps based on deliveryDate
    final fromTimestamp = Timestamp.fromDate(
        DateTime(threeDaysAgo.year, threeDaysAgo.month, threeDaysAgo.day));
    final toTimestamp = Timestamp.fromDate(
        DateTime(nextDay.year, nextDay.month, nextDay.day)
            .add(const Duration(days: 1)));

    //print('📅 Current Time: $now');
    //print('📅 3 Days Ago Cutoff: $threeDaysAgo');
    final response = await _service.getDocumentsWithQuery<MainOrder>(
      serverOnly: true,
      collectionPath: path,
      converter: (snapshot) => MainOrder.fromJson(snapshot.data()),
      buildQuery: (collectionRef) => collectionRef
          .where(DbStandardFields.deliveryDate,
              isGreaterThanOrEqualTo: fromTimestamp)
          .where(DbStandardFields.deliveryDate,
              isLessThanOrEqualTo: toTimestamp)
          .orderBy(DbStandardFields.deliveryDate, descending: true),
    );
    // for (final mainOrder in response) {
    //  print(
    //   '📝 Main Order Time: ${mainOrder.createdAt} ${mainOrder.mainOrderId}');
    // }

    return response;
  }

  Future<OrderX?> fetchSingleOrder({
    required String uId,
    required DateTime day,
  }) async {
    //print('📦 API: fetchSingleOrder called');

    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final fromTimestamp = Timestamp.fromDate(startOfDay);
    final toTimestamp = Timestamp.fromDate(endOfDay);

    //print('📅 Checking for order on: $startOfDay');

    final results = await _service.getDocumentsWithQuery<OrderX>(
      collectionPath: DbPathManager.orders(),
      converter: (snapshot) => OrderX.fromJson(snapshot.data()),
      buildQuery: (collectionRef) => collectionRef
          .where(DbStandardFields.userUid, isEqualTo: uId)
          .where(DbStandardFields.deliveryDate,
              isGreaterThanOrEqualTo: fromTimestamp)
          .where(DbStandardFields.deliveryDate, isLessThan: toTimestamp)
          .orderBy(DbStandardFields.deliveryDate)
          .limit(1),
    );

    return results.isNotEmpty ? results.first : null;
  }

  Future<bool> didUserOrder({required String uId}) async {
    //print('📦 API: didUserOrder called');

    final results = await _service.getDocumentsWithQuery<OrderX>(
      collectionPath: DbPathManager.orders(),
      converter: (snapshot) => OrderX.fromJson(snapshot.data()),
      buildQuery: (collectionRef) => collectionRef
          .where(DbStandardFields.userUid, isEqualTo: uId)
          .limit(1),
    );

    // if (results.isNotEmpty) {
    //   print('📦 User has placed an order.');
    //   for (final order in results) {
    //     print('📝 Order ID: ${order.orderId}');
    //     print('📝 Order Time: ${order.creationTime}');
    //   }
    // } else {
    //   print('📦 No orders found for the user.');
    // }

    return results.isNotEmpty;
  }

  Future<OrderX?> fetchOrderById({required String orderId}) async {
    final response = await _service.getDocument(
      collectionPath: DbPathManager.orders(),
      documentId: orderId,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return OrderX.fromJson(data);
        } else {
          return null;
        }
      },
    );
    return response;
  }

  Future<bool> doesOrderExistForNextDay({required String uId}) async {
    // print('⚡ Checking if user has placed order today $uId');

    final nextDay = DateTime.now().add(const Duration(days: 1));

    final startOfNextDay = DateTime(nextDay.year, nextDay.month, nextDay.day);
    final endOfNextDay = startOfNextDay.add(const Duration(days: 1));

    final fromTimestamp = Timestamp.fromDate(startOfNextDay);
    final toTimestamp = Timestamp.fromDate(endOfNextDay);

    final result = await _service.getDocumentsWithQuery(
      collectionPath: DbPathManager.orders(),
      converter: (p0) => true,
      buildQuery: (collectionRef) => collectionRef
          .where(DbStandardFields.userUid, isEqualTo: uId)
          .where(DbStandardFields.deliveryDate,
              isGreaterThanOrEqualTo: fromTimestamp)
          .where(DbStandardFields.deliveryDate, isLessThan: toTimestamp)
          .limit(1), // 👈 only check for existence
    );

    final exists = result.isNotEmpty;
    // print('✅ Today order exists? $exists');
    return exists;
  }

  Stream<List<OrderX>> fetchOrdersStream({bool forActualDelivery = false}) {
    final day = forActualDelivery
        ? DateTime.now()
        : DateTime.now().add(const Duration(days: 1));
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    final fromTimestamp = Timestamp.fromDate(startOfDay);
    final toTimestamp = Timestamp.fromDate(endOfDay);

    return _service.getDocumentsStreamWithQuery<OrderX>(
      collectionPath: DbPathManager.orders(),
      buildQuery: (collectionRef) => collectionRef
          .where(DbStandardFields.deliveryDate,
              isGreaterThanOrEqualTo: fromTimestamp)
          .where(DbStandardFields.deliveryDate, isLessThan: toTimestamp)
          .orderBy(DbStandardFields.deliveryDate),
      converter: (snapshot) => OrderX.fromJson(snapshot.data()!),
    );
  }

  Future<List<OrderX>> fetchOrdersOfDate({required DateTime date}) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    // print('object');
    final fromTimestamp = Timestamp.fromDate(startOfDay);
    final toTimestamp = Timestamp.fromDate(endOfDay);

    return _service.getDocumentsWithQuery<OrderX>(
      collectionPath: DbPathManager.orders(),
      buildQuery: (collectionRef) => collectionRef
          .where(DbStandardFields.deliveryDate,
              isGreaterThanOrEqualTo: fromTimestamp)
          .where(DbStandardFields.deliveryDate, isLessThan: toTimestamp)
          .orderBy(DbStandardFields.deliveryDate),
      converter: (snapshot) => OrderX.fromJson(snapshot.data()),
    );
  }

  Stream<MainOrder?> fetchMainOrderStream(
      {required String id, bool forActualDelivery = false}) {
    final path = forActualDelivery
        ? DbPathManager.actualDeliveries()
        : DbPathManager.masterOrders();
    final response = _service.getDocumentStream(
      collectionPath: path,
      documentId: id,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return MainOrder.fromJson(data);
        } else {
          return null;
        }
      },
    );
    return response;
  }

  Stream<List<ProductLine>> fetchProductLinesStream(
      {required String id, bool forActualDelivery = false}) {
    final path = forActualDelivery
        ? DbPathManager.actualDelivery(id: id)
        : DbPathManager.masterOrder(id: id);
    return _service.getDocumentsStream<ProductLine>(
      collectionPath: DbPathManager.productLines(path: path),
      converter: (snapshot) {
        final raw = snapshot.data();
        //print('🔥 Raw ProductLine: ${raw?.length}');
        final section = ProductLine.fromJson(raw!);
        return section;
      },
    );
  }

  Stream<List<DemandLine>> fetchDemandLinesStream(
      {required String id, bool forActualDelivery = false}) {
    final path = forActualDelivery
        ? DbPathManager.actualDelivery(id: id)
        : DbPathManager.masterOrder(id: id);
    return _service.getDocumentsStream<DemandLine>(
      collectionPath: DbPathManager.demandLines(path: path),
      converter: (snapshot) {
        final raw = snapshot.data();
        //print('🔥 Raw DemandLine: ${raw?.length}');
        final section = DemandLine.fromJson(raw!);
        return section;
      },
    );
  }
}
