// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_cache_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientCacheHash() => r'f8ab321733adf7c9fed63792cb4f55e7bec9e519';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ClientCache extends BuildlessAutoDisposeAsyncNotifier<UserX?> {
  late final String uid;

  FutureOr<UserX?> build({
    required String uid,
  });
}

/// See also [ClientCache].
@ProviderFor(ClientCache)
const clientCacheProvider = ClientCacheFamily();

/// See also [ClientCache].
class ClientCacheFamily extends Family<AsyncValue<UserX?>> {
  /// See also [ClientCache].
  const ClientCacheFamily();

  /// See also [ClientCache].
  ClientCacheProvider call({
    required String uid,
  }) {
    return ClientCacheProvider(
      uid: uid,
    );
  }

  @override
  ClientCacheProvider getProviderOverride(
    covariant ClientCacheProvider provider,
  ) {
    return call(
      uid: provider.uid,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'clientCacheProvider';
}

/// See also [ClientCache].
class ClientCacheProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ClientCache, UserX?> {
  /// See also [ClientCache].
  ClientCacheProvider({
    required String uid,
  }) : this._internal(
          () => ClientCache()..uid = uid,
          from: clientCacheProvider,
          name: r'clientCacheProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clientCacheHash,
          dependencies: ClientCacheFamily._dependencies,
          allTransitiveDependencies:
              ClientCacheFamily._allTransitiveDependencies,
          uid: uid,
        );

  ClientCacheProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  FutureOr<UserX?> runNotifierBuild(
    covariant ClientCache notifier,
  ) {
    return notifier.build(
      uid: uid,
    );
  }

  @override
  Override overrideWith(ClientCache Function() create) {
    return ProviderOverride(
      origin: this,
      override: ClientCacheProvider._internal(
        () => create()..uid = uid,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ClientCache, UserX?> createElement() {
    return _ClientCacheProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientCacheProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClientCacheRef on AutoDisposeAsyncNotifierProviderRef<UserX?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _ClientCacheProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ClientCache, UserX?>
    with ClientCacheRef {
  _ClientCacheProviderElement(super.provider);

  @override
  String get uid => (origin as ClientCacheProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
