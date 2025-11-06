import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/filter_discounts_stream.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/mode_show_widget.dart';

class DiscountSectionCard extends StatelessWidget {
  const DiscountSectionCard(
      {super.key,
      required this.disSection,
      this.forDetailsPage = false,
      required this.ref});
  final DiscountSection disSection;
  final bool forDetailsPage;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    final discountsProgress =
        ref.watch(DiscountProgressProvider(disSection.id));
    return ContainerX(
        padding: EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.sizeOfWidth * 0.1,
                  height: context.sizeOfHeight * 0.05,
                  decoration: BoxDecoration(
                      color: appColors.cS(context).surfaceTint,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "S-${disSection.productDiscounts.length}",
                      style: TextStyles.h10Bold(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                gapW8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(disSection.name,
                          style: TextStyles.h9Bold(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start),
                      Text(disSection.id,
                          style: TextStyles.h13Gray(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start),
                    ],
                  ),
                ),
                ModeShowWidget(
                  color: disSection.status.color,
                  label: disSection.status.label,
                  icon: disSection.status.icon,
                  iconSize: 14,
                  borderWidth: 1.4,
                  labelStyle: TextStyles.h15Bold(context),
                ),
              ],
            ),
            if (!forDetailsPage) ...[
              SimpleDivider(),
              // ✅ Items Preview
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item
                        in disSection.nonDeleteDiscounts.values.take(2))
                      Text(
                        "• ${item.productKey.shortKey}",
                        style: TextStyles.h13Bold(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (disSection.nonDeleteDiscounts.values.length > 2)
                      Text(
                        "+ ${disSection.nonDeleteDiscounts.values.length - 2} more…",
                        style: TextStyles.h13(context)?.copyWith(
                          color: appColors.ms.textBlack50(context),
                        ),
                      ),
                  ],
                ),
              ),
              // date and icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: discountsProgress.maybeWhen(
                      orElse: () => Text(
                        'Loading . . .',
                        style: TextStyles.h13Gray(context)
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      data: (sectionProgress) {
                        return Text(
                          'Section Progress $sectionProgress',
                          style: TextStyles.h13Gray(context)
                              ?.copyWith(fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  if (!forDetailsPage)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: context.sizeOfHeight * 0.017,
                      color: appColors.sc.grey500,
                    ),
                ],
              )
            ],
          ],
        ));
  }
}
