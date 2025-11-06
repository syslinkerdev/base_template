import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_assets/app_images.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/report_actions.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/generator_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/board.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/company_report_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/sub_widgets.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';

class ActualDeliveryPage extends HookConsumerWidget {
  const ActualDeliveryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);
    ref.listen(generatorXProvider, (_, next) {
      next.showAlertDialogOnError(context);
      next.maybeWhen(
        orElse: () => isLoading.value = false,
        data: (commentary) {
          if (commentary == null) {
            isLoading.value = false;
          } else {
            isLoading.value = true;
          }
        },
      );
    });
    ref.listen(reportActionsProvider,
        (_, next) => next.showAlertDialogOnError(context));
    final commentary = ref.watch(generatorXProvider).value;
    return ScaffoldX(
        title: 'Actual Delivery',
        wantLeading: true,
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  defaultHeight: 8,
                  children: [
                    ImageCard(),
                    ActionButtonX(
                      icon: Icons.fact_check_outlined,
                      iconColor: Colors.cyan.shade600,
                      label: 'ORDER ADJUSTMENTS',
                      onTap: () => AppRoute.ordersAdjustmentList.push(context),
                    ),
                    BrandsList(
                      onSelect: (brand) async {
                        isLoading.value = true;
                        await ref
                            .read(generatorXProvider.notifier)
                            .generateCompanyOrder(
                                companyId: brand.id, forActualDelivery: true)
                            .then((_) {
                          isLoading.value = false;
                          if (ref.watch(generatorXProvider).hasError) {
                            return;
                          }
                          AppRoute.companyReport.push(context,
                              extra: CompanyReportScreenArgs(
                                  brand: brand, forActualDelivery: true));
                        });
                      },
                    ),
                    HeadingLineFade(label: 'ACTIONS'),
                    ButtonX.containerButton(
                      context: context,
                      label: 'Generate All',
                      labelStyle: TextStyles.h8Gray(context)
                          ?.copyWith(fontWeight: FontWeight.bold),
                      labelColor: appColors.ms.textBlack50(context),
                      borderRadius: 12,
                      icon: Icons.auto_awesome,
                      flex: MainAxisAlignment.spaceBetween,
                      onPressed: () async {
                        isLoading.value = true;
                        await ref
                            .read(generatorXProvider.notifier)
                            .generateAllCompanyOrders(forActualDelivery: true)
                            .then((_) {
                          isLoading.value = false;
                          if (ref.watch(generatorXProvider).hasError) {
                            return;
                          }
                        });
                      },
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
                            .read(generatorXProvider.notifier)
                            .generateAllCompanyOrders(
                                processAllBrands: true,
                                forActualDelivery: true);
                        await ref
                            .watch(reportActionsProvider.notifier)
                            .exportAllReportsSheet(forActualDelivery: true);
                        isLoading.value = false;
                      },
                    ),
                    ManagementShortSlogan()
                  ],
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
                                  child: Text('$commentary',
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
        ));
  }
}

class ImageCard extends HookConsumerWidget {
  const ImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flipToMainOrder = useState<bool>(false);

    final actualDeliveryAsy = ref.watch(MainOrderStreamProvider(
        id: IdGenerator.actualDeliveryId(), forActualDelivery: true));
    return ContainerX(
      padding: const EdgeInsets.all(7),
      margin: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: context.sizeOfHeight * 0.18),
          child: Stack(
            clipBehavior: Clip.none, // allows overflow
            children: [
              if (flipToMainOrder.value) ...[
                actualDeliveryAsy.when(
                  data: (actualDelivery) {
                    if (actualDelivery == null) {
                      return Center(
                        child: Text(
                            'No Actual Delivery found for ${DFU.ddMMyyyy(actualDelivery?.deliveryDate ?? DFU.now())}',
                            style: TextStyles.h8(context)),
                      );
                    }
                    return MainOrderCard(
                        mainOrder: actualDelivery, forActualDelivery: true);
                  },
                  error: (error, stackTrace) => ContainerX(
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.nearby_error_rounded,
                              size: context.sizeOfHeight * 0.1,
                              color: appColors.sc.grey650),
                          gapH20,
                          Text(
                            error.toString(),
                            style: TextStyles.h8(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  loading: () => SpacedColumn(
                    children: List.generate(
                      4,
                      (_) => ShimmerX(
                          width: context.sizeOfWidth,
                          height: context.sizeOfHeight * 0.03),
                    ),
                  ),
                ),
              ] else ...[
                Positioned(
                  bottom: -8,
                  right: 2,
                  child: sysImages.actualDelivery
                      .toWidget(height: context.sizeOfHeight * 0.125),
                ),
                Positioned.fill(
                  top: 32,
                  child: Text.rich(
                    TextSpan(
                      text:
                          'Create ${DFU.ddMMyyyy(DFU.now())}\'s Actual\nDelivery by merging all\norders ',
                      style: TextStyles.h9Bold(context)?.copyWith(
                        color: appColors.ms.textBlack50(context),
                      ),
                      children: [
                        TextSpan(
                          text: 'efficiently.',
                          style: TextStyles.h9Bold(context)
                              ?.copyWith(color: const Color(0xFF7C4DFF)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              Positioned(
                right: 0,
                child: InkWell(
                  onTap: () => flipToMainOrder.value = !flipToMainOrder.value,
                  child: Icon(Icons.sync,
                      color: appColors.ms.textBlack80(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
