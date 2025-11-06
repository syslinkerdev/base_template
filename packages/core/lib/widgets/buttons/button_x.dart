import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// A customizable button widget that supports various styles, loading states,
/// and icon placements.
class ButtonX extends HookWidget {
  /// The label text displayed on the button.
  final String label;

  /// The text style of the label.
  final TextStyle? labelStyle;

  /// The icon displayed on the button.
  final IconData? icon;

  /// The icon using Widget for more control displayed on the button.
  final Widget? iconAsWidget;

  /// The callback function to be executed when the button is pressed.
  final FutureOr<void> Function()? onPressed;

  /// The duration to simulate a loading state in milliseconds.
  final int? fakeLoadingDuration;

  /// Indicates whether the button is in a loading state.
  final bool loading;

  /// Determines whether the icon is placed before the label.
  final bool iconFirst;

  /// The main axis alignment of the button's content.
  final MainAxisAlignment flex;

  /// The background color of the button.
  final Color? backgroundColor;

  /// The color of the icon.
  final Color? iconColor;

  /// The color of the label.
  final Color? labelColor;

  /// The size of the icon.
  final double? iconSize;

  /// Indicates whether the button scales to fit its content.
  final bool scale;

  /// The height of the button.
  final double height;

  /// The gap between the icon and the label.
  final SizedBox gap;

  /// The shape of the button.
  final ShapeBorder? shape;

  /// The shape of the button.
  final bool? noAsyncLoading;

  /// The color of the Loading.
  final Color? loadingIconColor;

  /// Creates an [ButtonX] with customizable properties.
  const ButtonX(
      {super.key,
      required this.label,
      this.onPressed,
      this.icon,
      this.iconAsWidget,
      this.fakeLoadingDuration,
      this.loading = false,
      this.iconFirst = false,
      this.flex = MainAxisAlignment.center,
      this.backgroundColor,
      this.scale = false,
      this.height = -1,
      this.gap = gapW4,
      this.iconColor,
      this.labelColor,
      this.shape,
      this.iconSize,
      this.labelStyle,
      this.noAsyncLoading,
      this.loadingIconColor});

  /// Creates a primary styled [ButtonX].
  ButtonX.primaryButton({
    Key? key,
    required BuildContext context,
    required String label,
    IconData? icon,
    required FutureOr<void> Function()? onPressed,
    bool? loading,
    bool? noAsyncLoading,
    Color? labelColor,
    Color? backgroundColor,
    bool? iconFirst,
    MainAxisAlignment? flex,
    TextStyle? labelStyle,
    double? height,
    double? iconSize,
    SizedBox? gap,
  }) : this(
          key: key,
          label: label,
          icon: icon,
          iconFirst: iconFirst ?? true,
          iconSize: iconSize,
          flex: flex ?? MainAxisAlignment.center,
          labelColor: labelColor,
          onPressed: onPressed,
          loading: loading ?? false,
          noAsyncLoading: noAsyncLoading ?? false,
          scale: true,
          gap: gap ?? gapW4,
          height: height ?? context.sizeOfHeight * 0.056,
          labelStyle: labelStyle ?? TextStyles.h7(context),
          backgroundColor: backgroundColor ?? context.colorScheme.primary,
        );

  /// Creates a container styled [ButtonX].
  ButtonX.containerButton(
      {Key? key,
      required BuildContext context,
      required String label,
      TextStyle? labelStyle,
      Color? labelColor,
      double? borderRadius,
      double? buttonHeight,
      IconData? icon,
      Widget? iconAsWidget,
      double? iconSize,
      required FutureOr<void> Function()? onPressed,
      bool? loading,
      bool? noAsyncLoading,
      bool? iconFirst,
      MainAxisAlignment? flex,
      SizedBox? gap})
      : this(
          key: key,
          label: label,
          labelStyle: labelStyle,
          icon: icon,
          iconSize: iconSize,
          iconAsWidget: iconAsWidget,
          onPressed: onPressed,
          loading: loading ?? false,
          noAsyncLoading: noAsyncLoading ?? false,
          iconFirst: iconFirst ?? false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 21),
              side: BorderSide(
                  color: ColorX.instance.ms.greyTransparent20(context),
                  width: 1)),
          iconColor: ColorX.instance.ms.black(context),
          labelColor: labelColor ?? ColorX.instance.sc.mutedRed,
          height: buttonHeight ?? 51.5,
          flex: flex ?? MainAxisAlignment.start,
          gap: gap ?? gapW12,
          backgroundColor: ColorX.instance.shad.e30(context),
          scale: true,
        );

  /// Creates a outline styled [ButtonX].
  ButtonX.outlineButton({
    Key? key,
    required BuildContext context,
    required String label,
    IconData? icon,
    required FutureOr<void> Function()? onPressed,
    bool? loading,
    bool? noAsyncLoading,
    Color? labelColor,
    Color? iconColor,
    Color? loadingIconColor,
    Color? borderColor,
    TextStyle? labelStyle,
    bool? scale,
  }) : this(
          key: key,
          label: label,
          icon: icon,
          iconColor: iconColor ?? context.colorScheme.primary,
          loadingIconColor: loadingIconColor ?? context.colorScheme.primary,
          labelColor: labelColor ?? context.colorScheme.primary,
          iconFirst: true,
          onPressed: onPressed,
          loading: loading ?? false,
          noAsyncLoading: noAsyncLoading ?? false,
          scale: scale ?? true,
          height: context.sizeOfHeight * 0.056,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                  color: borderColor ?? context.colorScheme.primary, width: 2)),
          labelStyle: labelStyle ?? TextStyles.h7(context),
          backgroundColor: Colors.transparent,
        );

  /// Handles the button press by setting the loading state, executing the
  /// [onPressed] callback, and resetting the loading state after the
  /// specified [fakeLoadingDuration].
  void _handleButtonPress(ValueNotifier<bool> isLoading, bool isMounted,
      int? loadingDuration) async {
    if (onPressed != null) {
      noAsyncLoading == true ? isLoading.value = false : isLoading.value = true;
      try {
        await onPressed!();
        if (loadingDuration != null) {
          await Future.delayed(Duration(milliseconds: loadingDuration));
        }
      } catch (e) {
        // Handle any errors that occur during the onPressed function
        //print('Error: $e');
      } finally {
        if (isMounted) {
          isLoading.value = false;
        }
      }
    }
  }

  /// Returns the text style for the label, defaulting to a bold style if not
  /// provided.
  TextStyle _getTextStyle(BuildContext context) {
    final textStyle = labelStyle ??
        TextStyles.h8Bold(context)?.copyWith(color: labelColor) ??
        const TextStyle();
    return textStyle;
  }

  /// Calculates the width of the label text.
  double _calculateTextWidth(BuildContext context, TextStyle textStyle) {
    final textPainter = TextPainter(
      text: TextSpan(text: label, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  /// Calculates the width of the gap between the icon and the label.
  double _calculateGapWidth(Widget gap) {
    if (gap is SizedBox && gap.width != null) {
      return gap.width!;
    }
    return 4.0;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);
    final textStyle = _getTextStyle(context);
    final labelWidth = _calculateTextWidth(context, textStyle);
    final iconWidth =
        icon != null ? (iconSize ?? textStyle.fontSize ?? 24) : 0.0;
    final gapWidth = iconWidth == 0.0 ? 0.0 : _calculateGapWidth(gap);
    final totalWidth = labelWidth + iconWidth + gapWidth;

    // Adjusting content to support both icon and iconAsWidget
    Widget content = Row(
      mainAxisAlignment: flex,
      children: [
        if (iconFirst) ...[
          if (icon != null)
            Icon(icon,
                color: iconColor ?? ColorX.instance.ms.white(context),
                size: iconSize),
          if (iconAsWidget != null) ...[gap, iconAsWidget!],
          if (icon != null || iconAsWidget != null) gap,
          Text(label,
              style: textStyle.copyWith(
                  color: labelColor ?? ColorX.instance.ms.white(context))),
        ] else ...[
          Text(label,
              style: textStyle.copyWith(
                  color: labelColor ?? ColorX.instance.ms.white(context))),
          if (icon != null) ...[
            gap,
            Icon(icon,
                color: iconColor ?? ColorX.instance.ms.white(context),
                size: iconSize),
          ],
          if (iconAsWidget != null) ...[gap, iconAsWidget!],
        ],
      ],
    );

    return SizedBox(
      height: height == -1 ? context.sizeOfHeight * 0.042 : height,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        elevation: 0,
        disabledColor: backgroundColor?.withAlpha(120) ??
            context.colorScheme.primary.withAlpha(120),
        color: backgroundColor ?? context.colorScheme.primary.withAlpha(220),
        focusElevation: 0,
        highlightElevation: 0,
        onPressed: isLoading.value || loading || onPressed == null
            ? null
            : () => _handleButtonPress(
                isLoading, context.mounted, fakeLoadingDuration),
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
        child: isLoading.value || loading == true
            ? SizedBox(
                width: scale == false ? totalWidth : context.sizeOfWidth,
                child: Center(
                  child: SpinKitThreeBounce(
                    color:
                        loadingIconColor ?? ColorX.instance.ms.white(context),
                    size: 18, // Consider making this customizable
                  ),
                ),
              )
            : scale == false
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: content,
                  )
                : content,
      ),
    );
  }
}

// example button :
// ButtonX(
//   fakeLoadingDuration: 10000,
//   label: 'test',
//   // Doesn't load until you use fake loading
//   onPressed: () async {},
//   // If you provided a function with async-await, it will simulate loading.
//   // onPressed: () async {
//   //   await Future.delayed(const Duration(milliseconds: 300));
//   // },
//   // If you get an error, it will //print the error message in the console.
//   // onPressed: () async {
//   //   throw Exception('Test error');
//   // },
//   // If you don't use onPressed, the button will appear disabled with a lighter color.
//   scale: true,
//   labelStyle: TextStyles.h6Bold(context),
//   flex: MainAxisAlignment.spaceBetween,
//   iconFirst: true,
//   gap: gapW16,
//   icon: Icons.edit,
//   backgroundColor: appColors.approved,
//   height: 100,
//   loading: false,
//   shape: UnderlineInputBorder(),
//   iconColor: appColors.cerulean,
//   iconSize: 40,
//   labelColor: appColors.blueBell,
// ), now how is my flutter button
