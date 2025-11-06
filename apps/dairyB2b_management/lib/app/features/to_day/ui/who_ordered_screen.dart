import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/report_actions.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/company_report_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/who_ordered_section.dart';

class WhoOrderedScreenArgs {
  final List<DemandLine> demandLines;
  final CompanyEntry companyEntry;
  const WhoOrderedScreenArgs(
      {required this.demandLines, required this.companyEntry});
}

class WhoOrderedScreen extends HookConsumerWidget {
  final List<DemandLine> demandLines;
  final CompanyEntry companyEntry;
  const WhoOrderedScreen(
      {super.key, required this.demandLines, required this.companyEntry});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compactMode = useState(false);
    final reportActions = ref.read(reportActionsProvider.notifier);

    return ScaffoldX(
      wantLeading: true,
      title: 'Who Ordered (${demandLines.length})',
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
              itemCount: demandLines.length,
              itemBuilder: (context, index) {
                final demandLine = demandLines[index];
                return DemandLinesCard(
                    demandLine: demandLine, compactMode: compactMode.value);
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
              onPressed: () => reportActions.generateCompanyDailyPdf(
                  demandLines, companyEntry),
            ),
          ),
          gapW4,
          Flexible(
            child: ButtonX.primaryButton(
              context: context,
              label: 'XLSX',
              icon: Icons.table_chart,
              onPressed: () => reportActions.generateCompanyDailySheet(
                  demandLines, companyEntry),
            ),
          ),
        ],
      ),
    );
  }
}
