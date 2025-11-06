import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/report_actions.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/who_ordered_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/products_ordered_section.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';

class WhoOrderedSection extends HookConsumerWidget {
  final List<DemandLine> demandLines;
  final CompanyEntry companyEntry;

  const WhoOrderedSection(
      {super.key, required this.demandLines, required this.companyEntry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toShow = useState<bool>(false);
    final reportActions = ref.read(reportActionsProvider.notifier);

    return ContainerX(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Who Ordered',
                style: TextStyles.h8Bold(context),
              ),
              LinesCount(
                productLinesCount: demandLines.length,
                icon: Icons.group,
              ),
            ],
          ),
          if (demandLines.isEmpty) ...[
            Center(
              child: Text(
                'No demand lines available!',
                style: TextStyles.h8Gray(context),
              ),
            ),
          ] else ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 160),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SizeTransition(sizeFactor: animation, child: child);
                  },
                  child: toShow.value
                      ? SizedBox(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      DashDivider(),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: demandLines.length > 3
                                      ? 3
                                      : demandLines.length,
                                  itemBuilder: (context, index) {
                                    final demandLine = demandLines[index];
                                    return DemandLinesCard(
                                        demandLine: demandLine);
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : DemandLinesCard(demandLine: demandLines.first),
                ),
                SimpleDivider(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Wrap(
                    spacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ActionBtn(
                        onPressed: () => toShow.value = !toShow.value,
                        label: toShow.value ? 'Less' : 'More',
                        icon: toShow.value
                            ? Icons.arrow_circle_up
                            : Icons.arrow_circle_down,
                      ),
                      ActionBtn(
                        label: 'PDF',
                        icon: Icons.picture_as_pdf,
                        onPressed: () => reportActions.generateCompanyDailyPdf(
                            demandLines, companyEntry),
                      ),
                      ActionBtn(
                        label: 'XLSX',
                        icon: Icons.table_chart,
                        onPressed: () =>
                            reportActions.generateCompanyDailySheet(
                                demandLines, companyEntry),
                      ),
                      if (toShow.value)
                        InkWell(
                          onTap: () => AppRoute.whoOrdered.push(context,
                              extra: WhoOrderedScreenArgs(
                                  demandLines: demandLines,
                                  companyEntry: companyEntry)),
                          child: Icon(Icons.open_in_new,
                              size: 28, color: context.colorScheme.primary),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class DemandLinesCard extends StatelessWidget {
  const DemandLinesCard({
    super.key,
    required this.demandLine,
    this.compactMode = false,
  });

  final DemandLine demandLine;
  final bool compactMode;

  @override
  Widget build(BuildContext context) {
    var compactTextStyle =
        compactMode ? TextStyles.h9(context) : TextStyles.h13(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: InkWell(
        onTap: () => DialogsX.showCustomDialog(context,
            content: ItemsContent(demandLine: demandLine)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(demandLine.clientName,
                    style: compactTextStyle?.copyWith(
                        color: context.colorScheme.primary)),
                Row(
                  children: [
                    Icon(Icons.shopping_bag_outlined,
                        size: compactTextStyle?.fontSize),
                    Text("${demandLine.products.length}",
                        style: compactTextStyle),
                  ],
                ),
              ],
            ),
            if (!compactMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    demandLine.shopName,
                    style: TextStyles.h13Gray(context),
                  ),
                  PriceTag(
                      price: demandLine.clientTotal,
                      style: TextStyles.h13Bold(context)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ItemsContent extends HookConsumerWidget {
  const ItemsContent({super.key, required this.demandLine});
  final DemandLine demandLine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compactMode = useState(false);

    return SpacedColumn(
      children: [
        ColorBgIconHeader(
          label: 'Details',
          icon: Icons.dataset,
          color: Colors.lightGreen,
          trailing: Row(
            children: [
              InkWell(
                onTap: () => compactMode.value = !compactMode.value,
                child: Tooltip(
                  message: compactMode.value
                      ? "Show full details"
                      : "Show compact view",
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: Icon(
                      compactMode.value ? Icons.view_list : Icons.view_agenda,
                      key: ValueKey(compactMode.value),
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              gapW4,
              InkWell(
                onTap: () => context.pop(),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      appColors.ms.whiteSwNero(context).withValues(alpha: 0.7),
                  child: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: appColors.ms.neroSwWhite(context),
                  ),
                ),
              ),
            ],
          ),
        ),
        HeadingLineFade(
          label: 'Address',
          style: TextStyles.h12(context),
          width: 1.5,
          gap: gapW2,
          verticalPadding: 2,
        ),
        InkWell(
          onTap: () {
            Clipboard.setData(
                ClipboardData(text: demandLine.shopAddress.fullAddress));
            if (context.mounted) {
              showMessageSnackbar(
                context: context,
                message: 'Full address copied to clipboard',
                maxLines: 2,
              );
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  demandLine.shopAddress.fullAddress,
                  style: TextStyles.h12(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              gapW8,
              Icon(Icons.copy, size: 18)
            ],
          ),
        ),
        HeadingLineFade(
          label: 'Items(${demandLine.products.length})',
          style: TextStyles.h12(context),
          width: 1.5,
          gap: gapW2,
          verticalPadding: 2,
        ),
        SizedBox(
          height: 160,
          width: context.sizeOfWidth,
          child: Scrollbar(
            thumbVisibility: true,
            radius: Radius.circular(50),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ListView.separated(
                separatorBuilder: (context, index) => DashDivider(),
                shrinkWrap: true,
                itemCount: demandLine.products.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final item = demandLine.products[index];
                  final discountTotal = item.quantity * item.discount;
                  final netTotal = item.subtotal - discountTotal;
                  return DemandLineItemCard(
                      item: item,
                      netTotal: netTotal,
                      compactMode: compactMode.value);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DemandLineItemCard extends StatelessWidget {
  const DemandLineItemCard({
    super.key,
    required this.item,
    required this.netTotal,
    this.compactMode = false,
  });

  final DemandLineItem item;
  final double netTotal;
  final bool compactMode;

  @override
  Widget build(BuildContext context) {
    return compactMode ? compact(context) : nonCompact(context);
  }

  Widget compact(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${item.productKey.shortKey} (${item.unitDetails.displayLabel})',
          style: TextStyles.h11(context)
              ?.copyWith(color: context.colorScheme.primary),
        ),
        Text(
            '${item.unitDetails.formatTotalWithCount(item.quantity.toDouble(), countLabel: item.productType.shortForm)}',
            style: TextStyles.h11Gray(context)
                ?.copyWith(color: context.colorScheme.primary)),
      ],
    );
  }

  Widget nonCompact(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item.productKey.shortKey} (${item.unitDetails.displayLabel})',
              style: TextStyles.h13(context)
                  ?.copyWith(color: context.colorScheme.primary),
            ),
            PriceTag(price: item.unitPrice, style: TextStyles.h13Bold(context)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text('${item.productName}',
                    style: TextStyles.h13Gray(context),
                    overflow: TextOverflow.ellipsis)),
            Row(
              children: [
                InfoChip(
                    label: 'Disc',
                    value: '\u{20B9}${item.discount} | ',
                    isPrice: true,
                    showDot: false),
                Text(
                    '${item.unitDetails.formatTotalWithCount(item.quantity.toDouble(), countLabel: item.productType.shortForm)}',
                    style: TextStyles.h14Gray(context)?.copyWith(
                      color: context.colorScheme.primary,
                    )),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InfoChip(
                label: 'Total',
                value: '\u{20B9}${item.subtotal} | ',
                isPrice: true,
                showDot: false),
            InfoChip(
                label: 'Aft Disc',
                value: '\u{20B9}${netTotal}',
                isPrice: true,
                showDot: false),
          ],
        )
      ],
    );
  }
}
