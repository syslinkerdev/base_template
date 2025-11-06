import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/common/widgets/slider_holder.dart';

class GlobalDisSlider extends HookConsumerWidget {
  const GlobalDisSlider({
    super.key,
    this.disValue,
    this.onChanged,
  });

  final double? disValue;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initDisValue = useMemoized(() => disValue);
    // initial discount state (prefill)
    final globDis = useState<double>(disValue ?? 0);

    // current dynamic max shown on slider (starts at 5 but will be adjusted on mount)
    final globDisMaxVal = useState<double>(5.0);

    // external ultimate cap (editable elsewhere). keep as state here for demo.
    final topMax = useState<double>(100.0);

    const double step = 0.5;
    const double minVal = 0.0;

    final int divisions =
        ((globDisMaxVal.value - minVal) / step).round().clamp(1, 1000000);

    // 1) RUN ONCE: compute initial globDisMaxVal based on initialDiscount
    useEffect(() {
      final init = (disValue ?? 0).clamp(0, topMax.value);

      double nextStep;
      if (init <= 5) {
        nextStep = 5;
      } else {
        // round up to multiple of 5, then give extra +5 breathing space
        final roundedUp = ((init / 5).ceil() * 5).toDouble();
        nextStep = roundedUp + 5;
      }

      // clamp by topMax
      globDisMaxVal.value = nextStep.clamp(0, topMax.value);

      // Ensure current discount does not exceed the new max (clamp it, don't reset to 0)
      if (globDis.value > globDisMaxVal.value) {
        globDis.value = globDisMaxVal.value;
      }

      return null;
    }, []); // empty deps -> runs only on mount

    // 2) React when topMax is changed later -> reset selected discount to 0 and reset initial max to min(5, topMax)
    final topMaxFirstRun = useRef(true);
    useEffect(() {
      if (topMaxFirstRun.value) {
        topMaxFirstRun.value = false;
        return null;
      }

      // Only reset if current discount is greater than initial discount
      if (globDis.value > (initDisValue ?? 0)) {
        globDis.value = 0;
      }
      globDisMaxVal.value = 5.clamp(0, topMax.value).toDouble();
      return null;
    }, [topMax.value]);

    return Column(
      children: [
        InkWell(
          onTap: () => DialogsX.showCustomDialog<int?>(
            context,
            content: SizedBox(
              width: context.sizeOfWidth,
              child: EditTopMaxContent(initTopMax: topMax.value),
            ),
          ).then(
            (newTopMax) {
              if (newTopMax != null) {
                topMax.value = newTopMax.toDouble();
              } else {
                return;
              }
            },
          ),
          child: Row(
            children: [
              CaptionText(
                title: (globDis.value) == 0
                    ? 'Global Discount'
                    : 'Global Discount ${PriceTag.formatPrice(globDis.value)}',
                isRequired: true,
              ),
              const Spacer(),
              Icon(Icons.edit,
                  size: 16, color: appColors.ms.textBlack50(context)),
              Text(
                'TopMax',
                style: TextStyles.h14Gray(context),
              ),
            ],
          ),
        ),
        gapH4,
        SliderHolder(
          leading: Text(
            '\u{20B9}',
            textAlign: TextAlign.end,
            style: TextStyles.h9Gray(context)?.copyWith(fontFamily: 'Roboto'),
          ),
          slider: Slider(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            min: minVal,
            max: globDisMaxVal.value,
            value: globDis.value.clamp(minVal, globDisMaxVal.value),
            divisions: divisions,
            label: formatStepValue(globDis.value),
            onChanged: (raw) {
              final snapped = ((raw - minVal) / step).round() * step + minVal;
              final snappedClamped = snapped.clamp(minVal, globDisMaxVal.value);

              globDis.value = double.parse(snappedClamped.toStringAsFixed(1));

              // call external callback
              onChanged?.call(globDis.value);

              // grow max if needed (capped by topMax)
              if (globDis.value >= globDisMaxVal.value &&
                  globDisMaxVal.value < topMax.value) {
                globDisMaxVal.value =
                    (globDisMaxVal.value + 5).clamp(0, topMax.value);
              }

              // shrink max if user moves much lower than current max
              else if (globDis.value < globDisMaxVal.value - 10 &&
                  globDisMaxVal.value > 5) {
                // Reduce the range so fine-tuning is easier, but keep at least 5
                globDisMaxVal.value =
                    (globDis.value + 5).clamp(5, topMax.value).toDouble();
              }
            },
          ),
          trailing: Text(
            formatStepValue(globDis.value),
            textAlign: TextAlign.center,
            style: TextStyles.h9(context),
          ),
        ),
      ],
    );
  }

  String formatStepValue(double v) {
    if ((v % 1) == 0) return v.toInt().toString();
    return v.toStringAsFixed(1);
  }
}

class EditTopMaxContent extends HookConsumerWidget {
  const EditTopMaxContent({super.key, required this.initTopMax});
  final double initTopMax;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topMaxCtrl =
        useTextEditingController(text: initTopMax.toInt().toString());
    return SpacedColumn(
      mainAxisSize: MainAxisSize.max,
      children: [
        ColorBgIconHeader(
          label: 'Update',
          icon: Icons.update,
          color: Colors.lightBlueAccent,
          trailing: InkWell(
            onTap: () => context.pop(),
            child: CircleAvatar(
              radius: 14,
              backgroundColor:
                  appColors.ms.whiteSwNero(context).withValues(alpha: 0.7),
              child: Icon(Icons.close_rounded,
                  size: 20, color: appColors.ms.neroSwWhite(context)),
            ),
          ),
        ),
        AppTextField(
            controller: topMaxCtrl,
            hintText: 'e.g. 150',
            isMandatory: true,
            inputType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            title: 'Top Max'),
        gapH12,
        ButtonX.primaryButton(
          context: context,
          label: 'update',
          icon: Icons.update,
          backgroundColor: Colors.lightBlueAccent,
          onPressed: () {
            if (topMaxCtrl.text.isNotEmpty) {
              final parsed = int.tryParse(topMaxCtrl.text);
              context.pop(parsed);
            } else {
              return;
            }
          },
        )
      ],
    );
  }
}
