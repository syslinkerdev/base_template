import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/today_providers.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/users_with_orders_list.dart';
import 'package:repo/repo.dart';

class Board extends ConsumerWidget {
  const Board({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldX(
      wantLeading: false,
      title: AppEnv.companyName,
      appToolbarHeight: -1,
      titleStyle: TextStyles.h5Bold(context)
          ?.copyWith(color: appColors.ms.black(context)),
      body: RefreshIndicator(
        onRefresh: () async => _refresh(ref),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            defaultHeight: 8,
            children: [
              NextDayOrderInfo(forManagement: true),
              ActionButtonX(
                icon: Icons.local_shipping_outlined,
                iconColor: const Color(0xFF8D6E63),
                label: '${DFU.ddMMyyyy(DFU.now())} ACTUAL DELIVERY',
                onTap: () => AppRoute.actualDeliveryPage.push(context),
              ),
              RulesBtn(ref: ref),
              AdminOrdersProgress(),
              ActionButtonX(
                icon: Icons.check_circle,
                iconColor: Colors.green.shade800,
                label: 'WHO ORDERED',
                onTap: () => AppRoute.usersWithOrdersList.push(context,
                    extra: UsersWithOrdersListArgs(
                        orderFilter: AdminOrderFilter.whoOrdered)),
              ),
              ActionButtonX(
                icon: Icons.cancel,
                iconColor: Colors.red.shade800,
                label: "WHO DIDN'T ORDER",
                onTap: () => AppRoute.usersWithOrdersList.push(context,
                    extra: UsersWithOrdersListArgs(
                        orderFilter: AdminOrderFilter.whoNotOrdered)),
              ),
              ActionButtonX(
                icon: Icons.layers,
                iconColor: appColors.sc.heartChakra,
                label: '${DFU.ddMMyyyy(DFU.nextDay())} MASTER ORDER',
                onTap: () => AppRoute.masterOrderPage.push(context),
              ),
              NextDayOrder(
                uId: ref.read(appStateXProvider).uId,
                onPress: (isTodaysOrderExist) async {
                  try {
                    await AppLauncherService.openOrdersApp();
                  } catch (e) {
                    if (context.mounted) {
                      showMessageSnackbar(
                        context: context,
                        message: e.toString(),
                        maxLines: 2,
                      );
                    }
                  }
                },
              ),
              ManagementSloganFooter(),
              gapH24
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _refresh(WidgetRef ref) async => await Future.wait([
        ref.refresh(orderRulesStreamProvider.future),
        ref.refresh(doesOrderExistForNextDayProvider(
                uId: ref.watch(appStateXProvider).uId)
            .future),
        ref.refresh(ToDaysProgressStreamProvider().future),
      ]);
}

class RulesBtn extends StatelessWidget {
  const RulesBtn({super.key, required this.ref});
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    final orderRules = ref.watch(orderRulesStreamProvider);

    return orderRules.when(
      data: (_) {
        return ActionButtonX(
          icon: Icons.rule,
          iconColor: Colors.amber.shade800,
          label: 'RULES',
          onTap: () => AppRoute.rules.push(context),
        );
      },
      error: (error, stackTrace) => ContainerX(
        child: Center(
          child: Row(
            children: [
              Icon(Icons.error_outline,
                  size: context.sizeOfHeight * 0.03,
                  color: appColors.sc.grey650),
              gapW20,
              Expanded(
                child: Text(
                  'Failed to load order rules: ${error.toString()}',
                  style: TextStyles.h8(context)
                      ?.copyWith(color: appColors.sc.grey700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => ShimmerX(
          width: context.sizeOfWidth, height: context.sizeOfHeight * 0.068),
    );
  }
}

class AdminOrdersProgress extends ConsumerWidget {
  const AdminOrdersProgress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminListAsync = ref.watch(ToDaysProgressStreamProvider());

    final admins = adminListAsync.valueOrNull; // ✅ last known data
    final isLoading = adminListAsync.isLoading; // ✅ is reloading?
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingLineFadeWithLoading(
            label: 'ORDERS PROGRESS', isLoading: isLoading),
        if (admins == null)
          _buildShimmerLoading(context)
        else
          SizedBox(
            height: 172,
            child: DynamicList<AdminCount>(
              items: admins,
              scrollDirection: Axis.horizontal,
              onSelect: (adminFilter) => AppRoute.usersWithOrdersList.push(
                context,
                extra: UsersWithOrdersListArgs(
                    adminUid: adminFilter.uId,
                    orderFilter: AdminOrderFilter.whoOrdered),
              ),
              itemBuilder: (context, item, isSelected) {
                return ContainerX(
                  width: context.sizeOfWidth * 0.4,
                  child: SpacedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: TextStyles.h7Gray(context),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Spacer(),
                      Text('${item.completed}/${item.totalClients}',
                          style: TextStyles.h5Bold(context)),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          2,
          (i) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerX(width: context.sizeOfWidth * 0.4, height: 172),
            );
          },
        ),
      ),
    );
  }
}

class ActionButtonX extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;
  final bool wantDownArrow;

  const ActionButtonX({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
    this.wantDownArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ContainerX(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            ColorBgIcon(icon: icon, color: iconColor),
            gapW12,
            Expanded(
              child: Text(
                label,
                style: TextStyles.h8Gray(context)
                    ?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Transform.rotate(
              angle: wantDownArrow ? 1.5708 : 0,
              child: Icon(Icons.arrow_forward_ios_rounded,
                  color: appColors.ms.textBlack50(context)),
            ),
          ],
        ),
      ),
    );
  }
}
