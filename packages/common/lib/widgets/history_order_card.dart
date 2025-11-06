import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

class HistoryOrderCard extends StatelessWidget {
  const HistoryOrderCard(
      {super.key, required this.orderDetails, this.doNotWantArrow = false});
  final OrderX orderDetails;
  final bool doNotWantArrow;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            // basic image and orderId
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 50,
                  decoration: BoxDecoration(
                      color: appColors.cS(context).primaryContainer,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "O-${orderDetails.deliveryDate.day}",
                      style: TextStyles.h8Bold(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                gapW8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(orderDetails.orderId,
                          style: TextStyles.h9Bold(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start),
                      StatusShow(
                          label: orderDetails.status.label,
                          icon: orderDetails.status.icon,
                          color: orderDetails.status.color)
                    ],
                  ),
                ),
              ],
            ),
            SimpleDivider(),
            // date and pricer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Delivery on ${DFU.ddMMyyyy(orderDetails.deliveryDate)}",
                    style: TextStyles.h13Bold(context)
                        ?.copyWith(color: appColors.ms.textBlack50(context)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹${PriceTag.formatPrice(orderDetails.totalPrice + orderDetails.serviceCharges)}',
                      style: TextStyles.h11Bold(context)
                          ?.copyWith(fontFamily: 'Roboto'),
                    ),
                    gapW2,
                    if (!doNotWantArrow)
                      Icon(
                        Icons.arrow_forward_ios,
                        size: context.sizeOfHeight * 0.017,
                        color: appColors.sc.grey500,
                      ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
