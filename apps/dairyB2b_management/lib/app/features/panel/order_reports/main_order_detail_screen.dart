import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/report_actions.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/company_report_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/sub_widgets.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';

class MainOrderDetailScreenArgs {
  final DateTime selectedDate;
  final bool forActualDelivery;

  MainOrderDetailScreenArgs(
      {required this.selectedDate, this.forActualDelivery = false});
}

class MainOrdersDetailScreen extends HookConsumerWidget {
  final DateTime selectedDate;
  final bool forActualDelivery;

  const MainOrdersDetailScreen(
      {super.key, required this.selectedDate, this.forActualDelivery = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainOrderAsy = ref.watch(MainOrderStreamProvider(
      id: forActualDelivery
          ? IdGenerator.actualDeliveryIdUsingDate(selectedDate)
          : IdGenerator.mainOrderIdUsingDate(selectedDate),
      forActualDelivery: forActualDelivery,
    ));
    final isLoading = useState<bool>(false);
    ref.listen(reportActionsProvider,
        (_, next) => next.showAlertDialogOnError(context));
    return ScaffoldX(
      wantLeading: true,
      title: forActualDelivery
          ? 'Actual Deliveries Details'
          : 'Master Order Details',
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: mainOrderAsy.when(
                data: (mainOrder) {
                  if (mainOrder == null) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: context.sizeOfHeight * 0.15),
                          Icon(Icons.remove_shopping_cart,
                              size: context.sizeOfHeight * 0.12,
                              color: appColors.sc.grey650),
                          gapH20,
                          Text(
                            'Whoops! No Master Order found for ${DFU.moreFriendlyFormat(selectedDate)}!',
                            style: TextStyles.h7(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  return SpacedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    defaultHeight: 8,
                    children: [
                      ContainerX(
                          padding: const EdgeInsets.all(8),
                          margin: EdgeInsets.zero,
                          child: MainOrderCard(
                              mainOrder: mainOrder,
                              forActualDelivery: forActualDelivery)),
                      BrandsList(
                        onSelect: (brand) => AppRoute.companyReport.push(
                            context,
                            extra: CompanyReportScreenArgs(
                                brand: brand, selectedDate: selectedDate)),
                      ),
                      ButtonX.containerButton(
                        context: context,
                        label: 'Export All Reports',
                        labelStyle: TextStyles.h8Gray(context)
                            ?.copyWith(fontWeight: FontWeight.bold),
                        labelColor: appColors.ms.textBlack50(context),
                        borderRadius: 12,
                        icon: Icons.table_chart_outlined,
                        flex: MainAxisAlignment.spaceBetween,
                        onPressed: () async {
                          isLoading.value = true;
                          await ref
                              .watch(reportActionsProvider.notifier)
                              .exportAllReportsSheet(
                                  forActualDelivery: forActualDelivery,
                                  selectedDate: selectedDate);
                          isLoading.value = false;
                        },
                      ),
                      ManagementShortSlogan()
                    ],
                  );
                },
                error: (error, stackTrace) =>
                    ErrorScreen(error: error, onRetry: () {}),
                loading: () => _buildShimmerLoading(context),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isLoading.value
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: appColors.ms.transparent80(context),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ContainerX(
                          margin: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: ColorX.instance.sc.normal,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        ColorX.instance.sc.whiteS),
                                  ),
                                ),
                              ),
                              gapW6,
                              Expanded(
                                child: Text('Generating report...',
                                    style: TextStyles.h10Bold(context),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          )),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliersView = [0.1, 0.03, 0.6, 0.1];
    return SingleChildScrollView(
      child: SpacedColumn(
        children: heightMultipliersView
            .map((h) => ShimmerX(
                  width: context.sizeOfWidth,
                  height: context.sizeOfHeight * h,
                ))
            .toList(),
      ),
    );
  }
}
