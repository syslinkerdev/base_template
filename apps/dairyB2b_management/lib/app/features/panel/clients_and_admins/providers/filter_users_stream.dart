import 'package:repo/repo.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_users_stream.g.dart';

@riverpod
Future<List<UserX>> filteredUsersStream(Ref ref,
    {UserStatus userStatus = UserStatus.active,
    bool pendingKyc = false,
    required String adminUid}) async {
  final allUsers = await _resolveUsers(ref,
      userStatus: userStatus, pendingKyc: pendingKyc, adminUid: adminUid);
  return allUsers;
}

@riverpod
Future<UserX?> userStream(Ref ref, {required String uid}) async {
  final users = await ref.watch(usersStreamProvider.future);
  try {
    return users.firstWhere((u) => u.uid == uid);
  } catch (_) {
    return null;
  }
}

Future<List<UserX>> _resolveUsers(
  Ref<Object?> ref, {
  required String adminUid,
  required UserStatus userStatus,
  required bool pendingKyc,
}) async {
  final allUsers = await ref.watch(usersStreamProvider.future);
  //print('allUsers : ${allUsers.length}');

  final filtered = allUsers.where((user) {
    // Admin filter: must match adminUid or be that admin
    final sameAdmin = user.superuserUid == adminUid || user.uid == adminUid;
    if (!sameAdmin) return false;
    // Match status
    if (user.status != userStatus) return false;
    // ✅ If pendingKyc is true, only include incomplete KYC users
    if (pendingKyc && (user.hashedPassword ?? '').isNotEmpty) return false;
    // ✅ If pendingKyc is false, only include users with full KYC
    if (!pendingKyc && !(user.hashedPassword ?? '').isNotEmpty) return false;
    return true;
  }).toList();

  // ✅ Ensure admin is always at the top
  filtered.sort((a, b) {
    if (a.uid == adminUid) return -1;
    if (b.uid == adminUid) return 1;
    return 0;
  });

  //print('filtered : ${filtered.length}');
  return filtered;
}
