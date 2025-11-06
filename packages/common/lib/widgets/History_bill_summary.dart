import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';

class HistoryBillSummary extends StatelessWidget {
  const HistoryBillSummary({super.key, required this.orderDetails});

  final OrderX orderDetails;

  @override
  Widget build(BuildContext context) {
    final itemsTotal = orderDetails.originalTotalPrice;
    final serviceCharges = orderDetails.serviceCharges;
    final discounts = orderDetails.originalTotalPrice - orderDetails.totalPrice;

    // 👇 Grand total formula
    final grandTotal = itemsTotal + serviceCharges - discounts;

    final formattedItems = PriceTag.formatPrice(itemsTotal);
    final formattedService = PriceTag.formatPrice(serviceCharges);
    final formattedDiscount = PriceTag.formatPrice(discounts);
    final formattedGrand = PriceTag.formatPrice(grandTotal);

    return ContainerX(
      margin: EdgeInsets.zero,
      child: SpacedColumn(
        defaultHeight: 6.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
            label: 'Bill Summary',
            icon: Icons.receipt,
            color: appColors.sc.teal,
          ),
          _billRow(context, 'Items Total', '₹$formattedItems'),
          _billRow(context, 'Service Charges', '+ ₹$formattedService'),
          _billRow(context, 'Total Discounts', '− ₹$formattedDiscount'),
          const SimpleDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DashedUnderlineText(
                text: 'Grand Total',
                style: TextStyles.h12Bold(context),
              ),
              Row(
                children: [
                  // Show original + service if there was a discount
                  PriceTag(
                      price: itemsTotal + serviceCharges, cancelStyle: true),
                  gapW4,
                  Text(
                    '₹$formattedGrand',
                    style: TextStyles.h12Bold(context)
                        ?.copyWith(fontFamily: 'Roboto'),
                  ),
                ],
              ),
            ],
          ),
          const GradientSineWaveDivider(),
          Center(
            child: Text(
              'Saved ₹$formattedDiscount on this order',
              style: TextStyles.h8Bold(context)
                  ?.copyWith(color: appColors.sc.teal, fontFamily: 'Roboto'),
            ),
          )
        ],
      ),
    );
  }

  Row _billRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DashedUnderlineText(
          text: label,
          style: TextStyles.h12Bold(context),
        ),
        Text(
          value,
          style: TextStyles.h12Bold(context)?.copyWith(fontFamily: 'Roboto'),
        ),
      ],
    );
  }
}
