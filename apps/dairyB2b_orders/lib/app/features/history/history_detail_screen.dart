import 'dart:async';

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';

class HistoryDetailScreen extends HookConsumerWidget {
  const HistoryDetailScreen({super.key, required this.selectedDay});
  final DateTime selectedDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uId = ref.watch(appStateXProvider).uId;
    final fetchOrderForDayPro = fetchOrderProvider(uId: uId, day: selectedDay);
    final order = ref.watch(fetchOrderForDayPro);
    final orderRead = ref.read(fetchOrderForDayPro);
    final clientFetcher = ref.watch(fetchUserProvider(documentId: uId));
    final doesOrderExistForToday =
        ref.watch(doesOrderExistForNextDayProvider(uId: uId));
    final orderRules = ref.watch(orderRulesStreamProvider);

    return ScaffoldX(
      title: 'Order Details',
      wantLeading: true,
      appBarActions: [
        if (isSameDay(orderRead.value?.createdAt, DateTime.now()))
          orderRules.maybeWhen(
            orElse: () => SizedBox.shrink(),
            data: (orderRules) {
              if (orderRules != null &&
                  orderRules.orderStart != null &&
                  orderRules.orderEnd != null) {
                if (orderRules.canEdit) {
                  return ButtonX(
                    label: 'Edit',
                    icon: Icons.edit_note_rounded,
                    iconFirst: true,
                    gap: SizedBox.shrink(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                          color: context.colorScheme.primary, width: 1.6),
                    ),
                    backgroundColor: Colors.transparent,
                    height: context.sizeOfHeight * 0.034,
                    labelColor: context.colorScheme.primary,
                    iconColor: context.colorScheme.primary,
                    loadingIconColor: context.colorScheme.primary,
                    onPressed: setMode(
                      ref,
                      context,
                      orderedProducts: orderRead.value?.orderedProducts ?? [],
                      mode: CartMode.edit,
                      editId: orderRead.value?.orderId,
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        gapW16,
      ],
      body: order.when(
        data: (orderDetails) {
          if (orderDetails == null) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: context.sizeOfHeight * 0.15),
                  Icon(Icons.remove_shopping_cart,
                      size: context.sizeOfHeight * 0.12,
                      color: appColors.sc.grey650),
                  gapH20,
                  Text(
                    'Whoops! You skipped ordering on this day (${DFU.ddMMyyyy(selectedDay)})!',
                    style: TextStyles.h7(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                _refresh(ref: ref, uId: uId, selectedDay: selectedDay),
            child: SingleChildScrollView(
              child: SpacedColumn(
                  mainAxisSize: MainAxisSize.max,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  defaultHeight: 8,
                  children: [
                    HistoryOrderCard(
                        orderDetails: orderDetails, doNotWantArrow: true),
                    OrderedItemList(
                        items: orderDetails.orderedProducts,
                        headerLabel: 'Products Ordered',
                        headerIcon: Icons.local_mall,
                        headerColor: appColors.sc.liteRed),
                    HistoryBillSummary(orderDetails: orderDetails),
                    LogsShow(logs: orderDetails.logs)
                  ]),
            ),
          );
        },
        error: (error, stackTrace) => ErrorScreen(
            error: error,
            onRetry: () =>
                _refresh(ref: ref, uId: uId, selectedDay: selectedDay)),
        loading: () => _buildShimmerLoading(context),
      ),
      bottomNavigationBar:
          order.isLoading || order.hasError || order.value == null
              ? null
              : Row(
                  children: [
                    Flexible(
                      child: ButtonX.outlineButton(
                        context: context,
                        label: 'Invoice',
                        icon: Icons.file_download_outlined,
                        onPressed:
                            invoiceOnPress(clientFetcher, context, orderRead),
                      ),
                    ),
                    gapW4,
                    doesOrderExistForToday.maybeWhen(
                      orElse: () => SizedBox.shrink(),
                      data: (doesOrderExistToday) {
                        if (doesOrderExistToday) {
                          return SizedBox.shrink();
                        } else {
                          return Flexible(
                            child: ButtonX.primaryButton(
                                context: context,
                                label: 'Reorder',
                                icon: Icons.replay_outlined,
                                loading: ref.watch(cartProvider).isLoading,
                                onPressed: setMode(ref, context,
                                    orderedProducts:
                                        orderRead.value?.orderedProducts ?? [],
                                    mode: CartMode.newOrder)),
                          );
                        }
                      },
                    ),
                  ],
                ),
    );
  }

  FutureOr<void> Function()? setMode(WidgetRef ref, BuildContext context,
      {required List<CartItem> orderedProducts,
      required CartMode mode,
      String? editId}) {
    final cartNotifier = ref.read(cartProvider.notifier);
    return () async {
      await cartNotifier.setMode(mode,
          cartItems: orderedProducts, editId: editId);
      if (!context.mounted) return;
      StatefulNavigationShell.of(context).goBranch(1);
    };
  }

  FutureOr<void> Function()? invoiceOnPress(
    AsyncValue<UserX?> clientFetcher,
    BuildContext context,
    AsyncValue<OrderX?> orderRead,
  ) {
    final UserX? cachedUser = GlobalCacheService.instance.getUser();

    Future<void> generate(UserX user) async {
      if (!context.mounted) return;
      await generateInvoicePdf(
          context: context, order: orderRead.value!, user: user);
    }

    void showNoUserMessage() {
      showMessageSnackbar(context: context, message: 'No user data available');
    }

    if (cachedUser != null) {
      return () async => await generate(cachedUser);
    }

    return clientFetcher.maybeWhen(
      data: (user) {
        if (user == null) {
          return () => showNoUserMessage();
        }

        GlobalCacheService.instance.setUser(user);
        return () async => await generate(user);
      },
      orElse: () => () => showNoUserMessage(),
    );
  }

  static Future<void> _refresh({
    required WidgetRef ref,
    required String uId,
    required DateTime selectedDay,
  }) async =>
      await ref.refresh(fetchOrderProvider(uId: uId, day: selectedDay).future);

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliersView = [0.14, 0.24, 0.2, 0.14];
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SpacedColumn(
        defaultHeight: 8,
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
