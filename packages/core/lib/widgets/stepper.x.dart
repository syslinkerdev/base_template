import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:core/widgets/step_x.dart';

class StepperX extends StatelessWidget {
  const StepperX({
    super.key,
    required this.labels,
    required this.currentPageIndex,
    required this.pageToStepIndex,
    this.hideLabels = false,
    this.onStepTapped,
    this.seedColor,
  });

  final List<String> labels; // Main steps (e.g. Step 1, Step 2, Step 3)
  final int currentPageIndex; // Actual current page (0-4)
  final List<int> pageToStepIndex; // Maps each page to its step index
  final bool hideLabels;
  final Function(int)? onStepTapped;
  final Color? seedColor;

  @override
  Widget build(BuildContext context) {
    assert(labels.isNotEmpty, 'Labels list cannot be empty');
    assert(pageToStepIndex.isNotEmpty, 'pageToStepIndex cannot be empty');

    return SizedBox(
      width: context.sizeOfWidth,
      height: hideLabels
          ? context.sizeOfHeight * 0.05
          : context.sizeOfHeight * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(labels.length, (index) {
          final isFirst = index == 0;
          final isLast = index == labels.length - 1;

          final totalPages = pageToStepIndex.where((i) => i == index).length;
          final completedPages = pageToStepIndex
              .asMap()
              .entries
              .where((e) => e.key <= currentPageIndex && e.value == index)
              .length;

          final progressRatio =
              totalPages > 0 ? completedPages / totalPages : 0.0;
          final point = progressRatio == 1.0;

          final beforeLineFilled =
              index > 0 && currentPageIndex >= pageToStepIndex.indexOf(index);
          final afterLineFilled =
              !isLast && currentPageIndex > pageToStepIndex.indexOf(index);

          return StepX(
            seedColor: seedColor,
            width: context.sizeOfWidth / labels.length * 0.8,
            label: hideLabels ? null : labels[index],
            isFirst: isFirst,
            isLast: isLast,
            point: point,
            beforeLine: beforeLineFilled,
            afterLine: afterLineFilled,
            onTap: () => onStepTapped?.call(index),
          );
        }),
      ),
    );
  }
}
