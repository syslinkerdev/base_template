import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/features/smart_basket/providers/smart_basket_providers.dart';
import 'package:dairyB2b_orders/app/features/smart_basket/ui/widgets/smart_basket_card.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

class SmartBasketDetailsScreen extends HookConsumerWidget {
  const SmartBasketDetailsScreen({super.key, required this.smartBasket});
  final SmartBasket smartBasket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartProvider.notifier);

    return ScaffoldX(
      title: 'Basket Details',
      wantLeading: true,
      appBarActions: [
        ButtonX(
          label: 'Edit',
          icon: Icons.edit_note_rounded,
          iconFirst: true,
          gap: SizedBox.shrink(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: context.colorScheme.primary, width: 1.6),
          ),
          backgroundColor: Colors.transparent,
          height: context.sizeOfHeight * 0.034,
          labelColor: context.colorScheme.primary,
          iconColor: context.colorScheme.primary,
          loadingIconColor: context.colorScheme.primary,
          onPressed: () async {
            final shouldNavigate = await DialogsX.askForConfirmation<bool>(
              context,
              content:
                  'Are you sure you want to edit this basket? This will clear your current cart.',
              cancelBtnText: 'Cancel',
              confirmBtnText: 'Edit',
            );
            if (shouldNavigate == true) {
              await cartNotifier.setMode(CartMode.editBasket,
                  cartItems: smartBasket.items,
                  editId: smartBasket.basketId,
                  basketName: smartBasket.basketName);
              if (!context.mounted) return;
              StatefulNavigationShell.of(context).goBranch(1);
            }
          },
        ),
        gapW16,
      ],
      body: SingleChildScrollView(
        child: SpacedColumn(
            mainAxisSize: MainAxisSize.max,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            crossAxisAlignment: CrossAxisAlignment.start,
            defaultHeight: 8,
            children: [
              SmartBasketCard(smartBasket: smartBasket, forDetailsPage: true),
              BasketMetaData(smartBasket: smartBasket),
              OrderedItemList(
                  items: smartBasket.items,
                  headerLabel: 'Basket Items',
                  headerIcon: Icons.shopping_basket,
                  headerColor: appColors.sc.cerulean)
            ]),
      ),
      bottomNavigationBar: Row(
        children: [
          Flexible(
            child: ButtonX.outlineButton(
              context: context,
              label: 'Delete',
              icon: Icons.delete_outline,
              onPressed: () async {
                final shouldDelete = await DialogsX.askForConfirmation<bool>(
                  context,
                  content: 'Are you sure you want to delete this basket?',
                  cancelBtnText: 'Cancel',
                  confirmBtnText: 'Delete',
                );
                if (shouldDelete == true) {
                  ref
                      .read(smartBasketXProvider.notifier)
                      .deleteSmartBasket(smartBasket.basketId)
                      .then(
                    (_) {
                      if (context.mounted) {
                        showMessageSnackbar(
                            context: context,
                            message: 'Basket deleted successfully',
                            type: SnackBarType.success);
                        context.close();
                      }
                    },
                  );
                }
              },
            ),
          ),
          gapW4,
          Flexible(
            child: ButtonX.primaryButton(
              context: context,
              label: 'Use Basket',
              icon: Icons.add_shopping_cart_outlined,
              onPressed: () async {
                final shouldUse = await DialogsX.askForConfirmation<bool>(
                  context,
                  content:
                      'Are you sure you want to use this basket? This will clear your current cart.',
                  cancelBtnText: 'Cancel',
                  confirmBtnText: 'Use',
                );
                if (shouldUse == true) {
                  cartNotifier.setMode(CartMode.newOrder,
                      cartItems: smartBasket.items,
                      editId: smartBasket.basketId);
                  if (!context.mounted) return;
                  StatefulNavigationShell.of(context).goBranch(1);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BasketMetaData extends StatelessWidget {
  const BasketMetaData({
    super.key,
    required this.smartBasket,
  });
  final SmartBasket smartBasket;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: EdgeInsets.zero,
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'Basket Metadata',
            icon: Icons.fingerprint,
            color: appColors.sc.nobel,
          ),
          MetaRow(
            onTap: () =>
                Clipboard.setData(ClipboardData(text: smartBasket.basketId))
                    .then(
              (_) {
                if (context.mounted) {
                  showMessageSnackbar(
                      context: context,
                      message: 'Basket Id copied to clipboard',
                      maxLines: 2);
                }
              },
            ),
            label: 'Basket ID',
            value: smartBasket.basketId,
            trailing: Icon(Icons.copy, size: 18),
          ),
          MetaRow(
            label: 'Created At',
            value: smartBasket.createdAt != null
                ? DFU.moreFriendlyFormat(smartBasket.createdAt!)
                : '—',
          ),
          MetaRow(
            label: 'Last Updated',
            value: smartBasket.updatedAt != null
                ? DFU.moreFriendlyFormat(smartBasket.updatedAt!)
                : '—',
          ),
          MetaRow(
            label: 'Items',
            value: smartBasket.items.length.toString(),
          ),
        ],
      ),
    );
  }
}
