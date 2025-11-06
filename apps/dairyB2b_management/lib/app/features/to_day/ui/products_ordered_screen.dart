import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/report_actions.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/company_report_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/products_ordered_section.dart';

class ProductsOrderedScreenArgs {
  final List<ProductLine> productLines;
  final CompanyEntry companyEntry;
  const ProductsOrderedScreenArgs(
      {required this.productLines, required this.companyEntry});
}

class ProductsOrderedScreen extends HookConsumerWidget {
  final List<ProductLine> productLines;
  final CompanyEntry companyEntry;
  const ProductsOrderedScreen(
      {super.key, required this.productLines, required this.companyEntry});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compactMode = useState(false);
    final reportActions = ref.read(reportActionsProvider.notifier);

    return ScaffoldX(
      wantLeading: true,
      title: 'Products Ordered (${productLines.length})',
      appBarActions: [
        InkWell(
          onTap: () => compactMode.value = !compactMode.value,
          child: Tooltip(
            message:
                compactMode.value ? "Show full details" : "Show compact view",
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
        gapW16
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          defaultHeight: 6,
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => DashDivider(),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productLines.length,
              itemBuilder: (context, index) {
                final productLine = productLines[index];
                return ProductLineCard(
                    productLine: productLine, compactMode: compactMode.value);
              },
            ),
            ContainerX(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(8.0),
                child: BillDetails(companyEntry: companyEntry))
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Flexible(
            child: ButtonX.outlineButton(
              context: context,
              label: 'PDF',
              icon: Icons.picture_as_pdf,
              onPressed: () => reportActions.generateCompanyProductSummaryPdf(
                  productLines, companyEntry),
            ),
          ),
          gapW4,
          Flexible(
            child: ButtonX.primaryButton(
              context: context,
              label: 'XLSX',
              icon: Icons.table_chart,
              onPressed: () => reportActions.generateCompanyProductSummarySheet(
                  productLines, companyEntry),
            ),
          ),
        ],
      ),
    );
  }
}
