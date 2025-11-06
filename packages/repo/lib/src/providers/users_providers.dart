part of 'package:repo/repo.dart';

// fetchAdminsAndSuperAdminsListProvider
@riverpod
Future<List<UserX>> fetchAdminsAndSuperAdminsList(Ref ref) {
  return ref.read(dairyB2bRepositoryProvider).fetchAdminsAndSuperAdmins();
}

// fetchUserStreamProvider
@riverpod
Stream<UserX?> fetchUserStream(Ref ref, {required String uId}) {
  return ref.read(dairyB2bRepositoryProvider).fetchUserStream(uId: uId);
}

// fetchUserProvider
@riverpod
FutureOr<UserX?> fetchUser(Ref ref, {required String documentId}) {
  return ref.read(dairyB2bRepositoryProvider).fetchUser(documentId: documentId);
}

// fetchAppManagementProvider
@riverpod
FutureOr<UserX?> fetchAppManagement(Ref ref, {required String documentId}) {
  return ref
      .read(dairyB2bRepositoryProvider)
      .fetchAppManagement(documentId: documentId);
}

// fetchDeletedUserProvider
@riverpod
FutureOr<UserX?> fetchDeletedUser(Ref ref, {required String documentId}) {
  return ref
      .read(dairyB2bRepositoryProvider)
      .fetchDeletedUser(documentId: documentId);
}

// fetchUserByComparisonPhoneStreamProvider
@riverpod
Stream<UserX?> fetchUserByComparisonPhoneStream(Ref ref,
    {required String phoneNumber}) {
  return ref
      .read(dairyB2bRepositoryProvider)
      .fetchUserByComparisonPhoneStream(phoneNumber: phoneNumber);
}

// 🧩 Riverpod Provider
@Riverpod(keepAlive: true)
class UsersStream extends _$UsersStream {
  @override
  FutureOr<List<UserX>> build() async {
    final repo = ref.read(dairyB2bRepositoryProvider);

    // print('🚀 UsersStream.build() started...');

    try {
      // 👇 Initial one-time fetch
      final initial = await repo.usersStream().first;
      // print('📦 Initial fetch completed with ${initial.length} users');

      final filtered = initial.whereType<UserX>().toList();
      // print('🧹 Filtered valid users: ${filtered.length}');

      state = AsyncValue.data(filtered);
      // print('✅ UserStream initial state set with ${state.value?.length} users');

      // 👇 Start real-time updates
      repo.usersStream().listen(
        (users) {
          final valid = users.whereType<UserX>().toList();
          state = AsyncValue.data(valid);
          // print('🔁 Real-time update: ${valid.length} users received');
        },
        onError: (err) {
          // print('❌ Stream error occurred: $err');
          state = AsyncValue.data([]);
        },
        onDone: () {
          // print('🛑 usersStream() completed');
        },
      );

      return filtered;
    } catch (err, _) {
      // print('💥 Error during UsersStream.build(): $err');
      // print(st);
      throw err;
    }
  }

  /// Only complete users
  List<UserX> get completeUsers {
    final users = (state.value ?? [])
        .where((u) => u.isCompleteUser == true)
        .where((u) => u.role != Role.appManagement)
        .toList();

    // print('🧩 completeUsers getter called: ${users.length} users');
    return users;
  }

  /// Only admins
  List<UserX> get admins {
    final admins = completeUsers.where((u) => u.role == Role.admin).toList();
    // print('👑 admins getter called: ${admins.length} admins');
    return admins;
  }
}
