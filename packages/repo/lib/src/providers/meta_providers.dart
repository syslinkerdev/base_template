part of 'package:repo/repo.dart';

// fetchProductMakerProvider
@Riverpod(keepAlive: true)
FutureOr<ProductMaker?> fetchProductMaker(Ref ref) {
  return ref.read(dairyB2bRepositoryProvider).fetchProductMaker();
}

// fetchAvatarsListProvider
@riverpod
Future<List<Avatar>> fetchAvatarsList(Ref ref) {
  return ref.read(dairyB2bRepositoryProvider).fetchAvatars();
}

// fetchLogListProvider
@riverpod
Future<List<LogModel>> fetchLogList(Ref ref) {
  return ref.read(dairyB2bRepositoryProvider).fetchLogs();
}

@Riverpod(keepAlive: true)
class OrderRulesStream extends _$OrderRulesStream {
  @override
  FutureOr<OrderRules?> build() async {
    final repo = ref.read(dairyB2bRepositoryProvider);
    final controller = ref.read(orderRulesXProvider.notifier);

    try {
      final initial = await repo.fetchOrderRules().first;

      // 👉 Do the check once for the initial snapshot
      await _maybeReset(initial, controller);

      // Save to state
      state = AsyncValue.data(initial);

      // 👉 Listen for live changes
      repo.fetchOrderRules().listen(
        (rules) async {
          await _maybeReset(rules, controller);
          state = AsyncValue.data(rules);
        },
        onError: (err) {
          //print('❌ OrderRulesStream error: $err');
        },
      );

      return initial;
    } catch (err) {
      //print('❌ Initial load failed: $err');
      throw err;
    }
  }

  /// ✅ If overrideDate is stale, reset it immediately
  Future<void> _maybeReset(
    OrderRules? rules,
    OrderRulesX controller,
  ) async {
    if (rules == null) return;

    final now = DateTime.now();
    final override = rules.overrideDate;

    if (override != null) {
      final sameDay = now.year == override.year &&
          now.month == override.month &&
          now.day == override.day;

      if (!sameDay) {
        //print('🔁 Auto-resetting override because overrideDate is stale');
        await controller.resetToDefault(rules: rules);
      }
    }
  }
}

@riverpod
class OrderRulesX extends _$OrderRulesX {
  @override
  Future<void> build() async {
    return;
  }

  /// ✅ Update *today’s* start and end ONLY (does not change defaults)
  Future<void> updateTodayTimes({
    required DateTime? newStart,
    required DateTime? newEnd,
    required OrderRules rules,
  }) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final repo = ref.read(dairyB2bRepositoryProvider);
        final updated = rules.copyWith(
          orderStart: newStart,
          orderEnd: newEnd,
          overrideDate: DateTime.now(),
        );
        await repo.updateOrderRules(updated);
        //print('OrderRules updated: $updated');
      },
    );
  }

  /// ✅ Update *permanent* default start & end AND today’s values
  Future<void> updatePermanentTimes({
    required DateTime? newStart,
    required DateTime? newEnd,
    required OrderRules rules,
  }) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final repo = ref.read(dairyB2bRepositoryProvider);
        final updated = rules.copyWith(
          orderStart: newStart,
          orderEnd: newEnd,
          defaultOrderStart: newStart,
          defaultOrderEnd: newEnd,
          overrideDate: null,
          lastUpdated: DateTime.now(),
        );
        await repo.updateOrderRules(updated);
        //print('OrderRules updated: $updated');
      },
    );
  }

  /// ✅ Reset today’s times to defaults
  Future<void> resetToDefault({required OrderRules rules}) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final repo = ref.read(dairyB2bRepositoryProvider);
        final updated = rules.copyWith(
          orderStart: rules.defaultOrderStart,
          orderEnd: rules.defaultOrderEnd,
          overrideDate: null,
          lastUpdated: DateTime.now(),
        );
        await repo.updateOrderRules(updated);
        //print('OrderRules updated: $updated');
      },
    );
  }
}
