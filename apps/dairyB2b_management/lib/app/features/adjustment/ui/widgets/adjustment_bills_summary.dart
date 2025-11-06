import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_helper.dart';

class AdjustmentBillSummary extends StatelessWidget {
  const AdjustmentBillSummary(
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
              '₹${PriceTag.formatPrice(AH.total(ref))}'),
          if (serviceCharges != null) ...[
            _billRow(context, 'Service Charges',
                '+ ₹${PriceTag.formatPrice(serviceCharges!)}'),
          ],
          _billRow(context, 'Total Discounts',
              '− ₹${PriceTag.formatPrice(AH.totalDiscount(ref))}'),
          SimpleDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DashedUnderlineText(
                  text: 'Grand Total', style: TextStyles.h12Bold(context)),
              Row(
                children: [
                  PriceTag(
                      price: AH.total(ref) + (serviceCharges ?? 0),
                      cancelStyle: true),
                  gapW4,
                  Text('₹${PriceTag.formatPrice(AH.grandTotal(ref))}',
                      style: TextStyles.h12Bold(context)
                          ?.copyWith(fontFamily: 'Roboto')),
                ],
              ),
            ],
          ),
          GradientSineWaveDivider(),
          Center(
            child: Text(
                'Saved ₹${PriceTag.formatPrice(AH.totalDiscount(ref))} on this order',
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
