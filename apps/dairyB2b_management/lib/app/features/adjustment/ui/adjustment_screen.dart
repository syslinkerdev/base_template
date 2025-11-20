import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/order_provider.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/cart_items_ui.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/adjustment_bills_summary.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/listen_to_orders.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/products_screen.dart';

class AdjustmentScreen extends HookConsumerWidget with CommonValidator {
  const AdjustmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adjustment = ref.watch(adjustmentProvider);
    final adjustmentRead = ref.read(adjustmentProvider.notifier);
    final orderWatch = ref.watch(orderProProvider);
    final adjustmentData = adjustment.value;

    // Listen to order success & handle navigation
    listenToOrders(context, ref);

    return ScaffoldX(
      title: 'Adjustments',
      wantLeading: true,
      stopBottomBarHideScroll: true,
      appBarActions: _buildAppBarActions(context, adjustmentData),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Column(
              children: [
                if (adjustment.isLoading) _buildLoadingIndicator(context),
                Expanded(
                  child: adjustment.when(
                    data: (adjustmentData) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SpacedColumn(
                          defaultHeight: 0,
                          children: [
                            ContainerX(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child:
                                    ShowUserWidget(user: adjustmentData.user!)),
                            ContainerX(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: ChooseSmartBasketWidget(
                                user: adjustmentData.user!,
                                onSelect: (smartBasket) async =>
                                    await adjustmentRead.quickItemsAdd(
                                        cartItems: smartBasket.items),
                              ),
                            ),
                            if (adjustmentData.finalCart != null &&
                                adjustmentData.finalCart!.isNotEmpty) ...[
                              CartItemsUI(
                                  items: adjustmentData.finalCart!,
                                  mode: adjustmentData.mode,
                                  ref: ref),
                              CartFlash(cartItems: adjustmentData.finalCart!),
                              AdjustmentBillSummary(
                                  ref: ref,
                                  serviceCharges:
                                      adjustmentData.user?.serviceCharges),
                              const ManagementSloganFooter(),
                            ] else ...[
                              EmptyAdjustment(mode: adjustmentData.mode)
                            ],
                          ],
                        ),
                      );
                    },
                    error: (error, _) => ErrorScreen(
                        error: error,
                        onRetry: () => ref.refresh(adjustmentProvider.future)),
                    loading: () => _buildShimmerLoading(context),
                  ),
                ),
              ],
            ),
            if (orderWatch.isLoading) _buildOrderOverlay(context),
          ],
        ),
      ),
      bottomNavigationBar: adjustment.when(
        loading: () {
          // print('🌀 adjustment.when → loading state triggered');
          return ShimmerX(
            width: context.sizeOfWidth,
            height: context.sizeOfHeight,
          );
        },
        data: (adjustmentData) {
          // print('✅ adjustment.when → data received: $adjustmentData');
          final mode = adjustmentData.mode;
          // print('🔹 mode = $mode');
          // print('🔹 finalCart = ${adjustmentData.finalCart}');
          // print('🔹 user = ${adjustmentData.user}');

          if (adjustmentData.finalCart == null ||
              adjustmentData.finalCart!.isEmpty ||
              mode == null ||
              adjustmentData.user == null) {
            // print(
            //     '⚠️ Skipping bottomNavigationBar — some required data is null or empty');
            return null;
          }

          return ButtonX.primaryButton(
            context: context,
            label: mode.actionButtonLabel,
            backgroundColor: mode.color,
            loading: orderWatch.isLoading,
            onPressed: () async =>
                await ref.read(orderProProvider.notifier).handleOrderAction(
                      items: adjustmentData.finalCart!,
                      user: adjustmentData.user!,
                      previousOrder: adjustmentData.order,
                      mode: mode,
                    ),
          );
        },
        error: (err, st) {
          // print('❌ adjustment.when → error: $err');
          // print('📜 StackTrace: $st');
          return const SizedBox.shrink();
        },
      ),
    );
  }

  List<Widget> _buildAppBarActions(
      BuildContext context, AdjustmentState? adjustmentData) {
    if (adjustmentData?.mode == null) return [];
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: appColors.ms.transparent(context),
          borderRadius: BorderRadius.all(Radius.circular(context.sizeOfHeight)),
          border: Border.all(color: adjustmentData!.mode!.color, width: 2),
        ),
        child: Text(
          adjustmentData.mode!.name,
          style: TextStyles.h10Bold(context)
              ?.copyWith(color: adjustmentData.mode!.color),
        ),
      ),
      gapW16,
    ];
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return LinearProgressIndicator(
        backgroundColor: Colors.transparent,
        color: appColors.cS(context).onPrimaryFixedVariant,
        minHeight: 3);
  }

  Widget _buildOrderOverlay(BuildContext context) {
    return Container(
      color: appColors.ms.transparent80(context),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliers = [0.08, 0.08, 0.4, 0.2, 0.26];
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

class EmptyAdjustment extends StatelessWidget {
  const EmptyAdjustment({super.key, this.mode});
  final AdjustmentMode? mode;

  @override
  Widget build(BuildContext context) {
    final (icon, title, subtitle, buttonLabel) = (
      Icons.add_shopping_cart_rounded,
      'No Adjustments Found',
      'There are no items to adjust at the moment.',
      'Browse Products'
    );
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 2),
      child: SpacedColumn(
        defaultHeight: 8.0,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: context.sizeOfHeight * 0.1),
          Text(title, style: TextStyles.h7Bold(context)),
          Text(subtitle,
              style: TextStyles.h9Gray(context), textAlign: TextAlign.center),
          ButtonX(
            label: buttonLabel,
            backgroundColor: mode?.color,
            onPressed: () => prosBottomSheetNav(context),
          ),
        ],
      ),
    );
  }
}
