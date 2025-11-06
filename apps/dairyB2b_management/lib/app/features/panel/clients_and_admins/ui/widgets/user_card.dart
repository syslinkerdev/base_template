import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/widgets/shared_widgets.dart';

class UserCard extends ConsumerWidget {
  const UserCard({
    super.key,
    required this.user,
    this.selectedPendingKyc,
  });

  final UserX user;
  final ValueNotifier<bool>? selectedPendingKyc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPendingKycX =
        selectedPendingKyc ?? ValueNotifier<bool>(false);
    return ContainerX(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: selectedPendingKycX.value == false
          ? ForUsersPage(user: user)
          : ForPendingKycPage(ref: ref, user: user),
    );
  }
}

class ForPendingKycPage extends StatelessWidget {
  const ForPendingKycPage({super.key, required this.user, required this.ref});

  final UserX user;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${user.phoneNumber}",
              style: TextStyles.h8Bold(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            StatusTag(
                label: user.role?.label,
                color: user.role?.color,
                icon: user.role?.icon),
          ],
        ),
        SimpleDivider(),
        AccessCodeWidget(ref: ref, user: user),
      ],
    );
  }
}

class ForUsersPage extends StatelessWidget {
  const ForUsersPage({
    super.key,
    required this.user,
  });

  final UserX user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircularImageAvatar(image: user.avatar, radius: 20),
            gapW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: TextStyles.h8Bold(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      StatusTag(
                          label: user.status?.label,
                          color: user.status?.color,
                          icon: user.status?.icon),
                      gapW2,
                      StatusTag(
                          label: user.role?.label,
                          color: user.role?.color,
                          icon: user.role?.icon),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SimpleDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 2,
              children: [
                InfoChip(
                  label: 'Phone',
                  value:
                      '${user.phoneNumber.substring(0, 3)} ${user.phoneNumber.substring(3)}',
                ),
                InfoChip(
                  label: 'Disc#',
                  value:
                      '${user.disSection?.productDiscounts.values.length ?? 0}',
                ),
                InfoChip(
                  label: 'Bask#',
                  value: '${user.smartBaskets?.length}',
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: appColors.sc.grey500),
          ],
        ),
      ],
    );
  }
}

class StatusTag extends StatelessWidget {
  const StatusTag({super.key, this.color, this.icon, this.label});

  final Color? color;
  final IconData? icon;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
          color: color?.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: color, size: 14),
            gapW2,
          ],
          Text(label ?? 'Tag',
              style: TextStyles.h14Bold(context)?.copyWith(color: color)),
        ],
      ),
    );
  }
}
