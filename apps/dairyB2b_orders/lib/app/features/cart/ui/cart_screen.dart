import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/widgets/cart_items.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/widgets/empty_cart.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/widgets/cancel_mode.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/order_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/widgets/cart_bill_summary.dart';
import 'package:dairyB2b_orders/app/features/cart/ui/widgets/listen_to_cart_orders.dart';
import 'package:dairyB2b_orders/app/features/home/widgets/time_remaining_widget.dart';

class CartScreen extends HookConsumerWidget with CommonValidator {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final orderWatch = ref.watch(orderProProvider);
    final cartState = cart.value;

    // print(
    // 'Cart State: cart_screen ${cartState?.mode} ${cartState?.editId} ${cartState?.basketName}');
    final basketNameController = useMemoized(
      () => TextEditingController(text: cartState?.basketName ?? ''),
      [cartState?.mode],
    );

    // Listen to order success & handle navigation
    listenToCartOrders(context, ref);

    // print(
    // 'cartState?.basketName ---------- ${cartState?.basketName} basketNameController --------- ${basketNameController.text}');

    return ScaffoldX(
      title: 'Cart',
      wantLeading: true,
      stopBottomBarHideScroll: true,
      leadingOnPressed: () => _onBack(context),
      appBarActions: _buildAppBarActions(context, cartState),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Column(
              children: [
                if (cart.isLoading) _buildLoadingIndicator(context),
                Expanded(
                  child: cart.when(
                    data: (cartData) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SpacedColumn(
                          children: [
                            if (cartData.mode == CartMode.newOrder ||
                                cartData.mode == CartMode.edit) ...[
                              NextDayOrderInfo(),
                              TimeRemaining(dontWantRefresh: true),
                            ],
                            if (cartData.mode != CartMode.newOrder) ...[
                              CancelMode(ref: ref, mode: cartData.mode!),
                            ],
                            if (cartData.mode == CartMode.basket ||
                                cartData.mode == CartMode.editBasket) ...[
                              AppTextField(
                                controller: basketNameController,
                                title: 'Basket Name',
                                hintText: 'Enter a name for your Smart Basket',
                                isMandatory: true,
                                onChanged: (basketName) => ref
                                    .watch(cartProvider.notifier)
                                    .updateBasketName(basketName),
                              ),
                            ],
                            if (cartData.finalCart != null &&
                                cartData.finalCart!.isNotEmpty) ...[
                              CartItemsUI(
                                  cartItems: cartData.finalCart!,
                                  mode: cartData.mode ?? CartMode.newOrder,
                                  ref: ref),
                              CartFlash(cartItems: cartData.finalCart!),
                              CartBillSummary(
                                  ref: ref,
                                  serviceCharges: cartData.serviceCharges),
                              const OrderSloganFooter(),
                            ] else ...[
                              EmptyCart(
                                  mode: cartData.mode ?? CartMode.newOrder)
                            ],
                          ],
                        ),
                      );
                    },
                    error: (error, _) => ErrorScreen(
                        error: error,
                        onRetry: () => ref.refresh(cartProvider.future)),
                    loading: () => _buildShimmerLoading(context),
                  ),
                ),
              ],
            ),
            if (orderWatch.isLoading) _buildOrderOverlay(context),
          ],
        ),
      ),
      bottomNavigationBar: cart.when(
        loading: () => ShimmerX(
          width: context.sizeOfWidth,
          height: context.sizeOfHeight,
        ),
        data: (cartState) {
          final cartItems = cartState.cart ?? [];
          final mode = cartState.mode;

          if (cartState.finalCart == null ||
              cartState.finalCart!.isEmpty ||
              mode == null) return null;

          return ButtonX.primaryButton(
            context: context,
            label: mode.actionButtonLabel,
            backgroundColor: mode.color,
            loading: orderWatch.isLoading,
            onPressed: () async {
              await ref.read(orderProProvider.notifier).handleCartAction(
                    mode: mode,
                    cartItems: cartItems,
                    editId: cartState.editId,
                    basketName: cartState.basketName,
                  );
              basketNameController.clear();
            },
          );
        },
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }

  void _onBack(BuildContext context) =>
      StatefulNavigationShell.of(context).goBranch(0);

  Widget _buildLoadingIndicator(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.transparent,
      color: appColors.cS(context).onPrimaryFixedVariant,
      minHeight: 3,
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context, CartState? cartState) {
    if (cartState?.mode == null) return [];
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: appColors.ms.transparent(context),
          borderRadius: BorderRadius.all(Radius.circular(context.sizeOfHeight)),
          border: Border.all(color: cartState!.mode!.color, width: 2),
        ),
        child: Text(
          cartState.mode!.name,
          style: TextStyles.h10Bold(context)
              ?.copyWith(color: cartState.mode!.color),
        ),
      ),
      gapW16,
    ];
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
