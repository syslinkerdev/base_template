import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';

class DiscountsTile extends HookConsumerWidget {
  final DiscountSection disSection;

  const DiscountsTile({super.key, required this.disSection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toShow = useState<bool>(false);
    final discounts = disSection.productDiscounts.values.toList();
    return ContainerX(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discounts',
                style: TextStyles.h8Bold(context),
              ),
              DiscountsCount(discounts: discounts),
            ],
          ),
          if (discounts.isEmpty) ...[
            Center(
              child: Text(
                'No discounts available!',
                style: TextStyles.h8Gray(context),
              ),
            ),
          ] else ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 160),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SizeTransition(sizeFactor: animation, child: child);
                  },
                  child: toShow.value
                      ? SizedBox(
                          height: context.sizeOfHeight * 0.1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return DashDivider();
                                  },
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: discounts.length > 3
                                      ? 3
                                      : discounts.length,
                                  itemBuilder: (context, index) {
                                    final discount = discounts[index];
                                    return DiscountTile(
                                      title: discount.productKey,
                                      trailing: discount.discount.toDouble(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : DiscountTile(
                          title: discounts.first.productKey,
                          trailing: discounts.first.discount.toDouble(),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    gapW2,
                    ButtonX(
                      label: toShow.value ? 'Show Less' : 'Show More',
                      iconFirst: true,
                      icon: toShow.value
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      onPressed: () async {
                        toShow.value = !toShow.value;
                      },
                    ),
                    if (toShow.value) ...[
                      InkWell(
                        onTap: () =>
                            AppRoute.discounts.push(context, extra: discounts),
                        child: Icon(Icons.open_in_new, size: 28),
                      )
                    ] else ...[
                      SizedBox(width: 28)
                    ],
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class DiscountsCount extends StatelessWidget {
  const DiscountsCount({
    super.key,
    required this.discounts,
  });

  final List<Discount> discounts;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.discount,
          size: context.sizeOfWidth * 0.03,
          color: appColors.ms.textBlack50(context),
        ),
        gapW2,
        Text(
          '${discounts.length}',
          style: TextStyles.h8Gray(context),
        ),
      ],
    );
  }
}

class DiscountTile extends StatelessWidget {
  const DiscountTile({
    super.key,
    required this.title,
    required this.trailing,
  });

  final String title;
  final double trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.h8(context),
        ),
        PriceTag(price: trailing, style: TextStyles.h8Bold(context)),
      ],
    );
  }
}
