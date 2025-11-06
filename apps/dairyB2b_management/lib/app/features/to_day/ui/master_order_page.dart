import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/report_actions.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/generator_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/company_report_screen.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/sub_widgets.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/time_remaining.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';
import 'package:system_assets/app_images.dart';

class MasterOrderPage extends HookConsumerWidget {
  const MasterOrderPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesAsy = ref.watch(orderRulesStreamProvider);
    final now = DFU.now();

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
        title: 'Master Order',
        wantLeading: true,
        body: Stack(
          children: [
            rulesAsy.when(
              data: (rules) {
                final endTime = rules?.todayEffectiveOrderEnd;
                bool canIGen = endTime != null && now.isAfter(endTime);

                return SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SpacedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      defaultHeight: 8,
                      children: [
                        NextDayOrderInfo(forManagement: true),
                        ImageCard(),
                        TimeRemaining(
                            message: 'Now you can generate master order.',
                            messageTextColor: appColors.sc.approved),
                        BrandsList(
                          onSelect: (brand) async {
                            if (endTime == null) {
                              showMessageSnackbar(
                                  context: context,
                                  message: '⚠️ No order end time set for today',
                                  type: SnackBarType.warning);
                              return;
                            }
                            if (canIGen) {
                              isLoading.value = true;
                              await ref
                                  .read(generatorXProvider.notifier)
                                  .generateCompanyOrder(companyId: brand.id)
                                  .then((_) {
                                isLoading.value = false;
                                if (ref.watch(generatorXProvider).hasError) {
                                  return;
                                }
                                AppRoute.companyReport.push(context,
                                    extra:
                                        CompanyReportScreenArgs(brand: brand));
                              });
                            } else {
                              final formatted = DFU.timeOnly12h(endTime);
                              showMessageSnackbar(
                                  context: context,
                                  message:
                                      '⏳ Please wait until $formatted to generate orders',
                                  maxLines: 2);
                            }
                          },
                        ),
                        HeadingLineFade(label: 'ACTIONS'),
                        rulesAsy.when(
                          data: (_) {
                            return ButtonX.containerButton(
                              context: context,
                              label: 'Generate All',
                              labelStyle: TextStyles.h8Gray(context)
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              labelColor: appColors.ms.textBlack50(context),
                              borderRadius: 12,
                              icon: Icons.auto_awesome,
                              flex: MainAxisAlignment.spaceBetween,
                              onPressed: () async {
                                if (endTime == null) {
                                  showMessageSnackbar(
                                      context: context,
                                      message:
                                          '⚠️ No order end time set for today',
                                      type: SnackBarType.warning);
                                  return;
                                }
                                if (canIGen) {
                                  isLoading.value = true;
                                  await ref
                                      .read(generatorXProvider.notifier)
                                      .generateAllCompanyOrders()
                                      .then((_) => isLoading.value = false);
                                } else {
                                  final formatted = DFU.timeOnly12h(endTime);
                                  showMessageSnackbar(
                                      context: context,
                                      message:
                                          '⏳ Please wait until $formatted to generate orders',
                                      maxLines: 2);
                                }
                              },
                            );
                          },
                          error: (error, _) => ContainerX(
                            margin: EdgeInsets.only(bottom: 4),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              children: [
                                ColorBgIcon(
                                    icon: Icons.error_outline,
                                    color: appColors.sc.grey650),
                                gapW20,
                                Expanded(
                                  child: Text(
                                      'Failed to load order rules: ${error.toString()}',
                                      style: TextStyles.h10Gray(context)
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          loading: () =>
                              ShimmerX(width: context.sizeOfWidth, height: 60),
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
                          noAsyncLoading: true,
                          onPressed: () async {
                            if (endTime == null) {
                              showMessageSnackbar(
                                  context: context,
                                  message: '⚠️ No order end time set for today',
                                  type: SnackBarType.warning);
                              return;
                            }
                            if (canIGen) {
                              isLoading.value = true;
                              await ref
                                  .read(generatorXProvider.notifier)
                                  .generateAllCompanyOrders(
                                      processAllBrands: true);
                              await ref
                                  .watch(reportActionsProvider.notifier)
                                  .exportAllReportsSheet();
                              isLoading.value = false;
                            } else {
                              final formatted = DFU.timeOnly12h(endTime);
                              showMessageSnackbar(
                                  context: context,
                                  message:
                                      '⏳ Please wait until $formatted to generate orders',
                                  maxLines: 2);
                            }
                          },
                        ),
                        ManagementShortSlogan()
                      ],
                    ),
                  ),
                );
              },
              error: (error, stackTrace) => ErrorScreen(
                  error: error,
                  onRetry: () => ref.refresh(orderRulesStreamProvider.future)),
              loading: () => LoadingScreen(),
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
                                  child: Text(commentary ?? 'Generating . . .',
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

    final masterOrderAsy =
        ref.watch(MainOrderStreamProvider(id: IdGenerator.mainOrderId()));
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
                masterOrderAsy.when(
                  data: (masterOrder) {
                    if (masterOrder == null) {
                      return Center(
                        child: Text(
                            'No Master Order found for ${DFU.ddMMyyyy(masterOrder?.deliveryDate ?? DFU.nextDay())}',
                            style: TextStyles.h8(context)),
                      );
                    }
                    return MainOrderCard(mainOrder: masterOrder);
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
                        height: context.sizeOfHeight * 0.03,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Positioned(
                  bottom: -8,
                  right: 2,
                  child: sysImages.mainOrder
                      .toWidget(height: context.sizeOfHeight * 0.195),
                ),
                Positioned.fill(
                  top: 32,
                  child: Text.rich(
                    TextSpan(
                      text:
                          'Create ${DFU.ddMMyyyy(DFU.nextDay())}\'s Master\nOrder by merging all\norders ',
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

/// client_orders
/// coll for storing client <-> company filter data so we can generate
/// this ex : name | TM | CM | TC |
///           Ram  | 10 | 0  | 2  |  this we have to show know
/// product_lines 
/// coll for storing product <-> company filter data so we can generate
/// this ex : PName | Count | Units | Price | TPrice
///           ATM   | 100   | ml    | 30    | 3000 
/// 
/// product_lines   // supply side summary (all products, filter by companyId)
/// demand_lines    // demand side summary (all client orders, filter by companyId)
/// product_lines → what products exist and their totals (supply).
/// demand_lines → what clients ordered and how much each company needs to fulfill (demand).
//  2025-08-20 (document)
//  ├── product_lines   // all products of all companies with qty, price, totals (filter by companyId)
//  ├── demand_lines  // client orders, grouped by companyId (filter to see what to order from Amul, Heritage, etc.)
