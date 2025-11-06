import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_assets/icon_x.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required this.logo});
  final IconX logo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: logo.toWidget(height: context.sizeOfHeight * 0.3),
              ),
            ),
            Text(AppEnv.companyName, style: TextStyles.h6Bold(context)),
          ],
        ),
      ),
    );
  }
}
