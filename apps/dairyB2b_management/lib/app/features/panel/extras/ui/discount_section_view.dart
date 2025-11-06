import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/common/widgets/discount_show.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/widgets/discount_card.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/widgets/common_widgets.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/widgets/discount_section_card.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/filter_discounts_stream.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_section_holder.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_section_builder.dart';

class DiscountSectionViewArgs {
  final String? initialDisSectionId;
  final DiscountFillFilter? initialDiscountFillFilter;

  DiscountSectionViewArgs(
      {this.initialDisSectionId, this.initialDiscountFillFilter});
}

class DiscountSectionView extends HookConsumerWidget {
  final String? initialDisSectionId;
  final DiscountFillFilter? initialDiscountFillFilter;

  const DiscountSectionView(
      {super.key, this.initialDisSectionId, this.initialDiscountFillFilter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disSectionListAsync = ref.watch(discountSectionsStreamXProvider);
    final selectedDisSectionId = useState<String?>(
        initialDisSectionId ?? DiscountSectionHelpers.GlobalDiscountsDocId);
    final selectedDiscountFillFilter = useState<DiscountFillFilter?>(
        initialDiscountFillFilter ?? DiscountFillFilter.filled);

    // Sync state with incoming initial props
    useEffect(() {
      if (initialDisSectionId != null &&
          initialDisSectionId != selectedDisSectionId.value) {
        selectedDisSectionId.value = initialDisSectionId;
      }
      if (initialDiscountFillFilter != null &&
          initialDiscountFillFilter != selectedDiscountFillFilter.value) {
        selectedDiscountFillFilter.value = initialDiscountFillFilter;
      }
      return null;
    }, [initialDisSectionId, initialDiscountFillFilter]);

    // Setup filtered stream
    final filteredProvider = FilteredDiscountsStreamProvider(
        disSectionId: selectedDisSectionId.value,
        discountFillFilter: selectedDiscountFillFilter.value);

    final filteredDiscounts = ref.watch(filteredProvider);
    final discounts = filteredDiscounts.valueOrNull;
    final discountsCtr = DynamicListController<Discount>();

    return ScaffoldX(
      wantLeading: true,
      title: titleOfDisSecName(disSectionListAsync, selectedDisSectionId),
      appBarActions: [
        DisSectionDropDown(
          selectedDisSectionId: selectedDisSectionId,
          onSelected: (id) {
            if (id == DiscountSectionHelpers.GlobalDiscountsDocId) {
              selectedDiscountFillFilter.value = DiscountFillFilter.filled;
            }
          },
        ),
        gapW6
      ],
      body: RefreshIndicator(
        onRefresh: () => refresh(ref: ref, pro: filteredProvider),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              disSectionListAsync.maybeWhen(
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
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (selectedDisSectionId.value !=
                                DiscountSectionHelpers
                                    .GlobalDiscountsDocId) ...[
                              PopUpDropdown<DiscountFillFilter>(
                                hintText: 'Filter Discounts',
                                tooltip:
                                    'Filter based on whether discounts are filled or not',
                                items: DiscountFillFilter.values,
                                value: selectedDiscountFillFilter.value,
                                itemLabel: (f) => f.label,
                                onSelected: (newDiscountFillFilter) =>
                                    selectedDiscountFillFilter.value =
                                        newDiscountFillFilter,
                              ),
                            ] else ...[
                              gapW2
                            ],
                            DisSecProgressWidget(
                                selectedDisSectionId: selectedDisSectionId)
                          ],
                        ),
                        DiscountSectionCard(
                            ref: ref,
                            disSection: selected,
                            forDetailsPage: true),
                      ],
                    );
                  }
                },
              ),
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
                          selectedDiscountFillFilter.value,
                          selectedDisSectionId.value);
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DynamicList<Discount>(
                        items: discounts,
                        controller: discountsCtr,
                        physics: const NeverScrollableScrollPhysics(),
                        onSelect: (discount) async =>
                            await DiscountShow.dialog(context, discount)
                                .then((value) => discountsCtr.clear()),
                        itemBuilder: (context, item, isSelected) =>
                            DiscountCard(
                                isSelected: isSelected,
                                discount: item,
                                disSectionId: selectedDisSectionId.value ??
                                    DiscountSectionHelpers
                                        .GlobalDiscountsDocId),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: disSectionListAsync.maybeWhen(
        orElse: () => null,
        data: (disSections) {
          final selected = disSections.isEmpty
              ? null
              : disSections.firstWhere(
                  (e) => e.id == selectedDisSectionId.value,
                  orElse: () => DiscountSection.empty(),
                );
          if (selected == null) {
            return null;
          } else if (selected.id ==
              DiscountSectionHelpers.GlobalDiscountsDocId) {
            return null;
          } else {
            return Row(
              children: [
                Flexible(
                  child: ButtonX.outlineButton(
                    context: context,
                    label: 'Delete',
                    icon: Icons.delete_outline,
                    onPressed: () async {
                      final shouldDelete =
                          await DialogsX.askForConfirmation<bool>(
                        context,
                        content:
                            'Are you sure you want to delete this Discounts Section?',
                        cancelBtnText: 'Cancel',
                        confirmBtnText: 'Delete',
                      );
                      if (shouldDelete == true) {
                        var curr = RouteX.getCurrentRoute(context);
                        print('curr ${curr}');

                        ref
                            .read(discountSectionBuilderProvider.notifier)
                            .deleteDisSection(selected.id)
                            .then(
                          (_) {
                            if (context.mounted) {
                              showMessageSnackbar(
                                  context: context,
                                  message:
                                      'Discounts Section Deleted Successfully',
                                  type: SnackBarType.success,
                                  maxLines: 2);
                              var curr = RouteX.getCurrentRoute(context);
                              print('curr ${curr}');
                              context.close();
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
                gapW4,
                Flexible(
                  child: ButtonX.primaryButton(
                    context: context,
                    label: selected.status == DiscountSectionStatus.generated
                        ? 'Update'
                        : 'Edit',
                    icon: selected.status == DiscountSectionStatus.generated
                        ? Icons.update
                        : Icons.edit_square,
                    loading: selected.status == DiscountSectionStatus.generated
                        ? ref.watch(discountSectionBuilderProvider).isLoading
                        : ref.watch(discountSectionHolderProvider).isLoading,
                    onPressed: () async {
                      if (selected.status == DiscountSectionStatus.generated) {
                        showMessageSnackbar(
                            context: context,
                            message: 'Generating Discounts Section...',
                            type: SnackBarType.loading,
                            duration: Duration(minutes: 1));
                        await ref
                            .read(discountSectionBuilderProvider.notifier)
                            .updateGenerateDisSecAndPub(selected)
                            .then(
                          (disSecId) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            if (disSecId != null) {
                              showMessageSnackbar(
                                  context: context,
                                  message:
                                      'Successfully Generated Discounts Section',
                                  type: SnackBarType.success,
                                  maxLines: 2);
                            }
                          },
                        );
                      } else {
                        await ref
                            .read(discountSectionHolderProvider.notifier)
                            .editDisSection(selected);
                        AppRoute.discountSectionBuilderPage.go(context);
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
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
    final heightMultipliers = [0.1, 0.1, 0.1, 0.1];
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
