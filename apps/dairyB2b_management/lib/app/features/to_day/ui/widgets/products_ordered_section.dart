import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/report_actions.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/products_ordered_screen.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';

class ProductsOrderedSection extends HookConsumerWidget {
  final List<ProductLine> productLines;
  final CompanyEntry companyEntry;

  const ProductsOrderedSection(
      {super.key, required this.productLines, required this.companyEntry});

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
                'Products Ordered',
                style: TextStyles.h8Bold(context),
              ),
              LinesCount(
                productLinesCount: productLines.length,
                icon: Icons.inventory_2_outlined,
              ),
            ],
          ),
          if (productLines.isEmpty) ...[
            Center(
              child: Text(
                'No product lines available!',
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
                                  itemCount: productLines.length > 3
                                      ? 3
                                      : productLines.length,
                                  itemBuilder: (context, index) {
                                    final productLine = productLines[index];
                                    return ProductLineCard(
                                        productLine: productLine);
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : ProductLineCard(productLine: productLines.first),
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
                        onPressed: () =>
                            reportActions.generateCompanyProductSummaryPdf(
                                productLines, companyEntry),
                      ),
                      ActionBtn(
                        label: 'XLSX',
                        icon: Icons.table_chart,
                        onPressed: () =>
                            reportActions.generateCompanyProductSummarySheet(
                                productLines, companyEntry),
                      ),
                      if (toShow.value)
                        InkWell(
                          onTap: () => AppRoute.productsOrdered.push(context,
                              extra: ProductsOrderedScreenArgs(
                                  productLines: productLines,
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

class ActionBtn extends StatelessWidget {
  final FutureOr<void> Function()? onPressed;
  final bool loading;
  final String label;
  final IconData icon;

  const ActionBtn({
    Key? key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonX(
      label: label,
      icon: icon,
      iconFirst: true,
      gap: const SizedBox(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: BorderSide(color: context.colorScheme.primary, width: 1.6),
      ),
      backgroundColor: Colors.transparent,
      height: 28,
      labelStyle: TextStyles.h11Bold(context),
      labelColor: context.colorScheme.primary,
      iconColor: context.colorScheme.primary,
      loadingIconColor: context.colorScheme.primary,
      onPressed: onPressed,
      loading: loading,
    );
  }
}

class LinesCount extends StatelessWidget {
  const LinesCount(
      {super.key, required this.productLinesCount, required this.icon});

  final int productLinesCount;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: TextStyles.h10Gray(context)?.fontSize,
          color: appColors.ms.textBlack50(context),
        ),
        gapW2,
        Text(
          '$productLinesCount',
          style: TextStyles.h8Gray(context),
        ),
      ],
    );
  }
}

class ProductLineCard extends StatelessWidget {
  const ProductLineCard(
      {super.key, required this.productLine, this.compactMode = false});
  final ProductLine productLine;
  final bool compactMode;

  @override
  Widget build(BuildContext context) {
    final discountTotal = productLine.totalQuantity * productLine.discount;
    final netTotal = productLine.subtotal - discountTotal;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: compactMode ? compact(context) : nonCompact(context, netTotal),
    );
  }

  Widget compact(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${productLine.productKey.shortKey} (${productLine.unitDetails.displayLabel})',
          style: TextStyles.h9(context)
              ?.copyWith(color: context.colorScheme.primary),
        ),
        Text(
            '${productLine.unitDetails.formatTotalWithCount(productLine.totalQuantity.toDouble(), countLabel: productLine.productType.shortForm)}',
            style: TextStyles.h11Gray(context)
                ?.copyWith(color: context.colorScheme.primary)),
      ],
    );
  }

  Widget nonCompact(BuildContext context, double netTotal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${productLine.productKey.shortKey} (${productLine.unitDetails.displayLabel})',
              style: TextStyles.h13(context)
                  ?.copyWith(color: context.colorScheme.primary),
            ),
            PriceTag(
                price: productLine.unitPrice,
                style: TextStyles.h13Bold(context)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                  '${productLine.companyName} ${productLine.productName}',
                  style: TextStyles.h13Gray(context),
                  overflow: TextOverflow.ellipsis),
            ),
            Row(
              children: [
                InfoChip(
                    label: 'Disc',
                    value: '\u{20B9}${productLine.discount} | ',
                    isPrice: true,
                    showDot: false),
                Text(
                    '${productLine.unitDetails.formatTotalWithCount(productLine.totalQuantity.toDouble(), countLabel: productLine.productType.shortForm)}',
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
                value: '\u{20B9}${productLine.subtotal} | ',
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
