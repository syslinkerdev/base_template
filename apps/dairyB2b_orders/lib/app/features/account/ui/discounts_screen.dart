import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/features/account/widgets/discounts_tile.dart';

class DiscountsScreen extends ConsumerWidget {
  const DiscountsScreen({super.key, required this.discounts});
  final List<Discount> discounts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldX(
      title: 'Your Discounts',
      titleCenter: true,
      wantLeading: true,
      appBarActions: [DiscountsCount(discounts: discounts), gapW16],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return DashDivider();
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: discounts.length,
            itemBuilder: (context, index) {
              final discount = discounts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DiscountTile(
                  title: discount.productKey,
                  trailing: discount.discount.toDouble(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
