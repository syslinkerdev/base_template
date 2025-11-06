import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/today_providers.dart';

class AdminCountFilterDropdown extends ConsumerWidget {
  final List<AdminCount> admins;
  final String? selectedAdminUid;
  final void Function(AdminCount) onChanged;

  const AdminCountFilterDropdown({
    super.key,
    required this.admins,
    required this.selectedAdminUid,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fUid = selectedAdminUid ?? ref.read(appStateXProvider).uId;

    final selectedAdmin = admins.firstWhere(
      (admin) => admin.uId == fUid,
      orElse: () => admins.first,
    );

    return PopUpDropdown<AdminCount>(
      hintText: 'Select Admin',
      tooltip: 'Admins',
      items: admins,
      value: selectedAdmin,
      itemLabel: (admin) =>
          '${admin.name} (${admin.completed}/${admin.totalClients})',
      onSelected: onChanged,
    );
  }
}

class AdminFilterDropdown extends ConsumerWidget {
  final List<UserX> admins;
  final String? selectedAdminUid;
  final void Function(UserX) onChanged;

  const AdminFilterDropdown({
    super.key,
    required this.admins,
    required this.selectedAdminUid,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUid = ref.read(appStateXProvider).uId;

    // Find the currently selected admin UserX
    final selectedAdmin = admins.firstWhere(
        (admin) => admin.uid == selectedAdminUid,
        orElse: () => admins.isNotEmpty ? admins.first : UserX.empty());

    return PopUpDropdown<UserX>(
      hintText: 'Select Admin',
      tooltip: 'Admins',
      items: admins,
      value: selectedAdmin,
      itemLabel: (admin) {
        final name = '${admin.firstName} ${admin.lastName}';
        return admin.uid == currentUid ? '$name (You)' : name;
      },
      onSelected: onChanged,
    );
  }
}
