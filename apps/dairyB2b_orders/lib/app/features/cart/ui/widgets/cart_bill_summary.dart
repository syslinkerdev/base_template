import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_helper.dart';

class CartBillSummary extends StatelessWidget {
  const CartBillSummary(
      {super.key, required this.ref, required this.serviceCharges});
  final WidgetRef ref;
  final double? serviceCharges;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: SpacedColumn(
        defaultHeight: 6.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ColorBgIconHeader(
              label: 'Bill Summary',
              icon: Icons.receipt,
              color: appColors.sc.teal),
          _billRow(context, 'Items Total',
              '₹${PriceTag.formatPrice(CH.total(ref))}'),
          if (serviceCharges != null) ...[
            _billRow(context, 'Service Charges',
                '+ ₹${PriceTag.formatPrice(serviceCharges!)}'),
          ],
          _billRow(context, 'Total Discounts',
              '− ₹${PriceTag.formatPrice(CH.totalDiscount(ref))}'),
          SimpleDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DashedUnderlineText(
                  text: 'Grand Total', style: TextStyles.h12Bold(context)),
              Row(
                children: [
                  PriceTag(
                      price: CH.total(ref) + (serviceCharges ?? 0),
                      cancelStyle: true),
                  gapW4,
                  Text('₹${PriceTag.formatPrice(CH.grandTotal(ref,serviceCharges))}',
                      style: TextStyles.h12Bold(context)
                          ?.copyWith(fontFamily: 'Roboto')),
                ],
              ),
            ],
          ),
          GradientSineWaveDivider(),
          Center(
            child: Text(
                'Saved ₹${PriceTag.formatPrice(CH.totalDiscount(ref))} on this order',
                style: TextStyles.h8Bold(context)
                    ?.copyWith(color: appColors.sc.teal, fontFamily: 'Roboto')),
          )
        ],
      ),
    );
  }

  Row _billRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DashedUnderlineText(text: label, style: TextStyles.h12Bold(context)),
        Text(value,
            style: TextStyles.h12Bold(context)?.copyWith(fontFamily: 'Roboto')),
      ],
    );
  }
}
