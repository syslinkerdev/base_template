// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$toDaysProgressStreamHash() =>
    r'f3eb01607da929da37a6d92e0144a9b7dc782c1f';

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

/// See also [toDaysProgressStream].
@ProviderFor(toDaysProgressStream)
const toDaysProgressStreamProvider = ToDaysProgressStreamFamily();

/// See also [toDaysProgressStream].
class ToDaysProgressStreamFamily extends Family<AsyncValue<List<AdminCount>>> {
  /// See also [toDaysProgressStream].
  const ToDaysProgressStreamFamily();

  /// See also [toDaysProgressStream].
  ToDaysProgressStreamProvider call({
    bool forActualDelivery = false,
  }) {
    return ToDaysProgressStreamProvider(
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  ToDaysProgressStreamProvider getProviderOverride(
    covariant ToDaysProgressStreamProvider provider,
  ) {
    return call(
      forActualDelivery: provider.forActualDelivery,
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
  String? get name => r'toDaysProgressStreamProvider';
}

/// See also [toDaysProgressStream].
class ToDaysProgressStreamProvider
    extends AutoDisposeFutureProvider<List<AdminCount>> {
  /// See also [toDaysProgressStream].
  ToDaysProgressStreamProvider({
    bool forActualDelivery = false,
  }) : this._internal(
          (ref) => toDaysProgressStream(
            ref as ToDaysProgressStreamRef,
            forActualDelivery: forActualDelivery,
          ),
          from: toDaysProgressStreamProvider,
          name: r'toDaysProgressStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$toDaysProgressStreamHash,
          dependencies: ToDaysProgressStreamFamily._dependencies,
          allTransitiveDependencies:
              ToDaysProgressStreamFamily._allTransitiveDependencies,
          forActualDelivery: forActualDelivery,
        );

  ToDaysProgressStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.forActualDelivery,
  }) : super.internal();

  final bool forActualDelivery;

  @override
  Override overrideWith(
    FutureOr<List<AdminCount>> Function(ToDaysProgressStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ToDaysProgressStreamProvider._internal(
        (ref) => create(ref as ToDaysProgressStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        forActualDelivery: forActualDelivery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AdminCount>> createElement() {
    return _ToDaysProgressStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ToDaysProgressStreamProvider &&
        other.forActualDelivery == forActualDelivery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, forActualDelivery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ToDaysProgressStreamRef
    on AutoDisposeFutureProviderRef<List<AdminCount>> {
  /// The parameter `forActualDelivery` of this provider.
  bool get forActualDelivery;
}

class _ToDaysProgressStreamProviderElement
    extends AutoDisposeFutureProviderElement<List<AdminCount>>
    with ToDaysProgressStreamRef {
  _ToDaysProgressStreamProviderElement(super.provider);

  @override
  bool get forActualDelivery =>
      (origin as ToDaysProgressStreamProvider).forActualDelivery;
}

String _$filteredAdminUsersWithOrdersStreamHash() =>
    r'2cc9fee7ef07df3217578d56d2bfbc809df222fa';

/// See also [filteredAdminUsersWithOrdersStream].
@ProviderFor(filteredAdminUsersWithOrdersStream)
const filteredAdminUsersWithOrdersStreamProvider =
    FilteredAdminUsersWithOrdersStreamFamily();

/// See also [filteredAdminUsersWithOrdersStream].
class FilteredAdminUsersWithOrdersStreamFamily
    extends Family<AsyncValue<List<UserWithOrder>>> {
  /// See also [filteredAdminUsersWithOrdersStream].
  const FilteredAdminUsersWithOrdersStreamFamily();

  /// See also [filteredAdminUsersWithOrdersStream].
  FilteredAdminUsersWithOrdersStreamProvider call({
    required String adminUid,
    required AdminOrderFilter filter,
    bool forActualDelivery = false,
  }) {
    return FilteredAdminUsersWithOrdersStreamProvider(
      adminUid: adminUid,
      filter: filter,
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  FilteredAdminUsersWithOrdersStreamProvider getProviderOverride(
    covariant FilteredAdminUsersWithOrdersStreamProvider provider,
  ) {
    return call(
      adminUid: provider.adminUid,
      filter: provider.filter,
      forActualDelivery: provider.forActualDelivery,
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
  String? get name => r'filteredAdminUsersWithOrdersStreamProvider';
}

/// See also [filteredAdminUsersWithOrdersStream].
class FilteredAdminUsersWithOrdersStreamProvider
    extends AutoDisposeFutureProvider<List<UserWithOrder>> {
  /// See also [filteredAdminUsersWithOrdersStream].
  FilteredAdminUsersWithOrdersStreamProvider({
    required String adminUid,
    required AdminOrderFilter filter,
    bool forActualDelivery = false,
  }) : this._internal(
          (ref) => filteredAdminUsersWithOrdersStream(
            ref as FilteredAdminUsersWithOrdersStreamRef,
            adminUid: adminUid,
            filter: filter,
            forActualDelivery: forActualDelivery,
          ),
          from: filteredAdminUsersWithOrdersStreamProvider,
          name: r'filteredAdminUsersWithOrdersStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredAdminUsersWithOrdersStreamHash,
          dependencies: FilteredAdminUsersWithOrdersStreamFamily._dependencies,
          allTransitiveDependencies: FilteredAdminUsersWithOrdersStreamFamily
              ._allTransitiveDependencies,
          adminUid: adminUid,
          filter: filter,
          forActualDelivery: forActualDelivery,
        );

  FilteredAdminUsersWithOrdersStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.adminUid,
    required this.filter,
    required this.forActualDelivery,
  }) : super.internal();

  final String adminUid;
  final AdminOrderFilter filter;
  final bool forActualDelivery;

  @override
  Override overrideWith(
    FutureOr<List<UserWithOrder>> Function(
            FilteredAdminUsersWithOrdersStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredAdminUsersWithOrdersStreamProvider._internal(
        (ref) => create(ref as FilteredAdminUsersWithOrdersStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        adminUid: adminUid,
        filter: filter,
        forActualDelivery: forActualDelivery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserWithOrder>> createElement() {
    return _FilteredAdminUsersWithOrdersStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredAdminUsersWithOrdersStreamProvider &&
        other.adminUid == adminUid &&
        other.filter == filter &&
        other.forActualDelivery == forActualDelivery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, adminUid.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);
    hash = _SystemHash.combine(hash, forActualDelivery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredAdminUsersWithOrdersStreamRef
    on AutoDisposeFutureProviderRef<List<UserWithOrder>> {
  /// The parameter `adminUid` of this provider.
  String get adminUid;

  /// The parameter `filter` of this provider.
  AdminOrderFilter get filter;

  /// The parameter `forActualDelivery` of this provider.
  bool get forActualDelivery;
}

class _FilteredAdminUsersWithOrdersStreamProviderElement
    extends AutoDisposeFutureProviderElement<List<UserWithOrder>>
    with FilteredAdminUsersWithOrdersStreamRef {
  _FilteredAdminUsersWithOrdersStreamProviderElement(super.provider);

  @override
  String get adminUid =>
      (origin as FilteredAdminUsersWithOrdersStreamProvider).adminUid;
  @override
  AdminOrderFilter get filter =>
      (origin as FilteredAdminUsersWithOrdersStreamProvider).filter;
  @override
  bool get forActualDelivery =>
      (origin as FilteredAdminUsersWithOrdersStreamProvider).forActualDelivery;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
