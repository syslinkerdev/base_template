import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/filter_company_reports.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/products_ordered_section.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/who_ordered_section.dart';
import 'package:system_assets/app_images.dart';

class CompanyReportScreenArgs {
  final Brand brand;
  final DateTime? selectedDate;
  final bool forActualDelivery;

  CompanyReportScreenArgs(
      {required this.brand, this.selectedDate, this.forActualDelivery = false});
}

///     ref.listen(reportActionsProvider,
///        (_, next) => next.showAlertDialogOnError(context));
/// Add this before coming to this page ok.
class CompanyReportScreen extends HookConsumerWidget {
  final Brand brand;
  final DateTime? selectedDate;
  final bool forActualDelivery;
  const CompanyReportScreen(
      {super.key,
      required this.brand,
      this.selectedDate,
      this.forActualDelivery = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyReportAsy = ref.watch(FilteredCompanyReportStreamProvider(
        companyId: brand.id,
        selectedDate: selectedDate,
        forActualDelivery: forActualDelivery));
    return ScaffoldX(
      wantLeading: true,
      title: '${brand.label} Report',
      body: companyReportAsy.when(
        data: (companyReport) {
          final companyEntry = companyReport?.companyEntry;
          if (companyReport == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.business,
                    size: context.sizeOfHeight * 0.12,
                    color: appColors.sc.grey650,
                  ),
                  gapH20,
                  Text('No activity recorded for this company today.',
                      textAlign: TextAlign.center,
                      style: TextStyles.h8Gray(context)),
                  gapH8,
                  Text('This company hasn\'t received any orders so far',
                      textAlign: TextAlign.center,
                      style: TextStyles.h14Gray(context)),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SpacedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              defaultHeight: 6,
              children: [
                if (companyEntry != null)
                  CompanyEntryCard(
                      companyImg: brand.image, companyEntry: companyEntry),
                ProductsOrderedSection(
                    productLines: companyReport.productLines,
                    companyEntry: companyReport.companyEntry),
                WhoOrderedSection(
                    demandLines: companyReport.demandLines,
                    companyEntry: companyReport.companyEntry),
                ManagementShortSlogan()
              ],
            ),
          );
        },
        error: (error, _) => ErrorScreen(error: error, onRetry: () {}),
        loading: () => _buildShimmerLoading(context),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliers = [0.2, 0.16, 0.16, 0.13];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SpacedColumn(
        children: List.generate(heightMultipliers.length, (i) {
          return ShimmerX(
            width: context.sizeOfWidth,
            height: context.sizeOfHeight * heightMultipliers[i],
          );
        }),
      ),
    );
  }
}

class CompanyEntryCard extends StatelessWidget {
  const CompanyEntryCard({
    super.key,
    required this.companyImg,
    required this.companyEntry,
  });

  final String? companyImg;
  final CompanyEntry companyEntry;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.zero,
      child: SpacedColumn(
        defaultHeight: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Company Logo/Image
              FadeInImageX(
                  imagePath: companyImg ?? sysImages.noInternet.path,
                  height: 60,
                  width: 60),
              gapW8,
              // ✅ Company Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(companyEntry.companyName,
                        style: TextStyles.h6(context)),
                    gapH4,
                    Row(
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: TextStyles.h12Gray(context)?.fontSize,
                            color: appColors.ms.textBlack50(context)),
                        gapW4,
                        Text("${companyEntry.prodCount} Products",
                            style: TextStyles.h12Gray(context)),
                        gapW12,
                        Icon(Icons.people,
                            size: TextStyles.h12Gray(context)?.fontSize,
                            color: appColors.ms.textBlack50(context)),
                        gapW4,
                        Text("${companyEntry.clientCount} Clients",
                            style: TextStyles.h12Gray(context)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ✅ Money Section
          BillDetails(companyEntry: companyEntry),
          // ✅ Created At
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "Created at ${DFU.moreFriendlyFormat(companyEntry.createdAt)} ${DFU.timeOnly12h(companyEntry.createdAt)}",
              style: TextStyles.h13Bold(context)
                  ?.copyWith(color: appColors.ms.textBlack50(context)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class BillDetails extends StatelessWidget {
  const BillDetails({super.key, required this.companyEntry});
  final CompanyEntry companyEntry;

  @override
  Widget build(BuildContext context) {
    final total = companyEntry.total;
    final afterDis = companyEntry.totalAfterDis;
    final discount = total - afterDis;

    return SpacedColumn(
      children: [
        _billRow(context, 'Total', '₹${PriceTag.formatPrice(total)}'),
        _billRow(context, 'Discount', '− ₹${PriceTag.formatPrice(discount)}'),
        _billRow(
            context, 'After Discount', '₹${PriceTag.formatPrice(afterDis)}'),
        SimpleDivider(),
        _billRow(context, 'Savings', '₹${PriceTag.formatPrice(discount)}'),
        // _billRow(context, 'Profit', '₹${PriceTag.formatPrice(profit)}'),
      ],
    );
  }

  Row _billRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DashedUnderlineText(
          text: label,
          style: TextStyles.h12Bold(context),
        ),
        Text(
          value,
          style: TextStyles.h12Bold(context)?.copyWith(fontFamily: 'Roboto'),
        ),
      ],
    );
  }
}
