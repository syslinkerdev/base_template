import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/panel/common/widgets/slider_holder.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_section_builder.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_section_holder.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/discount_section_view.dart';
import 'package:dairyB2b_management/app/features/panel/extras/ui/discount_select_screen.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/mode_show_widget.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';

class DiscountSectionBuilderPage extends HookConsumerWidget {
  const DiscountSectionBuilderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionHolder = ref.watch(discountSectionHolderProvider);
    final nameCtrl = useTextEditingController();

    return ScaffoldX(
      wantLeading: true,
      title: 'Section Builder',
      appBarActions: [
        sectionHolder.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (secBuilder) => ModeShowWidget(
            label: secBuilder.mode.name,
            color: secBuilder.mode.color,
          ),
        ),
        gapW16,
      ],
      body: sectionHolder.when(
        data: (disSectionData) {
          final secDiscounts =
              disSectionData.disSection.nonDeleteDiscounts.values.toList();
          final secName = disSectionData.disSection.name;

          return SpacedColumn(
            defaultHeight: 0,
            crossAxisAlignment: CrossAxisAlignment.start,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              if ([DiscountSectionMode.create, DiscountSectionMode.edit]
                  .contains(disSectionData.mode)) ...[
                AppTextField(
                  title: 'Name',
                  isMandatory: true,
                  controller: nameCtrl,
                  initialValue: secName,
                  hintText: 'Discount Section Name',
                  textInputAction: TextInputAction.next,
                  onChanged: (newName) => ref
                      .read(discountSectionHolderProvider.notifier)
                      .updateSecDisName(newName.toTitleCase),
                ),
              ] else if ([
                DiscountSectionMode.userCreateSec,
                DiscountSectionMode.userEditSec
              ].contains(disSectionData.mode)) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add discounts for this user',
                      style: TextStyles.h8Gray(context),
                    ),
                    ButtonX(
                      label: 'Add',
                      icon: Icons.add_box,
                      scale: false,
                      iconFirst: true,
                      noAsyncLoading: true,
                      onPressed: () =>
                          DiscountSelectScreen.bottomSheet(context),
                    ),
                  ],
                ),
              ],
              Expanded(
                child: secDiscounts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_offer_outlined,
                              size: context.sizeOfHeight * 0.12,
                              color: appColors.sc.grey650,
                            ),
                            gapH20,
                            Text(
                              'No discounts added yet',
                              textAlign: TextAlign.center,
                              style: TextStyles.h8Gray(context),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            HeadingLineFade(
                                label: 'Discounts(${secDiscounts.length})'),
                            for (final secDis in secDiscounts)
                              ContainerX(
                                padding: EdgeInsetsGeometry.symmetric(
                                    vertical: 4, horizontal: 8),
                                margin: EdgeInsetsGeometry.only(bottom: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(secDis.productKey,
                                            style: TextStyles.h8Bold(context)),
                                        InkWell(
                                          onTap: () => ref
                                              .read(
                                                  discountSectionHolderProvider
                                                      .notifier)
                                              .removeProductDiscount(secDis.id),
                                          child: Icon(Icons.close_rounded,
                                              color: appColors.ms
                                                  .textBlack50(context)),
                                        )
                                      ],
                                    ),
                                    Text(
                                      'Max allowed: ${secDis.maxAllowedDiscount.toStringAsFixed(1)} | Current: ${secDis.discount.toStringAsFixed(1)}',
                                      style: TextStyles.h13Gray(context),
                                    ),
                                    SliderHolder(
                                      leading: Text(
                                        '\u{20B9}',
                                        textAlign: TextAlign.end,
                                        style: TextStyles.h9Gray(context)
                                            ?.copyWith(fontFamily: 'Roboto'),
                                      ),
                                      slider: Slider(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14),
                                        value: secDis.discount,
                                        min: 0,
                                        max: secDis.maxAllowedDiscount > 0
                                            ? secDis.maxAllowedDiscount
                                            : secDis.discount,
                                        divisions: (() {
                                          final max =
                                              secDis.maxAllowedDiscount > 0
                                                  ? secDis.maxAllowedDiscount
                                                  : secDis.discount;
                                          final divs = (max / 0.5).round();
                                          return divs > 0
                                              ? divs
                                              : null; // ✅ Safe
                                        })(),
                                        label:
                                            secDis.discount.toStringAsFixed(1),
                                        onChanged: (newValue) {
                                          double step = 0.5;
                                          double roundedValue =
                                              (newValue / step).round() * step;

                                          final updatedDis = secDis.copyWith(
                                              discount: roundedValue);
                                          ref
                                              .read(
                                                  discountSectionHolderProvider
                                                      .notifier)
                                              .updateProductDiscount(
                                                  updatedDis);

                                          if (roundedValue >=
                                              secDis.maxAllowedDiscount) {
                                            showMessageSnackbar(
                                              context: context,
                                              message:
                                                  'Max allowed discount reached for ${secDis.productKey}',
                                              maxLines: 2,
                                            );
                                          }
                                        },
                                      ),
                                      trailing: Text(
                                        secDis.discount.toStringAsFixed(1),
                                        textAlign: TextAlign.center,
                                        style: TextStyles.h9(context),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ManagementShortSlogan()
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
        error: (e, _) => ErrorScreen(error: e, onRetry: () {}),
        loading: () => const LoadingScreen(),
      ),
      bottomNavigationBar: sectionHolder.maybeWhen(
        orElse: () => null,
        data: (secBuilder) => ButtonX.primaryButton(
            context: context,
            label: secBuilder.mode.buttonLabel,
            icon: secBuilder.mode.icon,
            onPressed: () async {
              final mode = secBuilder.mode;
              switch (mode) {
                case DiscountSectionMode.create:
                  await runAction(
                    context,
                    loadingMsg: 'Creating Discounts Section...',
                    action: () => ref
                        .watch(discountSectionBuilderProvider.notifier)
                        .createDisSectionPublish(secBuilder.disSection),
                    reDirect: (disSecId) async =>
                        navToDisSecView(context, disSecId),
                    successMsg: 'Successfully Created Discounts Section',
                  );
                  break;

                case DiscountSectionMode.edit:
                  await runAction(
                    context,
                    loadingMsg: 'Updating Discounts Section...',
                    action: () => ref
                        .watch(discountSectionBuilderProvider.notifier)
                        .updateDisSectionPublish(secBuilder.disSection),
                    reDirect: (disSecId) async =>
                        navToDisSecView(context, disSecId),
                    successMsg: 'Successfully Updated Discounts Section',
                  );
                  break;

                case DiscountSectionMode.userCreateSec:
                  await runAction(
                    context,
                    loadingMsg: 'Creating User Discount Section...',
                    action: () async => ref
                        .watch(discountSectionBuilderProvider.notifier)
                        .createDisSectionForUserPublish(secBuilder.disSection),
                    reDirect: (clientUid) async =>
                        AppRoute.userDetailsView.go(context, extra: clientUid),
                    successMsg: 'Successfully Created User Discount Section',
                  );
                  break;

                case DiscountSectionMode.userEditSec:
                  await runAction(
                    context,
                    loadingMsg: 'Updating User Discount Section...',
                    action: () async {
                      //print('Updating User Discount Section... ttt');
                      return ref
                          .watch(discountSectionBuilderProvider.notifier)
                          .updateDisSectionForUserPublish(
                              secBuilder.disSection);
                    },
                    reDirect: (clientUid) async =>
                        AppRoute.userDetailsView.go(context, extra: clientUid),
                    successMsg: 'Successfully Updated User Discount Section',
                  );
                  break;
              }
            }),
      ),
    );
  }

  Future<void> runAction(
    BuildContext context, {
    required String loadingMsg,
    required Future<String?> Function() action,
    required Future<void> Function(String disSecId) reDirect,
    required String successMsg,
  }) async {
    showMessageSnackbar(
      context: context,
      message: loadingMsg,
      type: SnackBarType.loading,
      duration: const Duration(minutes: 1),
    );

    final disSecId = await action();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (disSecId != null) {
      reDirect(disSecId);
      showMessageSnackbar(
        context: context,
        message: successMsg,
        type: SnackBarType.success,
        maxLines: 2,
      );
    }
  }

  void navToDisSecView(BuildContext context, String disSecId) {
    AppRoute.discountSectionView.go(
      context,
      extra: DiscountSectionViewArgs(initialDisSectionId: disSecId),
    );
  }
}
