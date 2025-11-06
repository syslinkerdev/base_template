import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/widgets/user_card.dart';
import 'package:repo/repo.dart';

class UserSelectScreen extends StatelessWidget {
  const UserSelectScreen({super.key, required this.selectedUser});
  final String selectedUser;

  @override
  Widget build(BuildContext context) {
    return ScaffoldX(
      wantLeading: true,
      appToolbarHeight: -1,
      body: UserSelectScreenBody(selectedUser: selectedUser),
    );
  }

  static Future<UserX?> bottomSheet(BuildContext context,
      {required String selectedUser}) {
    return showModalBottomSheet<UserX?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          _UserSelectScreenBottomSheetContent(selectedUser: selectedUser),
    );
  }
}

class _UserSelectScreenBottomSheetContent extends StatelessWidget {
  const _UserSelectScreenBottomSheetContent({required this.selectedUser});
  final String selectedUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        const Positioned(
          top: -60,
          child: _CloseButton(),
        ),
        Container(
          width: context.sizeOfWidth,
          height: context.sizeOfHeight * 0.775,
          decoration: BoxDecoration(
            color: appColors.ms.whiteSwNero(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: UserSelectScreenBody(selectedUser: selectedUser),
        ),
      ],
    );
  }
}

class UserSelectScreenBody extends HookConsumerWidget {
  const UserSelectScreenBody({super.key, required this.selectedUser});
  final String selectedUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //debugPrint('💥 Rebuilding widget UserSelectScreenBody');
    final allUsers = ref.watch(usersStreamProvider);
    final completeUsers = allUsers.value?.completeUsers;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Select User',
                    style: TextStyles.h7Gray(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Icon(
                    Icons.group,
                    size: TextStyles.h7Gray(context)?.fontSize,
                    color: TextStyles.h7Gray(context)?.color,
                  ),
                  gapW2,
                  Text(
                    '${completeUsers?.length}',
                    style: TextStyles.h7Gray(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              gapH8,
              if (allUsers.isLoading)
                const LinearProgressIndicator(minHeight: 2)
              else
                gapH2,
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (allUsers.hasError) {
                      return ErrorScreen(
                        error: allUsers.error!,
                        onRetry: () => refresh(ref: ref),
                      );
                    }
                    if (completeUsers == null)
                      return _buildShimmerLoading(context);
                    if (completeUsers.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inventory_2_outlined,
                                size: context.sizeOfHeight * 0.12,
                                color: appColors.sc.grey650),
                            gapH20,
                            Text('No User Found',
                                textAlign: TextAlign.center,
                                style: TextStyles.h8Gray(context)),
                          ],
                        ),
                      );
                    }
                    return DynamicList<UserX>(
                      items: completeUsers,
                      onSelect: (user) async => context.pop(user),
                      listSeparatorBuilder: (context, index) => gapH4,
                      itemBuilder: (context, user, isSelected) =>
                          UserXCardForSelect(
                              isSelected: user.uid == selectedUser, user: user),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliers = [0.08, 0.08, 0.08, 0.08];
    return SingleChildScrollView(
      child: SpacedColumn(
        children: heightMultipliers
            .map((h) => ShimmerX(
                  width: context.sizeOfWidth,
                  height: context.sizeOfHeight * h,
                ))
            .toList(),
      ),
    );
  }

  static Future<void> refresh({required WidgetRef ref}) async {
    await Future.wait([ref.refresh(usersStreamProvider.future)]);
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        iconColor: WidgetStatePropertyAll(appColors.ms.whiteSwNero(context)),
        backgroundColor: WidgetStatePropertyAll(
          appColors.ms.neroSwWhite(context).withValues(alpha: 0.3),
        ),
      ),
      onPressed: () => context.pop(),
      icon: const Icon(Icons.close_rounded, weight: 10),
    );
  }
}

class UserXCardForSelect extends StatelessWidget {
  final UserX user;
  final bool isSelected;
  const UserXCardForSelect(
      {super.key, required this.user, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.zero,
      borderColor: isSelected ? appColors.cS(context).surfaceTint : null,
      borderWidth: isSelected ? 2 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyles.h8Bold(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${user.phoneNumber}',
                      style: TextStyles.h13Gray(context),
                    ),
                  ],
                ),
              ),
              StatusTag(
                  label: user.role?.label,
                  color: user.role?.color,
                  icon: user.role?.icon),
            ],
          ),
        ],
      ),
    );
  }
}
