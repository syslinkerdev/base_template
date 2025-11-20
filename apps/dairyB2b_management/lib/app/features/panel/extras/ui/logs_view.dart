import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';

class LogsView extends HookConsumerWidget {
  const LogsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(fetchLogListProvider);
    return ScaffoldX(
        wantLeading: true,
        title: 'Logs',
        appBarActions: [
          logsAsync.maybeWhen(
            error: (error, stackTrace) {
              // print(error.toString());
              return SizedBox();
            },
            orElse: () => SizedBox(),
            data: (logs) => Row(
              children: [
                Text('${logs.length}', style: TextStyles.h8Gray(context)),
                Icon(Icons.history_edu_rounded,
                    color: TextStyles.h8Gray(context)?.color,
                    size: TextStyles.h8Gray(context)?.fontSize)
              ],
            ),
          ),
          gapW16
        ],
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: logsAsync.when(
              data: (logs) {
                if (logs.isEmpty) {
                  return _buildEmptyState(context);
                }
                return SingleChildScrollView(
                  child: DynamicList<LogModel>(
                      items: logs,
                      physics: const NeverScrollableScrollPhysics(),
                      onSelect: (_) {},
                      itemBuilder: (context, log, _) => _LogCard(log: log)),
                );
              },
              error: (error, stackTrace) =>
                  ErrorScreen(error: error, onRetry: () => _refresh(ref: ref)),
              loading: () => _buildShimmerLoading(context),
            )));
  }

  static Future<void> _refresh({required WidgetRef ref}) async =>
      await Future.wait([ref.refresh(fetchLogListProvider.future)]);

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliersView = [0.2, 0.2, 0.2, 0.2];
    return SingleChildScrollView(
      child: SpacedColumn(
        children: heightMultipliersView
            .map((h) => ShimmerX(
                  width: context.sizeOfWidth,
                  height: context.sizeOfHeight * h,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_edu_rounded,
              size: context.sizeOfHeight * 0.12, color: appColors.sc.grey650),
          gapH20,
          Text('No Logs Found',
              textAlign: TextAlign.center, style: TextStyles.h8Gray(context)),
        ],
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  final LogModel log;
  const _LogCard({required this.log});

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Log header (type + time)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(log.type.name.captilizeName,
                  style: TextStyles.h8Bold(context)),
              Text(DFU.ddMMyyyy(log.createdAt),
                  style: TextStyles.h10Gray(context)),
            ],
          ),

          // 🔹 Main message
          Text(log.message, style: TextStyles.h9(context)),

          if (log.userName != null) ...[
            Text('By: ${log.userName} (${log.userRole?.name ?? "-"})',
                style: TextStyles.h10Gray(context)),
          ],

          if (log.route != null)
            Text('Route: ${log.route!}', style: TextStyles.h10Gray(context)),

          // 🔹 Show metadata dynamically
          if (log.metadata != null && log.metadata!.isNotEmpty) ...[
            SimpleDivider(),
            Text('Metadata:', style: TextStyles.h9Bold(context)),
            _MetadataView(metadata: log.metadata!),
          ],
        ],
      ),
    );
  }
}

class _MetadataView extends StatelessWidget {
  final Map<String, dynamic> metadata;
  const _MetadataView({required this.metadata});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: metadata.entries.map((entry) {
        final value = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text('${entry.key}: ${_stringify(value)}',
              style: TextStyles.h10Gray(context)),
        );
      }).toList(),
    );
  }

  String _stringify(dynamic value) {
    if (value is Map) return value.toString();
    if (value is List) return value.join(', ');
    return value.toString();
  }
}
