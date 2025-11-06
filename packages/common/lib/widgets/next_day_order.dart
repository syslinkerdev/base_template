import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo/repo.dart';

class NextDayOrder extends HookConsumerWidget {
  const NextDayOrder({super.key, required this.uId, required this.onPress});
  final String uId;
  final void Function(bool isTodaysOrderExist) onPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doesOrderExistForToday =
        ref.watch(doesOrderExistForNextDayProvider(uId: uId));
    final tomorrow = DFU.nextDay();
    final dateStr = DFU.ddMMyyyy(tomorrow);
    return doesOrderExistForToday.when(
      data: (isTodaysOrderExist) => InkWell(
        onTap: () => onPress(isTodaysOrderExist),
        child: ContainerX(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorBgIcon(
                        icon: isTodaysOrderExist
                            ? Icons.check_circle_outline
                            : Icons.schedule,
                        color: isTodaysOrderExist
                            ? appColors.sc.heartChakra
                            : appColors.sc.mutedRed),
                    gapW12,
                    Text(
                        isTodaysOrderExist
                            ? '$dateStr ORDER'
                            : 'Order now, rest easy later!',
                        style: TextStyles.h8Gray(context)
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                if (isTodaysOrderExist)
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: appColors.ms.textBlack50(context))
              ],
            )),
      ),
      error: (error, stackTrace) => ContainerX(
        child: Center(
          child: Row(
            children: [
              Icon(Icons.error_outline,
                  size: context.sizeOfHeight * 0.03,
                  color: appColors.sc.grey650),
              gapW20,
              Expanded(
                child: Text(
                  'Failed to load doesOrderExistForToday: ${error.toString()}',
                  style: TextStyles.h8(context)
                      ?.copyWith(color: appColors.sc.grey700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => ShimmerX(width: context.sizeOfWidth, height: 58),
    );
  }
}
