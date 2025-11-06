import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_assets/app_images.dart';

class ErrorScreen extends StatelessWidget {
  final dynamic error;
  final void Function()? onRetry;
  final bool isDialog;

  const ErrorScreen({
    super.key,
    required this.error,
    required this.onRetry,
    this.isDialog = false,
  });

  String getErrorTitle() {
    if (error is AppException) {
      return (error as AppException).title;
    } else {
      return 'Oops!';
    }
  }

  String getErrorMessage() {
    if (error is AppException) {
      return (error as AppException).message;
    } else {
      return error.toString();
    }
  }

  Widget getImage({required double height, required double width}) {
    if (error is AppException &&
        (error as AppException).originalException == ExceptionType.internet) {
      return sysImages.noConnection.toWidget(height: height, width: width);
    } else {
      return sysImages.internalError.toWidget(height: height, width: width);
    }
  }

  IconData getIcon() {
    if (error is AppException &&
        (error as AppException).originalException == ExceptionType.internet) {
      return Icons.wifi_tethering_error_rounded;
    } else {
      return Icons.nearby_error_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: isDialog == true ? context.sizeOfHeight * 0.2 : null,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      color: appColors.ms.white(context),
      child: SpacedColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        defaultHeight: context.sizeOfHeight * 0.02,
        children: [
          if (isDialog == false) ...[
            getImage(
                height: context.sizeOfHeight * 0.34,
                width: context.sizeOfWidth * 0.34),
            Text(
              getErrorTitle(),
              style: TextStyles.h6Bold(context),
              textAlign: TextAlign.center,
            ),
          ],
          Text(
            getErrorMessage(),
            style: TextStyles.h8Gray(context),
            textAlign: TextAlign.center,
          ),
          ButtonX(
            fakeLoadingDuration: 200,
            iconFirst: true,
            label: 'TRY AGAIN',
            icon: getIcon(),
            onPressed: () async {
              final internetCheck = await isNotConnected();
              if (onRetry != null && internetCheck == false) {
                onRetry!();
              } else {
                if (context.mounted) {
                  showMessageSnackbar(
                    context: context,
                    message: getErrorTitle(),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
