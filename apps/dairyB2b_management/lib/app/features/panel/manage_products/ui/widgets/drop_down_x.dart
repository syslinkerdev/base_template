import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DropDownX<T> extends StatelessWidget {
  final String? title;
  final String? hintText;
  final String? labelText;
  final bool isMandatory;
  final List<T> items;
  final T? value;
  final String Function(T) itemLabel;
  final void Function(T?) onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double contentPaddingHorizontal;
  final double contentPaddingVertical;
  final TextStyle? labelAndHintStyle;
  final Color? iconColor;
  final Color? borderColor;
  final double? borderWidth;

  const DropDownX({
    super.key,
    this.title,
    this.hintText,
    this.labelText,
    this.isMandatory = false,
    required this.items,
    required this.value,
    required this.itemLabel,
    required this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPaddingHorizontal = 16,
    this.contentPaddingVertical = 5,
    this.labelAndHintStyle,
    this.iconColor,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle =
        labelAndHintStyle ?? TextStyles.h8Bold(context);
    final TextStyle? textStyleForHint =
        labelAndHintStyle?.copyWith(color: appColors.ms.textBlack50(context)) ??
            TextStyles.h8Bold(context)
                ?.copyWith(color: appColors.ms.textBlack50(context));

    final border = OutlineInputBorder(
      borderSide: BorderSide(
          color: borderColor ?? appColors.ms.borderColor(context),
          width: borderWidth ?? 1.6),
      borderRadius: BorderRadius.circular(12),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.containsValidValue) ...[
          CaptionText(title: title.valueOrEmpty, isRequired: isMandatory),
          gapH4,
        ],
        InputDecorator(
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            hintStyle: textStyleForHint,
            labelStyle: textStyle,
            contentPadding: EdgeInsets.symmetric(
              horizontal: contentPaddingHorizontal,
              vertical: contentPaddingVertical,
            ).copyWith(right: contentPaddingHorizontal / 2),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              padding: EdgeInsets.zero,
              underline: const SizedBox.shrink(),
              isExpanded: true,
              iconDisabledColor: iconColor,
              iconEnabledColor: iconColor,
              value: value,
              items: items
                  .map((item) => DropdownMenuItem<T>(
                        value: item,
                        child: Text(itemLabel(item)),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
