import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Rules extends HookConsumerWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rules = ref.watch(orderRulesStreamProvider);
    final rulesUpdate = ref.read(orderRulesXProvider.notifier);
    final rulesLoading = ref.watch(orderRulesXProvider).isLoading;

    return ScaffoldX(
      wantLeading: true,
      title: 'Rules',
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: rules.when(
                data: (r) {
                  final now = DateTime.now();
                  final startState =
                      useState<DateTime?>(r?.todayEffectiveOrderStart);
                  final endState =
                      useState<DateTime?>(r?.todayEffectiveOrderEnd);
                  final defaultStart = r?.todayDefaultOrderStart;
                  final defaultEnd = r?.todayDefaultOrderEnd;

                  String adjustmentFor(
                      DateTime? current, DateTime? original, String label) {
                    //print('$current ---- $original ---- $label');
                    if (current == null || original == null) return '';
                    final diff = current.difference(original);
                    final minutes = diff.inMinutes;
                    if (minutes == 0) return '';
                    final sign = minutes > 0 ? '+' : '-';
                    final hoursPart = (minutes ~/ 60).abs();
                    final minsPart = (minutes % 60).abs();
                    final hrs = hoursPart > 0 ? '${hoursPart}h ' : '';
                    final mins = minsPart > 0 ? '${minsPart}m' : '';
                    return '$label adjusted: $sign$hrs$mins'.trim();
                  }

                  final startAdjustment = adjustmentFor(
                    startState.value,
                    defaultStart,
                    'Order Start',
                  );

                  final endAdjustment = adjustmentFor(
                    endState.value,
                    defaultEnd,
                    'Order End',
                  );
                  final timeDiff =
                      endState.value != null && startState.value != null
                          ? endState.value!.difference(startState.value!)
                          : null;
                  return SpacedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimeSelectionField(
                        title: 'Order Start',
                        initialTime: startState.value,
                        beforeShowTimePickerOpen: () {
                          final currentStart = startState.value;
                          if (currentStart == null) return false;

                          if (now.isBefore(currentStart)) {
                            return true;
                          } else {
                            showMessageSnackbar(
                              context: context,
                              message: 'Order Start time already passed',
                              maxLines: 2,
                            );
                            return false;
                          }
                        },
                        onTimeSelected: (DateTime selectedTime) {
                          startState.value = selectedTime;
                          return true;
                        },
                      ),
                      TimeSelectionField(
                        title: 'Order End',
                        initialTime: endState.value,
                        beforeShowTimePickerOpen: () {
                          final currentEnd = endState.value;

                          if (currentEnd != null && now.isAfter(currentEnd)) {
                            showMessageSnackbar(
                              context: context,
                              message: 'You are extending the end time',
                              maxLines: 2,
                            );
                          }
                          return true;
                        },
                        onTimeSelected: (DateTime selectedTime) {
                          final currentEnd = endState.value;
                          final currentStart = startState.value;
                          final now = DateTime.now();

                          // ✅ 1) If already passed → can’t backdate
                          if (currentEnd != null && now.isAfter(currentEnd)) {
                            if (selectedTime.isBefore(currentEnd)) {
                              showMessageSnackbar(
                                context: context,
                                message:
                                    'You can only extend Order End forward, not backward!',
                                maxLines: 2,
                              );
                              return false;
                            }
                          }

                          // ✅ 2) End can’t be before start
                          if (currentStart != null &&
                              selectedTime.isBefore(currentStart)) {
                            showMessageSnackbar(
                              context: context,
                              message:
                                  'Order End cannot be before Order Start!',
                              maxLines: 2,
                            );
                            return false;
                          }

                          // ✅ 3) End can’t be set in the past
                          if (selectedTime.isBefore(now)) {
                            showMessageSnackbar(
                              context: context,
                              message: 'Order End cannot be set in the past!',
                              maxLines: 2,
                            );
                            return false;
                          }

                          endState.value = selectedTime;
                          return true;
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (timeDiff != null)
                                Text(
                                  "Duration: ${timeDiff.inHours}h ${timeDiff.inMinutes % 60}m",
                                  style: TextStyles.h8Gray(context),
                                ),
                              if (startAdjustment.isNotEmpty)
                                Text(
                                  startAdjustment,
                                  style: TextStyles.h8Gray(context)
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              if (endAdjustment.isNotEmpty)
                                Text(
                                  endAdjustment,
                                  style: TextStyles.h8Gray(context)
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonX.outlineButton(
                              context: context,
                              noAsyncLoading: true,
                              label: 'Today Only',
                              icon: Icons.today_outlined,
                              labelStyle: TextStyles.h8(context)
                                  ?.copyWith(fontSize: 18),
                              onPressed: () async =>
                                  await DialogsX.askForConfirmation<bool>(
                                context,
                                dialogTheme: appColors.sc.cerulean,
                                title: 'Confirm Update',
                                content:
                                    'Are you sure you want to update today\'s Order Start & End times?',
                                cancelBtnText: 'Cancel',
                                confirmBtnText: 'Update',
                                onConfirm: (ctx) => ctx.close(true),
                              ).then((onConfirm) async {
                                if (onConfirm == true) {
                                  await rulesUpdate.updateTodayTimes(
                                    newStart: startState.value,
                                    newEnd: endState.value,
                                    rules: r ?? OrderRules.empty(),
                                  );
                                  showMessageSnackbar(
                                    context: context,
                                    message: 'Today\'s Order Rules updated!',
                                    type: SnackBarType.success,
                                  );
                                  context.close();
                                }
                              }),
                            ),
                          ),
                          gapW4,
                          Expanded(
                            child: ButtonX.primaryButton(
                              context: context,
                              noAsyncLoading: true,
                              label: 'Save Default',
                              icon: Icons.save_outlined,
                              labelStyle: TextStyles.h8(context)
                                  ?.copyWith(fontSize: 18),
                              onPressed: () async =>
                                  await DialogsX.askForConfirmation<bool>(
                                context,
                                dialogTheme: appColors.sc.deepWater,
                                title: 'Confirm Permanent Update',
                                content:
                                    'Are you sure you want to permanently update default Order Start & End times?',
                                cancelBtnText: 'Cancel',
                                confirmBtnText: 'Save',
                                onConfirm: (ctx) => ctx.close(true),
                              ).then((onConfirm) async {
                                if (onConfirm == true) {
                                  await rulesUpdate.updatePermanentTimes(
                                    newStart: startState.value,
                                    newEnd: endState.value,
                                    rules: r ?? OrderRules.empty(),
                                  );
                                  showMessageSnackbar(
                                    context: context,
                                    message: 'Default Order Rules saved!',
                                    type: SnackBarType.success,
                                  );
                                  context.close();
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => ErrorScreen(
                  error: error,
                  onRetry: () async => await refresh(ref: ref),
                ),
                loading: () => _buildShimmerLoading(context),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: rulesLoading
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: appColors.ms.transparent80(context),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink(key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return SpacedColumn(
      children: [
        ShimmerX(
            width: context.sizeOfWidth * 0.25,
            height: context.sizeOfHeight * 0.02,
            alignment: Alignment.topLeft),
        ShimmerX(
            width: context.sizeOfWidth, height: context.sizeOfHeight * 0.06),
        ShimmerX(
            width: context.sizeOfWidth * 0.25,
            height: context.sizeOfHeight * 0.02,
            alignment: Alignment.topLeft),
        ShimmerX(
            width: context.sizeOfWidth, height: context.sizeOfHeight * 0.06)
      ],
    );
  }

  static Future<void> refresh({required WidgetRef ref}) async =>
      ref.refresh(orderRulesStreamProvider.future);
}
