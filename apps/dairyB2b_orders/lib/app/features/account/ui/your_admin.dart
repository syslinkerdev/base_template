import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repo/repo.dart';

class YourAdmin extends ConsumerWidget {
  const YourAdmin({super.key, required this.adminUid});
  final String adminUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminFetcher = ref.watch(fetchUserProvider(documentId: adminUid));
    return ScaffoldX(
      title: 'Your Admin',
      titleCenter: true,
      wantLeading: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: adminFetcher.when(
            data: (admin) {
              // print('admin ------- $admin');
              if (admin == null) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: context.sizeOfHeight * 0.15),
                      Icon(Icons.block,
                          size: context.sizeOfHeight * 0.12,
                          color: appColors.sc.grey650),
                      gapH20,
                      Text(
                        'Access denied: No admin linked. Please contact support.',
                        style: TextStyles.h7(context),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyles.h9Bold(context),
                  ),
                  ContainerX(
                    child: Text(
                      '${admin.firstName} ${admin.lastName}',
                      style: TextStyles.h9Bold(context),
                    ),
                  ),
                  Text(
                    'Phone',
                    style: TextStyles.h9Bold(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: admin.phoneNumber))
                          .then(
                        (_) {
                          if (context.mounted) {
                            showMessageSnackbar(
                                context: context,
                                message: 'Phone number copied to clipboard',
                                maxLines: 2);
                          }
                        },
                      );
                    },
                    child: ContainerX(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            admin.phoneNumber,
                            style: TextStyles.h9Bold(context),
                          ),
                          const Icon(Icons.copy)
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            error: (error, stackTrace) {
              // print(stackTrace);
              return ErrorScreen(
                  error: error,
                  onRetry: () => ref
                      .refresh(fetchUserProvider(documentId: adminUid).future));
            },
            loading: () => _buildShimmerLoading(context)),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return SpacedColumn(
      children: [
        gapH12,
        ShimmerX(
            width: context.sizeOfWidth * 0.2,
            height: context.sizeOfHeight * 0.02,
            alignment: Alignment.topLeft),
        ShimmerX(
            width: context.sizeOfWidth, height: context.sizeOfHeight * 0.06),
        gapH12,
        ShimmerX(
            width: context.sizeOfWidth * 0.2,
            height: context.sizeOfHeight * 0.02,
            alignment: Alignment.topLeft),
        ShimmerX(
            width: context.sizeOfWidth, height: context.sizeOfHeight * 0.06)
      ],
    );
  }
}
