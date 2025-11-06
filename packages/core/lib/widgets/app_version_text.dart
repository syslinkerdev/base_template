import 'package:flutter/material.dart';
import 'package:core/core.dart';

class AppVersionText extends StatelessWidget {
  const AppVersionText({super.key, this.textStyle});

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AppUtils.getAppVersion(),
      builder: (ctx, snapshot) {
        const loading = SizedBox(
          width: 24,
          height: 24,
          child: FittedBox(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return loading;
          case ConnectionState.done:
            return Center(
              child: Text(
                "${snapshot.data}v",
                style: (textStyle ?? TextStyles.h5Bold(context))
                    ?.copyWith(color:ColorX.instance.cS(context).surfaceTint),
              ),
            );
        }
      },
    );
  }
}
