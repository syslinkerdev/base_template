import 'dart:async';

import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeRemaining extends HookConsumerWidget {
  const TimeRemaining({super.key, this.message, this.messageTextColor});
  final String? message;
  final Color? messageTextColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderRules = ref.watch(orderRulesStreamProvider);
    final timer = useState<Timer?>(null);
    final remainingTime = useState<Duration>(Duration.zero);
    final isTimeOver = useState<bool>(false);

    void startTimer(DateTime start, DateTime end) {
      timer.value?.cancel();

      void updateTime() {
        final now = DateTime.now();
        final startToday =
            DateTime(now.year, now.month, now.day, start.hour, start.minute);
        final endToday =
            DateTime(now.year, now.month, now.day, end.hour, end.minute);

        if (now.isBefore(startToday)) {
          remainingTime.value = startToday.difference(now);
          isTimeOver.value = true;
        } else if (now.isAfter(endToday)) {
          remainingTime.value = Duration.zero;
          isTimeOver.value = true;
        } else {
          remainingTime.value = endToday.difference(now);
          isTimeOver.value = false;
        }
      }

      updateTime(); // initial call
      timer.value =
          Timer.periodic(const Duration(seconds: 1), (_) => updateTime());
    }

    useEffect(() {
      return () => timer.value?.cancel();
    }, []);

    return orderRules.when(
      data: (r) {
        final start = r?.orderStart;
        final end = r?.orderEnd;

        if (start == null || end == null) {
          return ContainerX(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Ordering time not configured.',
              style: TextStyles.h9Bold(context)
                  ?.copyWith(color: appColors.sc.mutedRed),
              textAlign: TextAlign.center,
            ),
          );
        }

        // Start the timer once we have the start and end time
        useEffect(() {
          startTimer(start, end);
          return null;
        }, [start, end]);

        return ContainerX(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
          child: Center(
            child: isTimeOver.value
                ? Text(
                    DateTime.now().isBefore(DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            start.hour,
                            start.minute))
                        ? 'Ordering starts soon at ${DFU.timeOnly12h(start)}'
                        : message ?? 'Ordering is closed for today. Thank you!',
                    style: TextStyles.h9Bold(context)?.copyWith(
                        color: messageTextColor ?? appColors.sc.mutedRed),
                    textAlign: TextAlign.center,
                  )
                : InkWell(
                    onTap: () async {
                      //  here we have to make
                    },
                    child: Row(
                      children: [
                        Text(
                          'Time Remaining',
                          style: TextStyles.h8Bold(context),
                        ),
                        Spacer(),
                        Text(
                          DFU.formatDuration(remainingTime.value),
                          style: TextStyles.h8Gray(context)?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
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
                  'Failed to load order rules: ${error.toString()}',
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
      loading: () => ShimmerX(
          width: context.sizeOfWidth, height: context.sizeOfHeight * 0.08),
    );
  }
}
