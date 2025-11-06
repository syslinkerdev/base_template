import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_assets/app_images.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    this.title,
    this.content,
    this.widgetContent,
    this.defaultButtonText = 'Okay',
    this.cancelButtonText = 'Cancel',
    this.defaultButtonLoading = false,
    required this.defaultOnPressed,
    this.cancelOnPressed,
    required this.dialogType,
    this.backgroundColor,
    this.imagePath,
    this.padding = const EdgeInsets.all(24),
    this.margin = const EdgeInsets.all(24),
    this.noImage = false,
    this.dialogTheme,
    this.customDialog = false,
  });
  final String? title;
  final String? content;
  final Widget? widgetContent;
  final String defaultButtonText;
  final bool? defaultButtonLoading;
  final String cancelButtonText;
  final String? imagePath;
  final VoidCallback? defaultOnPressed;
  final VoidCallback? cancelOnPressed;
  final DialogType dialogType;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  /// If you don't want any icon or image, you toggle it to true.
  final bool noImage;
  final Color? dialogTheme;
  final bool customDialog;

  @override
  Widget build(BuildContext context) {
    Color backgroundColorX =
        backgroundColor ?? ColorX.instance.shad.eBright(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 340),
      margin: dialogType == DialogType.custom ? EdgeInsets.all(12) : margin,
      padding: dialogType == DialogType.custom ? EdgeInsets.all(12) : padding,
      decoration: BoxDecoration(
        color: backgroundColorX,
        borderRadius: BorderRadius.circular(16),
      ),
      child: customDialog
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...[widgetContent!],
              ],
            )
          : SpacedColumn(
              defaultHeight: 12,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!noImage) ...[
                  sysImages.info.toWidget(
                      width: 84,
                      height: 84,
                      color: imagePath == null
                          ? dialogTheme ?? dialogType.toColor()
                          : null)
                ],
                if (title.containsValidValue) ...[
                  Align(
                    alignment:
                        noImage == true ? Alignment.topLeft : Alignment.center,
                    child: Text(
                      title.valueOrEmpty,
                      style: TextStyles.h5Bold(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                if (content != null && widgetContent == null) ...[
                  Text(
                    content!,
                    style: TextStyles.h7(context),
                    textAlign: TextAlign.center,
                  ),
                ],
                if (content == null && widgetContent != null) ...[
                  widgetContent!,
                ],
                if (cancelOnPressed != null) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ButtonX(
                          scale: true,
                          height: context.sizeOfHeight * 0.052,
                          label: cancelButtonText,
                          onPressed: cancelOnPressed != null
                              ? () => cancelOnPressed?.call()
                              : () => context.exit(false),
                          backgroundColor:
                              ColorX.instance.ms.greyTransparent80(context),
                          labelColor: ColorX.instance.sc.whiteS,
                          labelStyle: TextStyles.h8Bold(context),
                        ),
                      ),
                      gapW12,
                      Expanded(
                        flex: 1,
                        child: ButtonX(
                          scale: true,
                          height: context.sizeOfHeight * 0.052,
                          labelColor: ColorX.instance.sc.whiteS,
                          labelStyle: TextStyles.h8Bold(context),
                          label: defaultButtonText,
                          loading: defaultButtonLoading ?? false,
                          backgroundColor: dialogTheme ?? dialogType.toColor(),
                          onPressed: defaultOnPressed != null
                              ? () => defaultOnPressed?.call()
                              : () => context.exit(true),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  ButtonX.primaryButton(
                    context: context,
                    label: defaultButtonText,
                    labelColor: ColorX.instance.sc.whiteS,
                    backgroundColor: dialogTheme ?? dialogType.toColor(),
                    onPressed: defaultOnPressed != null
                        ? () => defaultOnPressed?.call()
                        : () => context.exit(true),
                    loading: defaultButtonLoading ?? false,
                  )
                ],
              ],
            ),
    );
  }
}
