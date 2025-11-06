import 'package:repo/repo.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/widgets/scrollable_button_row.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';

part 'today_providers.g.dart';

// ============================================================================
// Shared Models
// ============================================================================
class UserWithOrder {
  final UserX user;
  final OrderX? order;

  UserWithOrder({
    required this.user,
    this.order,
  });
}

class AdminCount {
  final String name;
  final String uId;
  final int totalClients;
  final int completed;

  AdminCount({
    required this.name,
    required this.uId,
    required this.completed,
    required this.totalClients,
  });
}

enum AdminOrderFilter {
  whoOrdered,
  whoNotOrdered,
}

AdminOrderFilter filterFromId(String id) {
  return AdminOrderFilter.values.firstWhere(
    (e) => e.name == id,
    orElse: () => AdminOrderFilter.whoOrdered,
  );
}

final List<IconLabel> adminOrderFilterLabels = [
  IconLabel(
    id: AdminOrderFilter.whoOrdered.name,
    label: 'Who Ordered',
    icon: Icons.check_circle,
  ),
  IconLabel(
    id: AdminOrderFilter.whoNotOrdered.name,
    label: 'Who Didn\'t Order',
    icon: Icons.cancel,
  ),
];

// ============================================================================
// ✅ toDaysProgress — same logic but with debug prints
// ============================================================================
@riverpod
Future<List<AdminCount>> toDaysProgressStream(Ref ref,
    {bool forActualDelivery = false}) async {
  // ✅ Wait for BOTH providers' initial load to complete:
  await ref.watch(usersStreamProvider.future);
  final orders = await ref.watch(
      OrdersStreamXProvider(forActualDelivery: forActualDelivery).future);
  final appState = ref.watch(appStateXProvider);
  final completeUsers =
      await ref.read(usersStreamProvider.notifier).completeUsers;
  final admins = await ref.read(usersStreamProvider.notifier).admins;
  final currentAdminUid = appState.uId;
  final results = admins.map((admin) {
    final relatedUsers = completeUsers
        .where((u) => u.superuserUid == admin.uid || u.uid == admin.uid)
        .toList();
    final selfIncluded = relatedUsers.any((u) => u.uid == admin.uid)
        ? relatedUsers
        : [...relatedUsers, admin];
    final totalClients = selfIncluded.length;
    final completed = selfIncluded.where((client) {
      return orders.any((order) => order.userUid == client.uid);
    }).length;
    final name = '${admin.firstName} ${admin.lastName}' +
        (admin.uid == currentAdminUid ? ' (You)' : '');
    return AdminCount(
      name: name,
      uId: admin.uid,
      totalClients: totalClients,
      completed: completed,
    );
  }).toList();
  return results;
}

// ============================================================================
// ✅ filteredAdminUsersWithOrders — with debug prints
// ============================================================================
@riverpod
Future<List<UserWithOrder>> filteredAdminUsersWithOrdersStream(
  Ref ref, {
  required String adminUid,
  required AdminOrderFilter filter,
  bool forActualDelivery = false,
}) async {
  await ref.watch(usersStreamProvider.future);
  final orders = await ref.watch(
      OrdersStreamXProvider(forActualDelivery: forActualDelivery).future);
  // ✅ Fetch all users
  final completeUsers =
      await ref.watch(usersStreamProvider.notifier).completeUsers;
  // ✅ Combine user + order
  final combined = completeUsers.map((user) {
    final order = orders.firstWhere(
      (o) => o.userUid == user.uid,
      orElse: () => OrderX.empty(),
    );
    return UserWithOrder(
      user: user,
      order: order.isEmpty ? null : order,
    );
  }).toList();
  // ✅ Filter users
  final filtered = combined.where((entry) {
    final sameAdmin =
        entry.user.superuserUid == adminUid || entry.user.uid == adminUid;
    final hasOrder = entry.order != null;

    final result = switch (filter) {
      AdminOrderFilter.whoOrdered => sameAdmin && hasOrder,
      AdminOrderFilter.whoNotOrdered => sameAdmin && !hasOrder,
    };
    return result;
  }).toList();
  return filtered;
}
