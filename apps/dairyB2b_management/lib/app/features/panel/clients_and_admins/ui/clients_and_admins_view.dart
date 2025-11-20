import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/providers/filter_users_stream.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/widgets/user_card.dart';
import 'package:dairyB2b_management/app/features/to_day/ui/widgets/admin_filter_dropdown.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:repo/repo.dart';

class ClientsAndAdminsViewArgs {
  final UserStatus initUserStatus;
  final bool initPendingKyc;
  final String? initAdminId;

  ClientsAndAdminsViewArgs(
      {this.initPendingKyc = false,
      this.initUserStatus = UserStatus.active,
      this.initAdminId});
}

class ClientsAndAdminsView extends HookConsumerWidget {
  final UserStatus initUserStatus;
  final bool initPendingKyc;
  final String? initAdminId;
  const ClientsAndAdminsView(
      {super.key,
      required this.initPendingKyc,
      required this.initUserStatus,
      this.initAdminId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersFull = ref.watch(usersStreamProvider);
    final userUid = ref.read(appStateXProvider).uId;

    final selectedAdminId = useState<String?>(initAdminId);
    final selectedPendingKyc = useState<bool>(initPendingKyc);
    final selectedUserStatus = useState<UserStatus>(initUserStatus);

    // Sync state with incoming initial props
    useEffect(() {
      if (initPendingKyc != selectedPendingKyc.value) {
        selectedPendingKyc.value = initPendingKyc;
      }

      if (initUserStatus != selectedUserStatus.value) {
        selectedUserStatus.value = initUserStatus;
      }
      if (initAdminId != selectedAdminId.value) {
        selectedAdminId.value = initAdminId ?? userUid;
      }
      return null;
    }, [initPendingKyc, initUserStatus, initAdminId]);

    // Setup filtered stream
    final filteredProvider = FilteredUsersStreamProvider(
        pendingKyc: selectedPendingKyc.value,
        userStatus: selectedUserStatus.value,
        adminUid: selectedAdminId.value ?? userUid);

    final filteredUsers = ref.watch(filteredProvider);
    final users = filteredUsers.valueOrNull;
    String titleX({required bool pendingKyc}) {
      if (pendingKyc == true) {
        return 'Pending KYC';
      } else {
        return 'Users';
      }
    }

    return ScaffoldX(
      wantLeading: true,
      title: titleX(pendingKyc: selectedPendingKyc.value),
      body: RefreshIndicator(
        onRefresh: () => refresh(ref: ref, pro: filteredProvider),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFilters(context,
                  selectedAdminId: selectedAdminId,
                  selectedPendingKyc: selectedPendingKyc,
                  selectedUserStatus: selectedUserStatus,
                  userList: usersFull),
              if (filteredUsers.isLoading)
                const LinearProgressIndicator(minHeight: 2)
              else
                gapH2,
              Expanded(child: Builder(builder: (context) {
                if (filteredUsers.hasError) {
                  return ErrorScreen(
                    error: filteredUsers.error!,
                    onRetry: () => refresh(ref: ref, pro: filteredProvider),
                  );
                }
                if (users == null) return _buildShimmerLoading(context);
                if (users.isEmpty) {
                  return _buildEmptyState(context, selectedPendingKyc.value,
                      selectedUserStatus.value);
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DynamicList<UserX>(
                    items: users,
                    physics: const NeverScrollableScrollPhysics(),
                    onSelect: (selectedUser) async {
                      if (selectedPendingKyc.value == false) {
                        AppRoute.userDetailsView
                            .push(context, extra: selectedUser.uid);
                      } else {
                        return;
                      }
                    },
                    itemBuilder: (context, user, _) => UserCard(
                        user: user, selectedPendingKyc: selectedPendingKyc),
                  ),
                );
              })),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context,
      {required AsyncValue<List<UserX>> userList,
      required ValueNotifier<bool> selectedPendingKyc,
      required ValueNotifier<UserStatus> selectedUserStatus,
      required ValueNotifier<String?> selectedAdminId}) {
    return userList.when(
      data: (users) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              AdminFilterDropdown(
                admins: users.admins,
                selectedAdminUid: selectedAdminId.value,
                onChanged: (newAdmin) => selectedAdminId.value = newAdmin.uid,
              ),
              if (selectedPendingKyc.value == false)
                SizedBox(
                  width: context.sizeOfWidth,
                  height: 42,
                  child: BtnList<UserStatus>(
                    data: UserStatus.values,
                    initItem: selectedUserStatus.value,
                    onSelect: (uStatus) => selectedUserStatus.value = uStatus,
                    builder: (context, item, isSelected) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: appColors
                                  .cS(context)
                                  .inversePrimary
                                  .withValues(alpha: isSelected ? 0.9 : 0.3),
                            ),
                            child: Icon(item.icon, size: 14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2, right: 6),
                            child: Text(
                              item.label,
                              style: TextStyles.h15Bold(context)?.copyWith(
                                  color: appColors.cS(context).surfaceTint),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
      loading: () => const ShimmerX(width: double.infinity, height: 48),
      error: (error, _) => ContainerX(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: appColors.sc.grey700),
            gapW8,
            Expanded(
              child: Text(
                'Failed to load admins: ${error.toString()}',
                style: TextStyles.h8(context)?.copyWith(
                  color: appColors.sc.grey700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context, bool? pendingKyc, UserStatus? userStatus) {
    final message = _buildNoProductsMessage(pendingKyc, userStatus);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search,
              size: context.sizeOfHeight * 0.12, color: appColors.sc.grey650),
          gapH20,
          Text(message,
              textAlign: TextAlign.center, style: TextStyles.h8Gray(context)),
        ],
      ),
    );
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

  String _buildNoProductsMessage(
    bool? pendingKyc,
    UserStatus? userStatus,
  ) {
    final buffer = StringBuffer('No Users found');

    if (pendingKyc == true) {
      buffer.write(' (KYC pending)');
    }

    if (userStatus != null && pendingKyc == false) {
      buffer.write(' with status: ${userStatus.name}');
    }

    return buffer.toString();
  }

  static Future<void> refresh({
    required WidgetRef ref,
    required FilteredUsersStreamProvider pro,
  }) async {
    await Future.wait([
      ref.refresh(pro.future),
    ]);
  }
}
