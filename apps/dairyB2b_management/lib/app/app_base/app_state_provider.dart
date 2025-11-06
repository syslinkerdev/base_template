import 'package:auth/auth.dart';
import 'package:models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_management/app/app_base/app_state.dart';
import 'package:dairyB2b_management/app/app_base/app_state_services.dart';

part 'app_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AppStateX extends _$AppStateX {
  AppStateService get _service => ref.read(appStateServiceProvider);

  @override
  AppState build() {
    final state = _service.current;
    return state;
  }

  void reloadAppState() {
    state = _service.current;
  }

  void updateStatus(AppStatus status) async {
    state = await _service.updateAll(status: status);
  }

  void updateRole(Role role) async {
    state = await _service.updateAll(role: role);
  }

  void updateUid(String uId) async {
    state = await _service.updateAll(uId: uId);
  }

  void updateAll({
    String? uId,
    AppStatus? status,
    Role? role,
  }) async {
    state = await _service.updateAll(
      uId: uId,
      status: status,
      role: role,
    );
  }

  void resetToInitial() async {
    state = await _service.resetToInitial();
  }

  void markOtpVerified() async {
    state = await _service.updateStatusToOtpVerified();
  }

  void markKycCompleted({required String uId}) async {
    state = await _service.updateStatusToKycCompleted(uId);
  }

  void markPinCompleted() async {
    state = await _service.updateStatusToPinCompleted();
  }

  void logIn({required String uId, required Role role}) async {
    state = await _service.updateAll(
        uId: uId, role: role, status: AppStatus.authorized);
  }

  void logOut() async =>
      state = await _service.updateAll(status: AppStatus.unknown);

  void markAuthorized([String? uId]) async {
    final currentUser = ref.read(phoneNoVerifyServiceProvider).currentUser;

    final resolvedUid = uId != null && uId.isNotEmpty ? uId : currentUser?.uid;

    if (resolvedUid == null || resolvedUid.isEmpty) {
      // Optional: Handle missing UID properly
      //print('❌ Unable to resolve user ID for authorization.');
      return;
    }

    state = await _service.updateStatusToAuthorized(userId: resolvedUid);
  }

  void markUnAuthorized() async {
    state = await _service.updateStatusToUnAuthorized();
  }

  void markDeleted(String uId) async {
    state = await _service.updateStatusToDeleted(uId);
  }
}
