import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';

class DiscountShow extends ConsumerWidget {
  const DiscountShow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Text('Use dialog fun.'),
    );
  }

  static Future<void> dialog(BuildContext context, Discount discount) async {
    await DialogsX.showCustomDialog(
      context,
      content: SpacedColumn(
        children: [
          ColorBgIconHeader(
            label: discount.productKey,
            icon: Icons.data_object_outlined,
            color: Colors.orangeAccent,
            trailing: InkWell(
              onTap: () => context.pop(),
              child: CircleAvatar(
                radius: 14,
                backgroundColor:
                    appColors.ms.whiteSwNero(context).withValues(alpha: 0.7),
                child: Icon(Icons.close_rounded,
                    size: 20, color: appColors.ms.neroSwWhite(context)),
              ),
            ),
          ),
          MetaRow(label: 'Product Key', value: discount.productKey),
          MetaRow(
            label: 'Discount',
            value: '₹${discount.discount.toString()}',
            isPrice: true,
          ),
        ],
      ),
    );
  }
}
