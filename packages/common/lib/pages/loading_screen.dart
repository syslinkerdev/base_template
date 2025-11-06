import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, this.isDialog = false});

  final bool isDialog;

  @override
  Widget build(BuildContext context) {
    if (isDialog) {
      return Container(
        color: appColors.ms.white(context),
        height: context.sizeOfHeight * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            gapW12,
            Text('Loading . . .', style: TextStyles.h7(context))
          ],
        ),
      );
    }
    return Container(
        color: appColors.ms.white(context),
        child: const Center(child: CircularProgressIndicator()));
  }
}
