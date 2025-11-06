import 'dart:math';

import 'package:core/core.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:repo/repo.dart';
import 'package:models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_sections_cud.dart';

part 'discount_section_builder.g.dart';

@riverpod
class DiscountSectionBuilder extends _$DiscountSectionBuilder {
  @override
  FutureOr<void> build() {}

  // ----------------------
  // 📌 Helpers
  // ----------------------

  Future<T?> runWithGuard<T>({
    required String errorTitle,
    required Future<T> Function() action,
  }) async {
    try {
      state = const AsyncValue.loading();
      final result = await action();
      state = const AsyncValue.data(null);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(
        convertToAppException(title: errorTitle, exception: e.toString()),
        st,
      );
      return null;
    }
  }

  Future<(UserX user, String userName, DateTime now)> _getUserAndTime() async {
    final user = await getUserX();
    final now = DFU.now();
    final userName = "${user.firstName} ${user.lastName}";
    return (user, userName, now);
  }

  Map<String, Discount> _filterDiscounts(Map<String, Discount> discounts) {
    return Map.fromEntries(
      discounts.entries.where((e) => e.value.discount != 0.0),
    );
  }

  Map<String, Discount> _scaleDiscounts(
      Map<String, Discount> discounts, double percentage) {
    return discounts.map((key, original) {
      final scaledValue = double.parse(
        ((original.discount * percentage) / 100).toStringAsFixed(2),
      );
      return MapEntry(key, original.copyWith(discount: scaledValue));
    });
  }

  double _extractPercentageFromId(String id) {
    final match = RegExp(r'(\d+)_pct').firstMatch(id);
    return match != null ? double.tryParse(match.group(1)!) ?? 0 : 0;
  }

  Future<List<DiscountSection>> _getAllSections() async {
    return ref.watch(discountSectionsStreamXProvider.future);
  }

  // ----------------------
  // 📌 Generators
  // ----------------------

  Future<String?> generateDisSectionAndPublish(int percentage) {
    return runWithGuard(
      errorTitle: 'Section Generate Failed',
      action: () async {
        final (_, userName, now) = await _getUserAndTime();

        final allSections = await _getAllSections();
        final globalSection = allSections.firstWhere(
          (s) => s.id == DiscountSectionHelpers.GlobalDiscountsDocId,
          orElse: () => DiscountSection.empty(),
        );

        final newId = '${globalSection.id}_${percentage}_pct';
        if (allSections.any((s) => s.id == newId)) {
          throw "This Discount section already exists!";
        }

        final scaledDiscounts = _scaleDiscounts(
            globalSection.nonDeleteDiscounts, percentage.toDouble());

        final newSection = DiscountSection(
          id: newId,
          name: newId.toTitleCase,
          productDiscounts: scaledDiscounts,
          status: DiscountSectionStatus.generated,
          meta: MetaDataX(createdAt: now, createdBy: userName),
        );

        await ref
            .read(discountSectionsCudProvider(
                    docPath: DbPathManager.discountSection(sectionId: newId))
                .notifier)
            .upsertDiscountSection(newSection);

        return newId;
      },
    );
  }

  Future<String?> updateGenerateDisSecAndPub(DiscountSection disSection) {
    return runWithGuard(
      errorTitle: 'Section Generate Failed',
      action: () async {
        final (_, userName, now) = await _getUserAndTime();

        final allSections = await _getAllSections();
        final globalSection = allSections.firstWhere(
          (s) => s.id == DiscountSectionHelpers.GlobalDiscountsDocId,
          orElse: () => DiscountSection.empty(),
        );

        final percentage = _extractPercentageFromId(disSection.id);
        final scaledDiscounts =
            _scaleDiscounts(globalSection.nonDeleteDiscounts, percentage);

        final updatedSection = disSection.copyWith(
          productDiscounts: scaledDiscounts,
          meta: disSection.meta?.copyWith(updatedBy: userName, updatedAt: now),
        );

        await ref
            .read(discountSectionsCudProvider(
                    docPath:
                        DbPathManager.discountSection(sectionId: disSection.id))
                .notifier)
            .upsertDiscountSection(updatedSection);

        return disSection.id;
      },
    );
  }

  Future<String?> createDisSectionPublish(DiscountSection disSection) {
    return runWithGuard(
      errorTitle: 'Section Create Failed',
      action: () async {
        final (_, userName, now) = await _getUserAndTime();

        final baseId = disSection.name.snakeCase;
        final randomSuffix =
            List.generate(5, (_) => Random().nextInt(10)).join();
        final newId = '${baseId}_$randomSuffix';

        final allSections = await _getAllSections();
        if (allSections.any((s) => s.id == newId)) {
          throw "This Discount section already exists!";
        }

        final filteredDiscounts =
            _filterDiscounts(disSection.nonDeleteDiscounts);

        final newSection = disSection.copyWith(
          id: newId,
          productDiscounts: filteredDiscounts,
          meta: MetaDataX(createdAt: now, createdBy: userName),
        );

        await ref
            .read(discountSectionsCudProvider(
                    docPath: DbPathManager.discountSection(sectionId: newId))
                .notifier)
            .upsertDiscountSection(newSection);

        return newId;
      },
    );
  }

  Future<String?> updateDisSectionPublish(DiscountSection disSection) {
    return runWithGuard(
      errorTitle: 'Section Update Failed',
      action: () async {
        final (_, userName, now) = await _getUserAndTime();
        final filteredDiscounts =
            _filterDiscounts(disSection.nonDeleteDiscounts);
        final updatedSection = disSection.copyWith(
          productDiscounts: filteredDiscounts,
          meta: disSection.meta?.copyWith(updatedBy: userName, updatedAt: now),
        );
        await ref
            .read(discountSectionsCudProvider(
                    docPath:
                        DbPathManager.discountSection(sectionId: disSection.id))
                .notifier)
            .upsertDiscountSection(updatedSection);
        return disSection.id;
      },
    );
  }

  Future<void> deleteDisSection(String disSectionId) {
    return runWithGuard(
      errorTitle: 'Section Delete Failed',
      action: () async {
        await ref
            .read(discountSectionsCudProvider(
                    docPath:
                        DbPathManager.discountSection(sectionId: disSectionId))
                .notifier)
            .deleteDiscountSection(disSectionId);
      },
    );
  }

  Future<String?> createDisSectionForUserPublish(DiscountSection disSection) {
    return runWithGuard(
      errorTitle: 'User Section Discount Publish Failed',
      action: () async {
        final client = await GlobalCacheService.instance.getClient();
        if (client?.uid.doesNotHaveValue ?? true) {
          throw Exception("No client found in cache");
        }

        final (_, userName, now) = await _getUserAndTime();
        final filteredDiscounts =
            _filterDiscounts(disSection.nonDeleteDiscounts);

        final newSection = disSection.copyWith(
          productDiscounts: filteredDiscounts,
          meta: MetaDataX(createdAt: now, createdBy: userName),
        );

        await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.users(),
          documentId: client!.uid,
          data: {DbStandardFields.disSection: newSection.toDocument()},
        );
        return client.uid;
      },
    );
  }

  Future<String?> updateDisSectionForUserPublish(DiscountSection disSection) {
    return runWithGuard(
      errorTitle: 'User Section Discount Update Failed',
      action: () async {
        final client = await GlobalCacheService.instance.getClient();
        if (client?.uid.doesNotHaveValue ?? true) {
          throw Exception("No client found in cache");
        }
        final (_, userName, now) = await _getUserAndTime();
        final filteredDiscounts =
            _filterDiscounts(disSection.nonDeleteDiscounts);

        final updateSection = disSection.copyWith(
          productDiscounts: filteredDiscounts,
          meta: disSection.meta?.copyWith(updatedBy: userName, updatedAt: now),
        );

        await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.users(),
          documentId: client!.uid,
          data: {DbStandardFields.disSection: updateSection.toDocument()},
        );
        return client.uid;
      },
    );
  }

  // ----------------------
  // 📌 User Fetch
  // ----------------------
  Future<UserX> getUserX() async {
    final uId = ref.read(appStateXProvider).uId;

    // Try from cache
    final cached = GlobalCacheService.instance.getUser();
    if (cached != null) return cached;

    // Otherwise fetch from Firestore
    final userAsync = await ref.read(fetchUserProvider(documentId: uId).future);
    final user = await userAsync;
    if (user == null) throw 'User not found in Firestore';

    GlobalCacheService.instance.setUser(user);
    return user;
  }
}
