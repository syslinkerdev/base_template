import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class TimeSelectionField extends HookConsumerWidget {
  const TimeSelectionField({
    super.key,
    this.labelText,
    this.title,
    required this.onTimeSelected,
    this.beforeShowTimePickerOpen,
    this.initialTime,
    this.readOnly = false,
    this.isMandatory = false,
    this.hintText,
    this.suffixIcon = const Icon(Icons.access_time),
    this.isRequired = false,
  });

  final String? labelText;
  final String? title;
  final DateTime? initialTime;
  final bool readOnly;
  final bool isMandatory;
  final bool Function(DateTime time) onTimeSelected;
  final bool Function()? beforeShowTimePickerOpen;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isRequired;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = initialTime ?? DateTime.now();
    final controller = useTextEditingController(
      text: DateFormat('hh:mm').format(initial),
    );

    final selectedTime = useState<TimeOfDay?>(
      TimeOfDay.fromDateTime(initial),
    );
    final selectedAmPm = useState<String?>(
      selectedTime.value?.period == DayPeriod.am ? ' AM' : ' PM',
    );

    void showTimePickerX() {
      showTimePicker(
        context: context,
        initialTime: selectedTime.value ?? TimeOfDay.now(),
      ).then((value) {
        if (value != null) {
          final now = DateTime.now();
          final pickedDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            value.hour,
            value.minute,
          );

          final accepted = onTimeSelected(pickedDateTime);

          if (accepted) {
            selectedTime.value = value;
            controller.text = DateFormat('hh:mm').format(pickedDateTime);
            selectedAmPm.value = value.period == DayPeriod.am ? ' AM' : ' PM';
          }
        }
      });
    }

    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      defaultHeight: 4.0,
      children: [
        if (title.containsValidValue) ...[
          CaptionText(title: title.valueOrEmpty, isRequired: isMandatory),
        ],
        TextField(
          onTap: () {
            if (readOnly) return;

            final canOpenPicker = beforeShowTimePickerOpen?.call() ?? true;

            if (canOpenPicker) {
              showTimePickerX();
            }
          },
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            contentPadding: const EdgeInsets.all(16.0),
            counterText: '',
            filled: readOnly,
            fillColor: appColors.ms.readOnly(context),
            suffixIcon: selectedAmPm.value.isNotNull
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedAmPm.value ?? '--',
                      ),
                    ],
                  )
                : suffixIcon,
          ),
          textInputAction: TextInputAction.done,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          textCapitalization: TextCapitalization.none,
          readOnly: true,
          autocorrect: false,
        ),
      ],
    );
  }
}
