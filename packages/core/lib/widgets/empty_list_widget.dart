import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:system_assets/app_images.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    required this.emptyText,
    this.title = 'REFRESH',
    this.onRefresh,
  });

  final String emptyText;
  final String title;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpacedColumn(
        margin: const EdgeInsets.all(12.0),
        defaultHeight: 18.0,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          sysImages.emptySearch.toWidget(height: 120, width: 120),
          Text(emptyText, style: context.textTheme.titleMedium),
          if (onRefresh.isNotNull)
            ButtonX(
              fakeLoadingDuration: 3000,
              label: title,
              onPressed: onRefresh,
            ),
        ],
      ),
    );
  }
}
