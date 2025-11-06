import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/app_base/app_state.dart';
import 'package:dairyB2b_orders/app/app_base/shared_prefs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_state_services.g.dart';

class AppStateService {
  final SharedPreferences sharedPreferences;
  final Ref ref;

  AppStateService(this.sharedPreferences, this.ref);

  static const String _key = 'user';

  AppState get current => getAppState();

  // Save app state (sync version – no Future)
  Future<bool> _saveAppState(AppState state) async {
    final jsonString = jsonEncode(state.toJson());
    return await sharedPreferences.setString(_key, jsonString);
  }

  // Load state from local storage
  AppState getAppState() {
    final json = sharedPreferences.getString(_key);
    return json != null
        ? AppState.fromJson(jsonDecode(json))
        : AppState.empty();
  }

  // Clear state
  void clearAppState() {
    sharedPreferences.remove(_key);
  }

  // --- Direct Update methods (Sync versions) ---

  AppState _update(AppState Function(AppState) updateFn) {
    final current = getAppState();
    final updated = updateFn(current);
    _saveAppState(updated); // optional: check success
    return updated;
  }

  AppState resetToInitial() {
    return _update((s) => AppState.empty());
  }

  AppState updateStatusToOtpVerified() {
    return _update((s) => s.copyWith(status: AppStatus.otpVerified));
  }

  AppState updateStatusToKycCompleted(String uId) {
    return _update((s) => s.copyWith(status: AppStatus.kycCompleted, uId: uId));
  }

  AppState updateStatusToPinCompleted() {
    return _update((s) => s.copyWith(status: AppStatus.pinCompleted));
  }

  AppState updateStatusToAuthorized({required String userId}) {
    return _update(
        (s) => s.copyWith(status: AppStatus.authorized, uId: userId));
  }

  AppState updateStatusToUnAuthorized() {
    return _update((s) => s.copyWith(status: AppStatus.unAuthorized));
  }

  AppState updateStatusToDeleted(String uId) {
    return _update((s) => s.copyWith(uId: uId, status: AppStatus.deleted));
  }

  AppState updateRoleToAdmin() {
    return _update((s) => s.copyWith(role: Role.admin));
  }

  AppState updateRoleToClient() {
    return _update((s) => s.copyWith(role: Role.client));
  }

  AppState updateAll({
    String? uId,
    AppStatus? status,
    Role? role,
  }) {
    //print('uId ${uId} -- In');
    return _update((s) => s.copyWith(
          uId: uId ?? s.uId,
          status: status ?? s.status,
          role: role ?? s.role,
        ));
  }
}

@Riverpod(keepAlive: true)
AppStateService appStateService(Ref ref) {
  final sharedPreferences = ref.watch(sharedPrefsProvider);
  return AppStateService(sharedPreferences, ref);
}
