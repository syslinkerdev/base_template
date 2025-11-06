import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_cache_provider.g.dart';

@riverpod
class ClientCache extends _$ClientCache {
  @override
  FutureOr<UserX?> build({required String uid}) {
    return getClient(uid);
  }

  Future<UserX?> getClient(String uid) async {
    final result = await AsyncValue.guard(() async {
      final UserX? _cacheClient = GlobalCacheService.instance.getClient();
      if (_cacheClient != null) {
        return _cacheClient;
      } else {
        final UserX? _apiClient =
            await ref.read(dairyB2bRepositoryProvider).fetchUser(documentId: uid);
        if (_apiClient != null) {
          GlobalCacheService.instance.setClient(_apiClient);
          return _apiClient;
        } else {
          throw Exception('User not found');
        }
      }
    });
    state = result;
    return result.value;
  }
}
