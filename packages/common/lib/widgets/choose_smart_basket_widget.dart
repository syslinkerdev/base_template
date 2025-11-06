import 'dart:async';
import 'dart:math';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';

class ChooseSmartBasketWidget extends StatelessWidget {
  const ChooseSmartBasketWidget({
    super.key,
    required this.user,
    required this.onSelect,
  });

  final UserX user;
  final FutureOr<void> Function(SmartBasket smartBasket)? onSelect;

  @override
  Widget build(BuildContext context) {
    final baskets = user.smartBaskets ?? [];

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _openSmartBasketSheet(context, baskets, onSelect),
      child: ColorBgIconHeader(
        label: 'User Smart Basket',
        icon: Icons.shopping_basket_rounded,
        color: appColors.sc.cerulean,
        trailing: Icon(
          Icons.expand_more_rounded,
          size: context.sizeOfWidth * 0.07,
          color: appColors.ms.textBlack50(context),
        ),
      ),
    );
  }

  static Future<void> _openSmartBasketSheet(
    BuildContext context,
    List<SmartBasket> smartBaskets,
    FutureOr<void> Function(SmartBasket smartBasket)? onSelect,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SmartBasketSelectionSheet(
          smartBaskets: smartBaskets, onSelect: onSelect),
    );
  }
}

class SmartBasketSelectionSheet extends ConsumerWidget {
  const SmartBasketSelectionSheet({
    super.key,
    required this.smartBaskets,
    required this.onSelect,
  });

  final List<SmartBasket> smartBaskets;
  final FutureOr<void> Function(SmartBasket smartBasket)? onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        const Positioned(top: -60, child: _CloseButton()),
        Container(
          width: context.sizeOfWidth,
          height: min(context.sizeOfHeight * 0.7, 520),
          decoration: BoxDecoration(
            color: appColors.ms.whiteSwNero(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Choose Smart Basket (${smartBaskets.length})',
                  style: TextStyles.h7Gray(context),
                ),
                gapH12,

                // Empty State
                if (smartBaskets.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_basket_outlined,
                            size: 48,
                            color: appColors.ms.textBlack50(context),
                          ),
                          gapH8,
                          Text(
                            'No Smart Basket found for this user',
                            style: TextStyles.h8Gray(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: smartBaskets.length,
                      separatorBuilder: (_, __) => gapH4,
                      itemBuilder: (context, index) => ClientsSBCard(
                        smartBasket: smartBaskets[index],
                        onSelect: (smartBasket) async {
                          if (onSelect != null) {
                            await onSelect!(smartBasket);
                            if (context.mounted) Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        iconColor: WidgetStatePropertyAll(appColors.ms.whiteSwNero(context)),
        backgroundColor: WidgetStatePropertyAll(
          appColors.ms.neroSwWhite(context).withValues(alpha: 0.3),
        ),
      ),
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.close_rounded, weight: 10),
    );
  }
}

class ClientsSBCard extends ConsumerWidget {
  const ClientsSBCard({
    super.key,
    required this.smartBasket,
    required this.onSelect,
  });

  final SmartBasket smartBasket;
  final FutureOr<void> Function(SmartBasket smartBasket)? onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContainerX(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.sizeOfWidth * 0.1,
                height: context.sizeOfHeight * 0.05,
                decoration: BoxDecoration(
                  color: appColors.cS(context).surfaceTint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "B-${smartBasket.createdAt?.day ?? ''}",
                    style: TextStyles.h10Bold(context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              gapW8,
              Expanded(
                child: Text(
                  smartBasket.basketName,
                  style: TextStyles.h9Bold(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ButtonX(
                label: 'Use',
                onPressed: () async {
                  if (onSelect != null) await onSelect!(smartBasket);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(width: 1.2),
                ),
                height: context.sizeOfHeight * 0.034,
                labelStyle: TextStyles.h8Bold(context),
                gap: const SizedBox.shrink(),
              ),
            ],
          ),
          const SimpleDivider(),

          // Items Preview
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in smartBasket.items.take(2)) ...[
                  Flexible(
                    child: Text(
                      "• ${item.productName}",
                      style: TextStyles.h13Bold(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  gapW4,
                ],
                if (smartBasket.items.length > 2)
                  Text(
                    "+ ${smartBasket.items.length - 2} more…",
                    style: TextStyles.h13(context)?.copyWith(
                      color: appColors.ms.textBlack50(context),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
