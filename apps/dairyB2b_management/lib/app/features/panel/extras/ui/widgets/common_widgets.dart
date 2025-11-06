import 'package:dairyB2b_management/app/features/panel/extras/providers/filter_discounts_stream.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/more_options_button.dart';

String titleOfDisSecName(AsyncValue<List<DiscountSection>> disSectionListAsync,
    ValueNotifier<String?> selectedDisSectionId) {
  return disSectionListAsync.maybeWhen(
    orElse: () => 'Section',
    data: (disSections) {
      final selected = disSections.isEmpty
          ? null
          : disSections.firstWhere(
              (e) => e.id == selectedDisSectionId.value,
              orElse: () => DiscountSection.empty(),
            );
      if (selected?.isEmpty ?? false) {
        return 'Section';
      } else {
        return selected?.name ?? 'Section';
      }
    },
  );
}

class DisSectionDropDown extends HookConsumerWidget {
  const DisSectionDropDown({
    super.key,
    required this.selectedDisSectionId,
    this.onSelected,
  });
  final ValueNotifier<String?> selectedDisSectionId;
  final void Function(String id)? onSelected;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disSectionListAsync = ref.watch(discountSectionsStreamXProvider);

    return disSectionListAsync.maybeWhen(
      orElse: () => SizedBox.shrink(),
      data: (disSections) {
        final selected = disSections.isEmpty
            ? null
            : disSections.firstWhere(
                (e) => e.id == selectedDisSectionId.value,
                orElse: () => DiscountSection.empty(),
              );
        if (selected!.isEmpty) {
          return SizedBox.shrink();
        } else {
          return MoreOptionsButton<DiscountSection>(
            tooltip: 'Select Discount Section',
            offsetY: 35,
            items: disSections,
            icon: Icon(Icons.arrow_drop_down,
                size: 36, color: appColors.cS(context).surfaceTint),
            onSelected: (disSection) {
              selectedDisSectionId.value = disSection.id;
              if (onSelected != null) {
                onSelected!(disSection.id);
              }
            },
            labelBuilder: (p0) => p0.name,
          );
        }
      },
    );
  }
}

class DisSecProgressWidget extends ConsumerWidget {
  const DisSecProgressWidget({super.key, required this.selectedDisSectionId});
  final ValueNotifier<String?> selectedDisSectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discountsProgress =
        ref.watch(DiscountProgressProvider(selectedDisSectionId.value));

    return discountsProgress.maybeWhen(
      orElse: () {
        return SizedBox.shrink();
      },
      data: (progress) {
        return Tooltip(
          message: selectedDisSectionId.value ==
                  DiscountSectionHelpers.GlobalDiscountsDocId
              ? 'Products With Discounts'
              : 'Global Discounts Section With Discounts',
          child: Text(
            progress,
            style: TextStyles.h8Gray(context)
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
