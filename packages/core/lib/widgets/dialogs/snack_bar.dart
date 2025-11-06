import 'package:flutter/material.dart';
import 'package:core/core.dart';

// Function to show a simple message snackbar
void showMessageSnackbar({
  required BuildContext context,
  required String message,
  SnackBarType? type,
  Duration duration = const Duration(seconds: 2),
  int maxLines = 1,
}) {
  final snackBar = buildSnackBar(
    context: context,
    message: message,
    type: type ?? SnackBarType.info,
    duration: duration,
    maxLines: maxLines,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Function to show a snackbar with an action button
void showActionSnackbar({
  required BuildContext context,
  required String message,
  required String actionLabel,
  required VoidCallback onAction,
  SnackBarType? type,
  Duration duration = const Duration(seconds: 3),
  int maxLines = 1,
}) {
  final snackBar = buildSnackBar(
    context: context,
    message: message,
    type: type ?? SnackBarType.info,
    duration: duration,
    maxLines: maxLines,
    actionLabel: actionLabel,
    onAction: onAction,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

enum SnackBarType {
  info,
  success,
  warning,
  error,
  loading,
}

// Common function to create a base snackbar widget
SnackBar buildSnackBar({
  required BuildContext context,
  required String message,
  SnackBarType type = SnackBarType.info,
  Duration duration = const Duration(seconds: 2),
  int maxLines = 1,
  String? actionLabel,
  VoidCallback? onAction,
}) {
  return SnackBar(
    backgroundColor: type == SnackBarType.error
        ? ColorX.instance.sc.error
        : ColorX.instance.sc.nero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 70.0),
    behavior: SnackBarBehavior.floating,
    duration: duration,
    content: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: type == SnackBarType.error
              ? ColorX.instance.sc.whiteS
              : _snackbarColor(type: type),
          child: type == SnackBarType.loading
              ? Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorX.instance.sc.whiteS,
                    ),
                  ),
                )
              : Icon(
                  _snackbarIcons(type: type),
                  color: type == SnackBarType.error
                      ? ColorX.instance.sc.error
                      : ColorX.instance.sc.whiteS,
                ),
        ),
        gapW8,
        Expanded(
          child: Text(
            message,
            style: message.length >= 35
                ? TextStyles.h10(context)
                    ?.copyWith(color: ColorX.instance.sc.whiteS)
                : TextStyles.h9(context)
                    ?.copyWith(color: ColorX.instance.sc.whiteS),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (actionLabel != null &&
            onAction != null &&
            type != SnackBarType.loading) ...[
          ButtonX(
            label: actionLabel,
            onPressed: onAction,
            gap: const SizedBox.shrink(),
          )
        ],
        gapW8,
        if (type != SnackBarType.loading) // Don't show close button for loading
          InkWell(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: Icon(Icons.close, color: ColorX.instance.sc.whiteS),
          )
      ],
    ),
  );
}

// Update color helper to handle loading type
Color _snackbarColor({required SnackBarType type}) {
  switch (type) {
    case SnackBarType.info:
      return ColorX.instance.sc.normal;
    case SnackBarType.success:
      return ColorX.instance.sc.heartChakra;
    case SnackBarType.warning:
      return ColorX.instance.sc.warning;
    case SnackBarType.error:
      return ColorX.instance.sc.error;
    case SnackBarType.loading:
      return ColorX.instance.sc.normal; // choose your loading bg color
  }
}

// Update icon helper to handle loading type
IconData _snackbarIcons({required SnackBarType type}) {
  switch (type) {
    case SnackBarType.info:
      return Icons.info_outline;
    case SnackBarType.success:
      return Icons.done;
    case SnackBarType.warning:
      return Icons.warning_amber_outlined;
    case SnackBarType.error:
      return Icons.error_outline;
    case SnackBarType.loading:
      return Icons.hourglass_empty; // fallback icon, not actually used
  }
}
