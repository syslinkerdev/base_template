import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/widgets/user_card.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';

class AdminsView extends HookConsumerWidget {
  const AdminsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersStreamProvider);
    final admins = usersAsync.valueOrNull?.admins;
    return ScaffoldX(
        wantLeading: true,
        title: 'Admins',
        body: RefreshIndicator(
          onRefresh: () => refresh(ref: ref),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (usersAsync.isLoading)
                  const LinearProgressIndicator(minHeight: 2)
                else
                  gapH2,
                Expanded(child: Builder(builder: (context) {
                  if (usersAsync.hasError) {
                    return ErrorScreen(
                      error: usersAsync.error!,
                      onRetry: () => refresh(ref: ref),
                    );
                  }
                  if (admins == null) return _buildShimmerLoading(context);
                  if (admins.isEmpty) {
                    return _buildEmptyState(context);
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DynamicList<UserX>(
                      items: admins,
                      physics: const NeverScrollableScrollPhysics(),
                      onSelect: (selectedUser) async => AppRoute.userDetailsView
                          .push(context, extra: selectedUser.uid),
                      itemBuilder: (context, user, _) => UserCard(user: user),
                    ),
                  );
                })),
              ],
            ),
          ),
        ));
  }

  static Future<void> refresh({required WidgetRef ref}) async {
    await Future.wait([
      ref.refresh(usersStreamProvider.future),
    ]);
  }

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
          Icon(Icons.person_search,
              size: context.sizeOfHeight * 0.12, color: appColors.sc.grey650),
          gapH20,
          Text('No Admins Found',
              textAlign: TextAlign.center, style: TextStyles.h8Gray(context)),
        ],
      ),
    );
  }
}
