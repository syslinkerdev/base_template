import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';

class CancelMode extends StatelessWidget {
  const CancelMode({
    super.key,
    required this.ref,
    required this.mode,
  });

  final WidgetRef ref;
  final CartMode mode;

  /// Returns appropriate cancel prompt text
  String _getCancelText() {
    return switch (mode) {
      CartMode.edit => "Don't want to continue editing this order?",
      CartMode.basket => "Don't want to continue Smart Basket creation?",
      CartMode.editBasket => "Don't want to continue editing this basket?",
      CartMode.newOrder => "", // hide widget for newOrder
    };
  }

  /// Returns appropriate dialog content
  String _getDialogContent() {
    return switch (mode) {
      CartMode.edit => "Are you sure you want to cancel editing this order?",
      CartMode.basket =>
        "Are you sure you want to discard Smart Basket creation?",
      CartMode.editBasket =>
        "Are you sure you want to cancel editing this basket?",
       CartMode.newOrder => "",
    };
  }

  @override
  Widget build(BuildContext context) {
    if (mode == CartMode.newOrder) return const SizedBox.shrink();

    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              _getCancelText(),
              style: TextStyles.h10Bold(context)?.copyWith(
                color: appColors.ms.textBlack50(context),
              ),
            ),
          ),
          ButtonX(
              label: 'Yes',
              icon: Icons.close_rounded,
              iconFirst: true,
              iconSize: 18,
              labelStyle: TextStyles.h12Bold(context),
              noAsyncLoading: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: appColors.sc.liteRed, width: 1.2),
              ),
              backgroundColor: Colors.transparent,
              height: context.sizeOfHeight * 0.034,
              labelColor: appColors.sc.liteRed,
              iconColor: appColors.sc.liteRed,
              onPressed: () async {
                final navigator =
                    Navigator.of(context); // capture local context first
                final value = await DialogsX.askForConfirmation(
                  context,
                  content: _getDialogContent(),
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                );

                if (value == true) {
                  // ✅ Step 1: Give a frame to let dialog fully disappear
                  await Future.microtask(() {});
                  await Future.delayed(const Duration(milliseconds: 50));

                  // ✅ Step 2: Now do the real work
                  await ref.read(cartProvider.notifier).clearCart();

                  if (!navigator.mounted) return;
                  StatefulNavigationShell.of(navigator.context)
                      .goBranch(0, initialLocation: true);
                }
              })
        ],
      ),
    );
  }
}
