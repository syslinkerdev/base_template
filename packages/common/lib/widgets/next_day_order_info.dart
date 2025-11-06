import 'package:core/core.dart';
import 'package:flutter/material.dart';

class NextDayOrderInfo extends StatelessWidget {
  const NextDayOrderInfo({super.key, this.forManagement = false});
  final bool forManagement;

  @override
  Widget build(BuildContext context) {
    final tomorrow = DFU.nextDay();
    final dateStr = DFU.ddMMyyyy(tomorrow);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: appColors.shad.e30(context),
        border: Border(
          left: BorderSide(
              color: context.colorScheme.primary, width: 3), // strip line
        ),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          forManagement
              ? "You are managing orders for $dateStr."
              : "You are placing order for $dateStr.",
          style: TextStyles.h15(context)?.copyWith(
              fontStyle: FontStyle.italic,
              color: appColors.cS(context).primary),
        ),
      ),
    );
  }
}
