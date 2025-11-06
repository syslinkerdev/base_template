import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

class LogsShow extends StatelessWidget {
  const LogsShow({super.key, this.logs});
  final List<String>? logs;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: EdgeInsets.zero,
      child: SpacedColumn(
        defaultHeight: 6.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorBgIconHeader(
              label: 'Order Logs',
              icon: Icons.auto_fix_high_rounded,
              color: Colors.amberAccent.shade700),
          if (logs != null && logs!.isNotEmpty)
            ...logs!.map(
              (note) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyles.h10(context)),
                    Expanded(
                      child: Text(note, style: TextStyles.h10Gray(context)),
                    ),
                  ],
                ),
              ),
            ),
          if (logs == null || logs!.isEmpty)
            Center(
              child: Text('No notes available.',
                  style: TextStyles.h10Gray(context)),
            ),
        ],
      ),
    );
  }
}
