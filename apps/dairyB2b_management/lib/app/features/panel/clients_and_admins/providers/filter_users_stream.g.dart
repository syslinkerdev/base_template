// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_users_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredUsersStreamHash() =>
    r'62f05681505dbe34093d71f31755ce4a6250d3fd';

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

/// See also [filteredUsersStream].
@ProviderFor(filteredUsersStream)
const filteredUsersStreamProvider = FilteredUsersStreamFamily();

/// See also [filteredUsersStream].
class FilteredUsersStreamFamily extends Family<AsyncValue<List<UserX>>> {
  /// See also [filteredUsersStream].
  const FilteredUsersStreamFamily();

  /// See also [filteredUsersStream].
  FilteredUsersStreamProvider call({
    UserStatus userStatus = UserStatus.active,
    bool pendingKyc = false,
    required String adminUid,
  }) {
    return FilteredUsersStreamProvider(
      userStatus: userStatus,
      pendingKyc: pendingKyc,
      adminUid: adminUid,
    );
  }

  @override
  FilteredUsersStreamProvider getProviderOverride(
    covariant FilteredUsersStreamProvider provider,
  ) {
    return call(
      userStatus: provider.userStatus,
      pendingKyc: provider.pendingKyc,
      adminUid: provider.adminUid,
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
  String? get name => r'filteredUsersStreamProvider';
}

/// See also [filteredUsersStream].
class FilteredUsersStreamProvider
    extends AutoDisposeFutureProvider<List<UserX>> {
  /// See also [filteredUsersStream].
  FilteredUsersStreamProvider({
    UserStatus userStatus = UserStatus.active,
    bool pendingKyc = false,
    required String adminUid,
  }) : this._internal(
          (ref) => filteredUsersStream(
            ref as FilteredUsersStreamRef,
            userStatus: userStatus,
            pendingKyc: pendingKyc,
            adminUid: adminUid,
          ),
          from: filteredUsersStreamProvider,
          name: r'filteredUsersStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredUsersStreamHash,
          dependencies: FilteredUsersStreamFamily._dependencies,
          allTransitiveDependencies:
              FilteredUsersStreamFamily._allTransitiveDependencies,
          userStatus: userStatus,
          pendingKyc: pendingKyc,
          adminUid: adminUid,
        );

  FilteredUsersStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userStatus,
    required this.pendingKyc,
    required this.adminUid,
  }) : super.internal();

  final UserStatus userStatus;
  final bool pendingKyc;
  final String adminUid;

  @override
  Override overrideWith(
    FutureOr<List<UserX>> Function(FilteredUsersStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredUsersStreamProvider._internal(
        (ref) => create(ref as FilteredUsersStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userStatus: userStatus,
        pendingKyc: pendingKyc,
        adminUid: adminUid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserX>> createElement() {
    return _FilteredUsersStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredUsersStreamProvider &&
        other.userStatus == userStatus &&
        other.pendingKyc == pendingKyc &&
        other.adminUid == adminUid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userStatus.hashCode);
    hash = _SystemHash.combine(hash, pendingKyc.hashCode);
    hash = _SystemHash.combine(hash, adminUid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredUsersStreamRef on AutoDisposeFutureProviderRef<List<UserX>> {
  /// The parameter `userStatus` of this provider.
  UserStatus get userStatus;

  /// The parameter `pendingKyc` of this provider.
  bool get pendingKyc;

  /// The parameter `adminUid` of this provider.
  String get adminUid;
}

class _FilteredUsersStreamProviderElement
    extends AutoDisposeFutureProviderElement<List<UserX>>
    with FilteredUsersStreamRef {
  _FilteredUsersStreamProviderElement(super.provider);

  @override
  UserStatus get userStatus =>
      (origin as FilteredUsersStreamProvider).userStatus;
  @override
  bool get pendingKyc => (origin as FilteredUsersStreamProvider).pendingKyc;
  @override
  String get adminUid => (origin as FilteredUsersStreamProvider).adminUid;
}

String _$userStreamHash() => r'3ade5d90aed0e687f343ba5069945daca2b8b112';

/// See also [userStream].
@ProviderFor(userStream)
const userStreamProvider = UserStreamFamily();

/// See also [userStream].
class UserStreamFamily extends Family<AsyncValue<UserX?>> {
  /// See also [userStream].
  const UserStreamFamily();

  /// See also [userStream].
  UserStreamProvider call({
    required String uid,
  }) {
    return UserStreamProvider(
      uid: uid,
    );
  }

  @override
  UserStreamProvider getProviderOverride(
    covariant UserStreamProvider provider,
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
  String? get name => r'userStreamProvider';
}

/// See also [userStream].
class UserStreamProvider extends AutoDisposeFutureProvider<UserX?> {
  /// See also [userStream].
  UserStreamProvider({
    required String uid,
  }) : this._internal(
          (ref) => userStream(
            ref as UserStreamRef,
            uid: uid,
          ),
          from: userStreamProvider,
          name: r'userStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userStreamHash,
          dependencies: UserStreamFamily._dependencies,
          allTransitiveDependencies:
              UserStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  UserStreamProvider._internal(
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
  Override overrideWith(
    FutureOr<UserX?> Function(UserStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserStreamProvider._internal(
        (ref) => create(ref as UserStreamRef),
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
  AutoDisposeFutureProviderElement<UserX?> createElement() {
    return _UserStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserStreamProvider && other.uid == uid;
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
mixin UserStreamRef on AutoDisposeFutureProviderRef<UserX?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserStreamProviderElement
    extends AutoDisposeFutureProviderElement<UserX?> with UserStreamRef {
  _UserStreamProviderElement(super.provider);

  @override
  String get uid => (origin as UserStreamProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
