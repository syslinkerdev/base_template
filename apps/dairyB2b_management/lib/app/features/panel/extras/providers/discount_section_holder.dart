import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discount_section_holder.g.dart';
part 'discount_section_holder.freezed.dart';

enum DiscountSectionMode {
  create,
  edit,
  userCreateSec,
  userEditSec,
}

extension DiscountSectionModeApi on DiscountSectionMode {
  String get name => switch (this) {
        DiscountSectionMode.create => 'Create',
        DiscountSectionMode.edit => 'Edit',
        DiscountSectionMode.userCreateSec => 'New User Sec',
        DiscountSectionMode.userEditSec => 'Edit User Sec',
      };

  Color get color => switch (this) {
        DiscountSectionMode.create => Colors.greenAccent.shade700,
        DiscountSectionMode.edit => Colors.amber.shade700,
        DiscountSectionMode.userCreateSec => Colors.blueAccent.shade700,
        DiscountSectionMode.userEditSec => Colors.tealAccent.shade700,
      };
  String get buttonLabel => switch (this) {
        DiscountSectionMode.create => 'Create',
        DiscountSectionMode.edit => 'Update',
        DiscountSectionMode.userCreateSec => 'Create User Section',
        DiscountSectionMode.userEditSec => 'Update User Section',
      };

  IconData get icon => switch (this) {
        DiscountSectionMode.create => Icons.brush,
        DiscountSectionMode.edit => Icons.update,
        DiscountSectionMode.userCreateSec => Icons.library_add,
        DiscountSectionMode.userEditSec => Icons.tune,
      };
}

@riverpod
class DiscountSectionHolder extends _$DiscountSectionHolder {
  @override
  FutureOr<DiscountSectionHolderState> build() {
    //print('build called........DiscountSectionHolder.......');
    // ✅ Prevent wiping out manually set state
    return state.valueOrNull ?? DiscountSectionHolderState.empty();
  }

  Future<void> createDisSection(String disSecName) async {
    // Fetch first — don't set loading yet
    final allSections = await ref.read(discountSectionsStreamXProvider.future);

    final globalSection = allSections.firstWhere(
      (section) => section.id == DiscountSectionHelpers.GlobalDiscountsDocId,
      orElse: () => DiscountSection.empty(),
    );

    final zeroDiscounts = <String, Discount>{};
    for (final entry
        in globalSection.nonDeleteDiscounts.entries) {
      final original = entry.value;
      final zeroed = original.copyWith(
        discount: 0.0,
        maxAllowedDiscount: original.discount,
      );
      zeroDiscounts[entry.key] = zeroed;
    }

    final sortedZeroDiscounts = Map.fromEntries(
      zeroDiscounts.entries.toList()
        ..sort((a, b) => a.value.productKey
            .toLowerCase()
            .compareTo(b.value.productKey.toLowerCase())),
    );

    final newSection = DiscountSection(
      id: disSecName,
      name: disSecName,
      productDiscounts: sortedZeroDiscounts,
      status: DiscountSectionStatus.custom,
    );

    // Only now update state
    state = AsyncValue.data(
      DiscountSectionHolderState.empty().copyWith(disSection: newSection),
    );
  }

  Future<void> editDisSection(DiscountSection disSection) async {
    // Fetch first — don't set loading yet
    final allSections = await ref.read(discountSectionsStreamXProvider.future);

    final globalSection = allSections.firstWhere(
      (section) => section.id == DiscountSectionHelpers.GlobalDiscountsDocId,
      orElse: () => DiscountSection.empty(),
    );

    final updatedDiscounts = <String, Discount>{};

    // Step 1: Keep existing discounts but add maxAllowedDiscount from global
    for (final entry
        in disSection.nonDeleteDiscounts.entries) {
      final entryKey = entry.key;
      final original = entry.value;

      final globalOriginal =
          globalSection.nonDeleteDiscounts[entryKey];
      final withMaxAllowed = original.copyWith(
        maxAllowedDiscount: globalOriginal?.discount ?? 0.0,
      );

      updatedDiscounts[entryKey] = withMaxAllowed;
    }

    // Step 2: Add missing products from global section with zero discount
    for (final entry
        in globalSection.nonDeleteDiscounts.entries) {
      if (!updatedDiscounts.containsKey(entry.key)) {
        final original = entry.value;
        final zeroed = original.copyWith(
          discount: 0.0,
          maxAllowedDiscount: original.discount,
        );
        updatedDiscounts[entry.key] = zeroed;
      }
    }

    // Step 3: Sort by productKey (case-insensitive)
    final sortedDiscounts = Map.fromEntries(
      updatedDiscounts.entries.toList()
        ..sort((a, b) => a.value.productKey
            .toLowerCase()
            .compareTo(b.value.productKey.toLowerCase())),
    );

    final newSection = disSection.copyWith(
      productDiscounts: sortedDiscounts,
    );

    // Step 4: Update state
    state = AsyncValue.data(
      DiscountSectionHolderState.empty()
          .copyWith(disSection: newSection, mode: DiscountSectionMode.edit),
    );
  }

  void updateProductDiscount(Discount updatedDis) {
    final current = state.valueOrNull;
    if (current == null) return;
    final updatedDiscounts = Map<String, Discount>.from(
      current.disSection.productDiscounts,
    );
    // Replace or insert the updated Discount
    updatedDiscounts[updatedDis.id] = updatedDis;
    // Update state so UI rebuilds
    state = AsyncValue.data(
      current.copyWith(
        disSection: current.disSection.copyWith(
          productDiscounts: updatedDiscounts,
        ),
      ),
    );
  }

  void removeProductDiscount(String discountId) {
    final current = state.valueOrNull;
    if (current == null) return;
    final updatedDiscounts = Map<String, Discount>.from(
      current.disSection.productDiscounts,
    );
    // Remove by key if exists
    updatedDiscounts.remove(discountId);
    // Update state so UI rebuilds
    state = AsyncValue.data(
      current.copyWith(
        disSection: current.disSection.copyWith(
          productDiscounts: updatedDiscounts,
        ),
      ),
    );
  }

  void updateSecDisName(String newName) {
    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncValue.data(
      current.copyWith(
        disSection: current.disSection.copyWith(name: newName.trim()),
      ),
    );
  }

  void createDisSectionForUser(UserX user) {
    GlobalCacheService.instance.setClient(user);
    final disSecId =
        '${user.uid.substring(0, 5)}_${user.firstName}_${user.lastName}';
    final disSecName = '${user.firstName} ${user.lastName} Dis Sec';
    final newUserDisSection = DiscountSection(
        id: disSecId,
        name: disSecName,
        productDiscounts: {},
        status: DiscountSectionStatus.custom);
    state = AsyncValue.data(
      DiscountSectionHolderState.empty().copyWith(
          disSection: newUserDisSection,
          mode: DiscountSectionMode.userCreateSec),
    );
  }

  Future<void> editDisSectionForUser(UserX user) async {
    GlobalCacheService.instance.setClient(user);
    final allSections = await ref.read(discountSectionsStreamXProvider.future);
    final globalSection = allSections.firstWhere(
      (section) => section.id == DiscountSectionHelpers.GlobalDiscountsDocId,
      orElse: () => DiscountSection.empty(),
    );
    final userSection = user.disSection ?? DiscountSection.empty();
    final updated = Map<String, Discount>.from(userSection.productDiscounts);
    for (final entry in updated.entries.toList()) {
      final dis = entry.value;
      final globalMax =
          globalSection.nonDeleteDiscounts[dis.id]?.discount ?? dis.discount;

      updated[dis.id] = dis.copyWith(maxAllowedDiscount: globalMax);
    }
    state = AsyncValue.data(
      DiscountSectionHolderState.empty().copyWith(
          disSection: userSection.copyWith(productDiscounts: updated),
          mode: DiscountSectionMode.userEditSec),
    );
  }

  Future<void> updateProductDiscountList(List<Discount> selectedList) async {
    final current = state.valueOrNull;
    if (current == null) return;
    // Fetch global section
    final allSections = await ref.read(discountSectionsStreamXProvider.future);
    final globalSection = allSections.firstWhere(
        (section) => section.id == DiscountSectionHelpers.GlobalDiscountsDocId,
        orElse: () => DiscountSection.empty());
    final updated =
        Map<String, Discount>.from(current.disSection.productDiscounts);
    for (final dis in selectedList) {
      // Always take maxAllowedDiscount from global (default to 0 if missing)
      final globalMax =
          globalSection.nonDeleteDiscounts[dis.id]?.discount ?? dis.discount;
      updated[dis.id] = dis.copyWith(maxAllowedDiscount: globalMax);
    }
    state = AsyncValue.data(current.copyWith(
        disSection: current.disSection.copyWith(productDiscounts: updated)));
  }
}

@freezed
abstract class DiscountSectionHolderState with _$DiscountSectionHolderState {
  const factory DiscountSectionHolderState({
    required DiscountSection disSection,
    required DiscountSectionMode mode,
  }) = _DiscountSectionHolderState;

  factory DiscountSectionHolderState.empty() => DiscountSectionHolderState(
      disSection: DiscountSection.empty(), mode: DiscountSectionMode.create);
}
