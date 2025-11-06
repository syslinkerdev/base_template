import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:core/widgets/stepper.x.dart';

StepperPageViewXCtr get stepper => StepperPageViewXCtr.instance;

class StepperPageViewXCtr {
  static final StepperPageViewXCtr instance = StepperPageViewXCtr._();

  late PageController controller;
  late int totalPages;
  final currentPageIndex = ValueNotifier<int>(0);

  StepperPageViewXCtr._(); // private constructor

  void init({required int total, PageController? externalController}) {
    totalPages = total;
    controller = externalController ?? PageController();
  }

  bool get isFirstPage => currentPageIndex.value == 0;
  bool get isLastPage => currentPageIndex.value == totalPages - 1;

  void nextPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    //print('📦 nextPage called');
    //print('📦 currentPageIndex: ${currentPageIndex.value}');
    //print('📦 totalPages: $totalPages');

    if (!isLastPage) {
      controller.nextPage(duration: duration, curve: curve);
      currentPageIndex.value += 1;
    } else {
      //print('⚠️ Already at last page');
    }
  }

  void previousPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    if (!isFirstPage) {
      controller.previousPage(duration: duration, curve: curve);
    }
  }

  void goToPage(
    int index, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    if (index >= 0 && index < totalPages) {
      controller.animateToPage(index, duration: duration, curve: curve);
      currentPageIndex.value = index;
    }
  }

  void dispose() {
    //debugPrint('🔁 Disposing StepperPageViewXCtr');
    controller.dispose();
    currentPageIndex.value = 0;
  }
}

class StepperPageViewX extends StatefulWidget {
  const StepperPageViewX({
    super.key,
    required this.labels,
    required this.pages,
    required this.pageToStepIndex,
    this.hideLabels = false,
    this.offDefaultNav = false,
    this.onPageValidation,
    this.skipError = false,
    this.offPageIndicator = false,
    this.seedColor,
  });

  final List<String> labels;
  final List<Widget> pages;
  final List<int> pageToStepIndex;
  final bool hideLabels;
  final bool offDefaultNav;
  final bool offPageIndicator;
  final bool skipError;
  final Future<bool> Function(int currentIndex)? onPageValidation;
  final Color? seedColor;

  @override
  State<StepperPageViewX> createState() => _StepperPageViewXState();
}

class _StepperPageViewXState extends State<StepperPageViewX> {
  @override
  void initState() {
    super.initState();
    final controller = PageController();
    stepper.init(total: widget.pages.length, externalController: controller);
  }

  @override
  void dispose() {
    stepper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.pages.length == widget.pageToStepIndex.length,
        'Each page must have a corresponding step index.');

    Future<void> navigateToPage(int newIndex) async {
      if (newIndex < stepper.currentPageIndex.value) {
        stepper.controller.jumpToPage(newIndex);
        stepper.currentPageIndex.value = newIndex;
        return;
      }
      if (widget.onPageValidation != null) {
        try {
          final isValid = await widget.onPageValidation!(newIndex);
          if (!isValid) {
            if (!widget.skipError) {
              showMessageSnackbar(
                context: context,
                type: SnackBarType.warning,
                message:
                    'Complete the ${stepper.currentPageIndex.value + 1} step first.',
              );
            }
            return;
          }
        } catch (e) {
          //print('Error during page validation: $e');
          return;
        }
      }
      stepper.controller.jumpToPage(newIndex);
      stepper.currentPageIndex.value = newIndex;
    }

    return Column(
      children: [
        SizedBox(
          height: context.sizeOfHeight * 0.08,
          child: ValueListenableBuilder<int>(
            valueListenable: stepper.currentPageIndex,
            builder: (context, currentIndex, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  if (widget.offDefaultNav)
                    Positioned(
                      left: 8,
                      child: InkWell(
                        onTap: currentIndex > 0
                            ? () => navigateToPage(currentIndex - 1)
                            : null,
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: currentIndex > 0
                              ? appColors.ms.black80(context)
                              : appColors.ms.black40(context),
                        ),
                      ),
                    ),
                  StepperX(
                    labels: widget.labels,
                    currentPageIndex: currentIndex,
                    pageToStepIndex: widget.pageToStepIndex,
                    hideLabels: widget.hideLabels,
                    seedColor: widget.seedColor,
                    onStepTapped: (stepIndex) {
                      if (!widget.offDefaultNav) {
                        final targetPage =
                            widget.pageToStepIndex.indexOf(stepIndex);
                        if (targetPage != -1) navigateToPage(targetPage);
                      }
                    },
                  ),
                  if (widget.offDefaultNav)
                    Positioned(
                      right: 8,
                      child: InkWell(
                        onTap: currentIndex < widget.pages.length - 1
                            ? () => navigateToPage(currentIndex + 1)
                            : null,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: currentIndex < widget.pages.length - 1
                              ? appColors.ms.black80(context)
                              : appColors.ms.black40(context),
                        ),
                      ),
                    ),
                  if (widget.offDefaultNav && !widget.offPageIndicator)
                    Positioned(
                      bottom: 0,
                      child: Text(
                        '${currentIndex + 1}/${widget.pages.length}',
                        style: TextStyles.h8Bold(context),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
        Expanded(
          child: PageView(
            controller: stepper.controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => stepper.currentPageIndex.value = index,
            children: widget.pages,
          ),
        ),
      ],
    );
  }
}

List<int> generatePageToStepIndex(List<int> stepCounts) {
  final result = <int>[];
  for (int i = 0; i < stepCounts.length; i++) {
    result.addAll(List.filled(stepCounts[i], i));
  }
  return result;
}
