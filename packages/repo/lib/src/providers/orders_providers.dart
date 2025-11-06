part of 'package:repo/repo.dart';

// fetchOrderListLast3daysProvider
@riverpod
FutureOr<List<OrderX>> fetchOrderListLast3days(Ref ref, {required String uId}) {
  return ref.read(dairyB2bRepositoryProvider).fetchOrdersLast3days(uId: uId);
}

// fetchMainOrderListLast3daysProvider
@riverpod
FutureOr<List<MainOrder>> fetchMainOrderListLast3days(Ref ref,
    {bool forActualDelivery = false}) {
  return ref
      .read(dairyB2bRepositoryProvider)
      .fetchMainOrdersLast3days(forActualDelivery: forActualDelivery);
}

// fetchOrderForDayProvider
@riverpod
FutureOr<OrderX?> fetchOrder(Ref ref,
    {required String uId, required DateTime day}) {
  return ref
      .read(dairyB2bRepositoryProvider)
      .fetchSingleOrder(uId: uId, day: day);
}

// didUserOrderProvider
@riverpod
FutureOr<bool> didUserOrder(Ref ref, {required String uId}) {
  return ref.read(dairyB2bRepositoryProvider).didUserOrder(uId: uId);
}

// doesOrderExistForTodayProvider
@Riverpod(keepAlive: true)
FutureOr<bool> doesOrderExistForNextDay(Ref ref, {required String uId}) async =>
    await ref.read(dairyB2bRepositoryProvider).doesOrderExistForNextDay(uId: uId);

@Riverpod(keepAlive: true)
class OrdersStreamX extends _$OrdersStreamX {
  @override
  FutureOr<List<OrderX>> build({bool forActualDelivery = false}) async {
    final repo = ref.read(dairyB2bRepositoryProvider);
    try {
      final initial = await repo
          .fetchOrdersStream(forActualDelivery: forActualDelivery)
          .first;
      final filtered = initial.whereType<OrderX>().toList();
      state = AsyncValue.data(filtered);

      // //print(
      //     '✅ OrdersStreamX initial loaded: ${state.value?.length} orders');

      repo.fetchOrdersStream(forActualDelivery: forActualDelivery).listen(
        (orders) {
          state = AsyncValue.data(orders.whereType<OrderX>().toList());
          // //print(
          //     '📡 OrdersStreamX updated: ${(state.valueOrNull?.length ?? 0)} orders');
        },
        onError: (err) {
          //print('❌ OrdersStreamX error: $err');
        },
      );

      return filtered;
    } catch (err) {
      //print('❌ Initial load failed: $err');
      throw err; // This error gets passed to .when(error: ...)
    }
  }
}

@Riverpod(keepAlive: true)
class MainOrderStream extends _$MainOrderStream {
  @override
  FutureOr<MainOrder?> build(
      {required String id, bool forActualDelivery = false}) async {
    final repo = ref.read(dairyB2bRepositoryProvider);
    try {
      final initial = await repo
          .fetchMainOrderStream(id: id, forActualDelivery: forActualDelivery)
          .first;
      state = AsyncValue.data(initial);

      // //print(
      //     '✅ fetchMainOrderStream initial loaded: ${state.value?.length} orders');

      repo
          .fetchMainOrderStream(id: id, forActualDelivery: forActualDelivery)
          .listen(
        (mainOrder) {
          state = AsyncValue.data(mainOrder);
          // //print(
          //     '📡 fetchMainOrderStream updated: ${(state.valueOrNull?.length ?? 0)} orders');
        },
        onError: (err) {
          //print('❌ fetchMainOrderStream error: $err');
        },
      );

      return initial;
    } catch (err) {
      //print('❌ Initial load failed: $err');
      throw err; // This error gets passed to .when(error: ...)
    }
  }
}

@Riverpod(keepAlive: true)
class ProductLinesStream extends _$ProductLinesStream {
  @override
  FutureOr<List<ProductLine>> build(
      {required String id, bool forActualDelivery = false}) async {
    final repo = ref.read(dairyB2bRepositoryProvider);
    try {
      final initial = await repo
          .fetchProductLinesStream(id: id, forActualDelivery: forActualDelivery)
          .first;
      final filtered = initial.whereType<ProductLine>().toList();
      state = AsyncValue.data(filtered);

      // //print(
      //     '✅ ProductLinesStream initial loaded: ${state.value?.length} orders');

      repo
          .fetchProductLinesStream(id: id, forActualDelivery: forActualDelivery)
          .listen(
        (orders) {
          state = AsyncValue.data(orders.whereType<ProductLine>().toList());
          // //print(
          //     '📡 ProductLinesStream updated: ${(state.valueOrNull?.length ?? 0)} orders');
        },
        onError: (err) {
          //print('❌ ProductLinesStream error: $err');
        },
      );

      return filtered;
    } catch (err) {
      //print('❌ Initial load failed: $err');
      throw err; // This error gets passed to .when(error: ...)
    }
  }
}

@Riverpod(keepAlive: true)
class DemandLinesStream extends _$DemandLinesStream {
  @override
  FutureOr<List<DemandLine>> build(
      {required String id, bool forActualDelivery = false}) async {
    final repo = ref.read(dairyB2bRepositoryProvider);
    try {
      final initial = await repo
          .fetchDemandLinesStream(id: id, forActualDelivery: forActualDelivery)
          .first;
      final filtered = initial.whereType<DemandLine>().toList();
      state = AsyncValue.data(filtered);

      // //print(
      //     '✅ DemandLinesStream initial loaded: ${state.value?.length} orders');

      repo
          .fetchDemandLinesStream(id: id, forActualDelivery: forActualDelivery)
          .listen(
        (orders) {
          state = AsyncValue.data(orders.whereType<DemandLine>().toList());
          // //print(
          //     '📡 DemandLinesStream updated: ${(state.valueOrNull?.length ?? 0)} orders');
        },
        onError: (err) {
          //print('❌ DemandLinesStream error: $err');
        },
      );

      return filtered;
    } catch (err) {
      //print('❌ Initial load failed: $err');
      throw err; // This error gets passed to .when(error: ...)
    }
  }
}
