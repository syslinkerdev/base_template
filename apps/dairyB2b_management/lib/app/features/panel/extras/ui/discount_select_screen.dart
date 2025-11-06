import 'package:common/common.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_section_holder.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/filter_discounts_stream.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/widgets/discount_card.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/widgets/common_widgets.dart';

class DiscountSelectScreen extends StatelessWidget {
  const DiscountSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldX(
      wantLeading: true,
      appToolbarHeight: -1,
      body: DiscountSelectScreenBody(),
    );
  }

  static Future<void> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DiscountSelectScreenBottomSheetContent(),
    );
  }
}

class _DiscountSelectScreenBottomSheetContent extends StatelessWidget {
  const _DiscountSelectScreenBottomSheetContent();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        const Positioned(
          top: -60,
          child: _CloseButton(),
        ),
        Container(
          width: context.sizeOfWidth,
          height: context.sizeOfHeight * 0.775,
          decoration: BoxDecoration(
            color: appColors.ms.whiteSwNero(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: DiscountSelectScreenBody(),
        ),
      ],
    );
  }
}

class DiscountSelectScreenBody extends HookConsumerWidget {
  const DiscountSelectScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //debugPrint('💥 Rebuilding widget DiscountSelectScreenBody');
    final disSectionListAsync = ref.watch(discountSectionsStreamXProvider);
    final selectedDisSectionId =
        useState<String?>(DiscountSectionHelpers.GlobalDiscountsDocId);
    final filteredProvider = FilteredDiscountsStreamProvider(
        disSectionId: selectedDisSectionId.value,
        discountFillFilter: DiscountFillFilter.filled);

    final filteredDiscounts = ref.watch(filteredProvider);
    final discounts = filteredDiscounts.valueOrNull;
    final selectedDiscountIds = useState<Set<String>>({});

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      titleOfDisSecName(
                          disSectionListAsync, selectedDisSectionId),
                      style: TextStyles.h7Gray(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DisSecProgressWidget(
                      selectedDisSectionId: selectedDisSectionId),
                  DisSectionDropDown(
                    selectedDisSectionId: selectedDisSectionId,
                    onSelected: (id) => selectedDiscountIds.value = {},
                  ),
                ],
              ),
              gapH8,
              if (filteredDiscounts.isLoading)
                const LinearProgressIndicator(minHeight: 2)
              else
                gapH2,
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (filteredDiscounts.hasError) {
                      return ErrorScreen(
                        error: filteredDiscounts.error!,
                        onRetry: () => refresh(ref: ref, pro: filteredProvider),
                      );
                    }
                    if (discounts == null) return _buildShimmerLoading(context);
                    if (discounts.isEmpty) {
                      return _buildEmptyState(
                          context,
                          DiscountFillFilter.filled,
                          selectedDisSectionId.value);
                    }

                    return SingleChildScrollView(
                      child: DynamicList<Discount>(
                        items: discounts,
                        physics: const NeverScrollableScrollPhysics(),
                        onSelect: (discount) async => toggleDiscountSelection(
                            discount.id,
                            selectedDiscountIds: selectedDiscountIds),
                        itemBuilder: (context, discount, _) {
                          final isSelected =
                              selectedDiscountIds.value.contains(discount.id);
                          return DiscountCard(
                            isSelected: isSelected,
                            discount: discount,
                            disSectionId: selectedDisSectionId.value ??
                                DiscountSectionHelpers.GlobalDiscountsDocId,
                            forMultiSelection: true,
                            onToggle: () => toggleDiscountSelection(discount.id,
                                selectedDiscountIds: selectedDiscountIds),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 2),
                  margin: EdgeInsetsGeometry.zero,
                  color: ColorX.instance.shad.e30(context),
                  width: context.sizeOfWidth,
                  child: Text(
                      'Selected Items: ${selectedDiscountIds.value.length}',
                      style: TextStyles.h10Bold(context))),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonX(
                        label: selectedDiscountIds.value.length ==
                                (discounts?.length ?? 0)
                            ? 'Clear All'
                            : 'Select All',
                        icon: selectedDiscountIds.value.length ==
                                (discounts?.length ?? 0)
                            ? Icons.clear_all
                            : Icons.done_all,
                        iconFirst: true,
                        onPressed: () async {
                          if (selectedDiscountIds.value.length ==
                              (discounts?.length ?? 0)) {
                            // clear all
                            selectedDiscountIds.value = {};
                          } else {
                            // select all
                            selectedDiscountIds.value =
                                discounts?.map((d) => d.id).toSet() ?? {};
                          }
                        },
                      ),
                    ),
                    gapW8,
                    Expanded(
                      child: ButtonX(
                          label: 'Add Selected',
                          icon: Icons.add_box,
                          iconFirst: true,
                          onPressed: () async {
                            final selectedDiscounts = discounts
                                ?.where((d) =>
                                    selectedDiscountIds.value.contains(d.id))
                                .toList();
                            if (selectedDiscounts == null ||
                                selectedDiscounts.isEmpty) {
                              //debugPrint("⚠️ No discounts selected");
                              return;
                            }
                            await ref
                                .watch(discountSectionHolderProvider.notifier)
                                .updateProductDiscountList(selectedDiscounts)
                                .then((_) => context.pop());
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void toggleDiscountSelection(
    String id, {
    required ValueNotifier<Set<String>> selectedDiscountIds,
  }) {
    final newSet = {...selectedDiscountIds.value};

    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }

    selectedDiscountIds.value = newSet;
  }

  Widget _buildEmptyState(BuildContext context, DiscountFillFilter? fillFilter,
      String? disSectionId) {
    final message = _buildNoProductsMessage(fillFilter, disSectionId);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined,
              size: context.sizeOfHeight * 0.12, color: appColors.sc.grey650),
          gapH20,
          Text(message,
              textAlign: TextAlign.center, style: TextStyles.h8Gray(context)),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliers = [0.08, 0.08, 0.08, 0.08];
    return SingleChildScrollView(
      child: SpacedColumn(
        children: heightMultipliers
            .map((h) => ShimmerX(
                  width: context.sizeOfWidth,
                  height: context.sizeOfHeight * h,
                ))
            .toList(),
      ),
    );
  }

  String _buildNoProductsMessage(
      DiscountFillFilter? fillFilter, String? disSectionId) {
    final buffer = StringBuffer(
        'No ${fillFilter?.label} ${disSectionId.toTitleCase} found');

    return buffer.toString();
  }

  static Future<void> refresh({
    required WidgetRef ref,
    required FilteredDiscountsStreamProvider pro,
  }) async {
    await Future.wait([ref.refresh(pro.future)]);
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        iconColor: WidgetStatePropertyAll(appColors.ms.whiteSwNero(context)),
        backgroundColor: WidgetStatePropertyAll(
          appColors.ms.neroSwWhite(context).withValues(alpha: 0.3),
        ),
      ),
      onPressed: () => context.pop(),
      icon: const Icon(Icons.close_rounded, weight: 10),
    );
  }
}
