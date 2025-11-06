// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dairyB2bRepositoryHash() =>
    r'65517a7194ba6214c233f1b0dfbf5174171b7541';

/// Provides a single instance of [DairyB2bRepository].
///
/// Copied from [dairyB2bRepository].
@ProviderFor(dairyB2bRepository)
final dairyB2bRepositoryProvider =
    AutoDisposeProvider<DairyB2bRepository>.internal(
  dairyB2bRepository,
  name: r'dairyB2bRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dairyB2bRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DairyB2bRepositoryRef = AutoDisposeProviderRef<DairyB2bRepository>;
String _$fetchProductMakerHash() => r'e883e9111804e2b4d2c298d42e8aaae460fc9a96';

/// See also [fetchProductMaker].
@ProviderFor(fetchProductMaker)
final fetchProductMakerProvider = FutureProvider<ProductMaker?>.internal(
  fetchProductMaker,
  name: r'fetchProductMakerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchProductMakerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchProductMakerRef = FutureProviderRef<ProductMaker?>;
String _$fetchAvatarsListHash() => r'a8fb77e13de50dd42445ed1ada23f28399035e6f';

/// See also [fetchAvatarsList].
@ProviderFor(fetchAvatarsList)
final fetchAvatarsListProvider =
    AutoDisposeFutureProvider<List<Avatar>>.internal(
  fetchAvatarsList,
  name: r'fetchAvatarsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAvatarsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchAvatarsListRef = AutoDisposeFutureProviderRef<List<Avatar>>;
String _$fetchLogListHash() => r'33f317dc4e2c5ff4dd812452045e4315fd05a144';

/// See also [fetchLogList].
@ProviderFor(fetchLogList)
final fetchLogListProvider = AutoDisposeFutureProvider<List<LogModel>>.internal(
  fetchLogList,
  name: r'fetchLogListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchLogListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchLogListRef = AutoDisposeFutureProviderRef<List<LogModel>>;
String _$fetchOrderListLast3daysHash() =>
    r'c290e4b30f8ca3562baf41f43378f19e49e4155c';

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

/// See also [fetchOrderListLast3days].
@ProviderFor(fetchOrderListLast3days)
const fetchOrderListLast3daysProvider = FetchOrderListLast3daysFamily();

/// See also [fetchOrderListLast3days].
class FetchOrderListLast3daysFamily extends Family<AsyncValue<List<OrderX>>> {
  /// See also [fetchOrderListLast3days].
  const FetchOrderListLast3daysFamily();

  /// See also [fetchOrderListLast3days].
  FetchOrderListLast3daysProvider call({
    required String uId,
  }) {
    return FetchOrderListLast3daysProvider(
      uId: uId,
    );
  }

  @override
  FetchOrderListLast3daysProvider getProviderOverride(
    covariant FetchOrderListLast3daysProvider provider,
  ) {
    return call(
      uId: provider.uId,
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
  String? get name => r'fetchOrderListLast3daysProvider';
}

/// See also [fetchOrderListLast3days].
class FetchOrderListLast3daysProvider
    extends AutoDisposeFutureProvider<List<OrderX>> {
  /// See also [fetchOrderListLast3days].
  FetchOrderListLast3daysProvider({
    required String uId,
  }) : this._internal(
          (ref) => fetchOrderListLast3days(
            ref as FetchOrderListLast3daysRef,
            uId: uId,
          ),
          from: fetchOrderListLast3daysProvider,
          name: r'fetchOrderListLast3daysProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchOrderListLast3daysHash,
          dependencies: FetchOrderListLast3daysFamily._dependencies,
          allTransitiveDependencies:
              FetchOrderListLast3daysFamily._allTransitiveDependencies,
          uId: uId,
        );

  FetchOrderListLast3daysProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uId,
  }) : super.internal();

  final String uId;

  @override
  Override overrideWith(
    FutureOr<List<OrderX>> Function(FetchOrderListLast3daysRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchOrderListLast3daysProvider._internal(
        (ref) => create(ref as FetchOrderListLast3daysRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uId: uId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OrderX>> createElement() {
    return _FetchOrderListLast3daysProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchOrderListLast3daysProvider && other.uId == uId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchOrderListLast3daysRef on AutoDisposeFutureProviderRef<List<OrderX>> {
  /// The parameter `uId` of this provider.
  String get uId;
}

class _FetchOrderListLast3daysProviderElement
    extends AutoDisposeFutureProviderElement<List<OrderX>>
    with FetchOrderListLast3daysRef {
  _FetchOrderListLast3daysProviderElement(super.provider);

  @override
  String get uId => (origin as FetchOrderListLast3daysProvider).uId;
}

String _$fetchMainOrderListLast3daysHash() =>
    r'eb1e600232bfe3851a4fa633f25682afc4a5e872';

/// See also [fetchMainOrderListLast3days].
@ProviderFor(fetchMainOrderListLast3days)
const fetchMainOrderListLast3daysProvider = FetchMainOrderListLast3daysFamily();

/// See also [fetchMainOrderListLast3days].
class FetchMainOrderListLast3daysFamily
    extends Family<AsyncValue<List<MainOrder>>> {
  /// See also [fetchMainOrderListLast3days].
  const FetchMainOrderListLast3daysFamily();

  /// See also [fetchMainOrderListLast3days].
  FetchMainOrderListLast3daysProvider call({
    bool forActualDelivery = false,
  }) {
    return FetchMainOrderListLast3daysProvider(
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  FetchMainOrderListLast3daysProvider getProviderOverride(
    covariant FetchMainOrderListLast3daysProvider provider,
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
  String? get name => r'fetchMainOrderListLast3daysProvider';
}

/// See also [fetchMainOrderListLast3days].
class FetchMainOrderListLast3daysProvider
    extends AutoDisposeFutureProvider<List<MainOrder>> {
  /// See also [fetchMainOrderListLast3days].
  FetchMainOrderListLast3daysProvider({
    bool forActualDelivery = false,
  }) : this._internal(
          (ref) => fetchMainOrderListLast3days(
            ref as FetchMainOrderListLast3daysRef,
            forActualDelivery: forActualDelivery,
          ),
          from: fetchMainOrderListLast3daysProvider,
          name: r'fetchMainOrderListLast3daysProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMainOrderListLast3daysHash,
          dependencies: FetchMainOrderListLast3daysFamily._dependencies,
          allTransitiveDependencies:
              FetchMainOrderListLast3daysFamily._allTransitiveDependencies,
          forActualDelivery: forActualDelivery,
        );

  FetchMainOrderListLast3daysProvider._internal(
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
    FutureOr<List<MainOrder>> Function(FetchMainOrderListLast3daysRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchMainOrderListLast3daysProvider._internal(
        (ref) => create(ref as FetchMainOrderListLast3daysRef),
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
  AutoDisposeFutureProviderElement<List<MainOrder>> createElement() {
    return _FetchMainOrderListLast3daysProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchMainOrderListLast3daysProvider &&
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
mixin FetchMainOrderListLast3daysRef
    on AutoDisposeFutureProviderRef<List<MainOrder>> {
  /// The parameter `forActualDelivery` of this provider.
  bool get forActualDelivery;
}

class _FetchMainOrderListLast3daysProviderElement
    extends AutoDisposeFutureProviderElement<List<MainOrder>>
    with FetchMainOrderListLast3daysRef {
  _FetchMainOrderListLast3daysProviderElement(super.provider);

  @override
  bool get forActualDelivery =>
      (origin as FetchMainOrderListLast3daysProvider).forActualDelivery;
}

String _$fetchOrderHash() => r'6a908e094e80b24d07c6248a9d9cdd729f834cd7';

/// See also [fetchOrder].
@ProviderFor(fetchOrder)
const fetchOrderProvider = FetchOrderFamily();

/// See also [fetchOrder].
class FetchOrderFamily extends Family<AsyncValue<OrderX?>> {
  /// See also [fetchOrder].
  const FetchOrderFamily();

  /// See also [fetchOrder].
  FetchOrderProvider call({
    required String uId,
    required DateTime day,
  }) {
    return FetchOrderProvider(
      uId: uId,
      day: day,
    );
  }

  @override
  FetchOrderProvider getProviderOverride(
    covariant FetchOrderProvider provider,
  ) {
    return call(
      uId: provider.uId,
      day: provider.day,
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
  String? get name => r'fetchOrderProvider';
}

/// See also [fetchOrder].
class FetchOrderProvider extends AutoDisposeFutureProvider<OrderX?> {
  /// See also [fetchOrder].
  FetchOrderProvider({
    required String uId,
    required DateTime day,
  }) : this._internal(
          (ref) => fetchOrder(
            ref as FetchOrderRef,
            uId: uId,
            day: day,
          ),
          from: fetchOrderProvider,
          name: r'fetchOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchOrderHash,
          dependencies: FetchOrderFamily._dependencies,
          allTransitiveDependencies:
              FetchOrderFamily._allTransitiveDependencies,
          uId: uId,
          day: day,
        );

  FetchOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uId,
    required this.day,
  }) : super.internal();

  final String uId;
  final DateTime day;

  @override
  Override overrideWith(
    FutureOr<OrderX?> Function(FetchOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchOrderProvider._internal(
        (ref) => create(ref as FetchOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uId: uId,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OrderX?> createElement() {
    return _FetchOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchOrderProvider && other.uId == uId && other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uId.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchOrderRef on AutoDisposeFutureProviderRef<OrderX?> {
  /// The parameter `uId` of this provider.
  String get uId;

  /// The parameter `day` of this provider.
  DateTime get day;
}

class _FetchOrderProviderElement
    extends AutoDisposeFutureProviderElement<OrderX?> with FetchOrderRef {
  _FetchOrderProviderElement(super.provider);

  @override
  String get uId => (origin as FetchOrderProvider).uId;
  @override
  DateTime get day => (origin as FetchOrderProvider).day;
}

String _$didUserOrderHash() => r'a3bbc93eaf87a4fae133b076271b0c97feb441bd';

/// See also [didUserOrder].
@ProviderFor(didUserOrder)
const didUserOrderProvider = DidUserOrderFamily();

/// See also [didUserOrder].
class DidUserOrderFamily extends Family<AsyncValue<bool>> {
  /// See also [didUserOrder].
  const DidUserOrderFamily();

  /// See also [didUserOrder].
  DidUserOrderProvider call({
    required String uId,
  }) {
    return DidUserOrderProvider(
      uId: uId,
    );
  }

  @override
  DidUserOrderProvider getProviderOverride(
    covariant DidUserOrderProvider provider,
  ) {
    return call(
      uId: provider.uId,
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
  String? get name => r'didUserOrderProvider';
}

/// See also [didUserOrder].
class DidUserOrderProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [didUserOrder].
  DidUserOrderProvider({
    required String uId,
  }) : this._internal(
          (ref) => didUserOrder(
            ref as DidUserOrderRef,
            uId: uId,
          ),
          from: didUserOrderProvider,
          name: r'didUserOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$didUserOrderHash,
          dependencies: DidUserOrderFamily._dependencies,
          allTransitiveDependencies:
              DidUserOrderFamily._allTransitiveDependencies,
          uId: uId,
        );

  DidUserOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uId,
  }) : super.internal();

  final String uId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DidUserOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DidUserOrderProvider._internal(
        (ref) => create(ref as DidUserOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uId: uId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DidUserOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DidUserOrderProvider && other.uId == uId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DidUserOrderRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `uId` of this provider.
  String get uId;
}

class _DidUserOrderProviderElement
    extends AutoDisposeFutureProviderElement<bool> with DidUserOrderRef {
  _DidUserOrderProviderElement(super.provider);

  @override
  String get uId => (origin as DidUserOrderProvider).uId;
}

String _$doesOrderExistForNextDayHash() =>
    r'c0287b2a146ce2b5cb85b7d290576176310cb4aa';

/// See also [doesOrderExistForNextDay].
@ProviderFor(doesOrderExistForNextDay)
const doesOrderExistForNextDayProvider = DoesOrderExistForNextDayFamily();

/// See also [doesOrderExistForNextDay].
class DoesOrderExistForNextDayFamily extends Family<AsyncValue<bool>> {
  /// See also [doesOrderExistForNextDay].
  const DoesOrderExistForNextDayFamily();

  /// See also [doesOrderExistForNextDay].
  DoesOrderExistForNextDayProvider call({
    required String uId,
  }) {
    return DoesOrderExistForNextDayProvider(
      uId: uId,
    );
  }

  @override
  DoesOrderExistForNextDayProvider getProviderOverride(
    covariant DoesOrderExistForNextDayProvider provider,
  ) {
    return call(
      uId: provider.uId,
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
  String? get name => r'doesOrderExistForNextDayProvider';
}

/// See also [doesOrderExistForNextDay].
class DoesOrderExistForNextDayProvider extends FutureProvider<bool> {
  /// See also [doesOrderExistForNextDay].
  DoesOrderExistForNextDayProvider({
    required String uId,
  }) : this._internal(
          (ref) => doesOrderExistForNextDay(
            ref as DoesOrderExistForNextDayRef,
            uId: uId,
          ),
          from: doesOrderExistForNextDayProvider,
          name: r'doesOrderExistForNextDayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$doesOrderExistForNextDayHash,
          dependencies: DoesOrderExistForNextDayFamily._dependencies,
          allTransitiveDependencies:
              DoesOrderExistForNextDayFamily._allTransitiveDependencies,
          uId: uId,
        );

  DoesOrderExistForNextDayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uId,
  }) : super.internal();

  final String uId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DoesOrderExistForNextDayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DoesOrderExistForNextDayProvider._internal(
        (ref) => create(ref as DoesOrderExistForNextDayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uId: uId,
      ),
    );
  }

  @override
  FutureProviderElement<bool> createElement() {
    return _DoesOrderExistForNextDayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DoesOrderExistForNextDayProvider && other.uId == uId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DoesOrderExistForNextDayRef on FutureProviderRef<bool> {
  /// The parameter `uId` of this provider.
  String get uId;
}

class _DoesOrderExistForNextDayProviderElement
    extends FutureProviderElement<bool> with DoesOrderExistForNextDayRef {
  _DoesOrderExistForNextDayProviderElement(super.provider);

  @override
  String get uId => (origin as DoesOrderExistForNextDayProvider).uId;
}

String _$fetchAdminsAndSuperAdminsListHash() =>
    r'978a9ee63403173985ad723a9fd24ad3ca48732f';

/// See also [fetchAdminsAndSuperAdminsList].
@ProviderFor(fetchAdminsAndSuperAdminsList)
final fetchAdminsAndSuperAdminsListProvider =
    AutoDisposeFutureProvider<List<UserX>>.internal(
  fetchAdminsAndSuperAdminsList,
  name: r'fetchAdminsAndSuperAdminsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAdminsAndSuperAdminsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchAdminsAndSuperAdminsListRef
    = AutoDisposeFutureProviderRef<List<UserX>>;
String _$fetchUserStreamHash() => r'634ca841e639c08035514832c066abe7fc16efdb';

/// See also [fetchUserStream].
@ProviderFor(fetchUserStream)
const fetchUserStreamProvider = FetchUserStreamFamily();

/// See also [fetchUserStream].
class FetchUserStreamFamily extends Family<AsyncValue<UserX?>> {
  /// See also [fetchUserStream].
  const FetchUserStreamFamily();

  /// See also [fetchUserStream].
  FetchUserStreamProvider call({
    required String uId,
  }) {
    return FetchUserStreamProvider(
      uId: uId,
    );
  }

  @override
  FetchUserStreamProvider getProviderOverride(
    covariant FetchUserStreamProvider provider,
  ) {
    return call(
      uId: provider.uId,
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
  String? get name => r'fetchUserStreamProvider';
}

/// See also [fetchUserStream].
class FetchUserStreamProvider extends AutoDisposeStreamProvider<UserX?> {
  /// See also [fetchUserStream].
  FetchUserStreamProvider({
    required String uId,
  }) : this._internal(
          (ref) => fetchUserStream(
            ref as FetchUserStreamRef,
            uId: uId,
          ),
          from: fetchUserStreamProvider,
          name: r'fetchUserStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchUserStreamHash,
          dependencies: FetchUserStreamFamily._dependencies,
          allTransitiveDependencies:
              FetchUserStreamFamily._allTransitiveDependencies,
          uId: uId,
        );

  FetchUserStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uId,
  }) : super.internal();

  final String uId;

  @override
  Override overrideWith(
    Stream<UserX?> Function(FetchUserStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchUserStreamProvider._internal(
        (ref) => create(ref as FetchUserStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uId: uId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UserX?> createElement() {
    return _FetchUserStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchUserStreamProvider && other.uId == uId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchUserStreamRef on AutoDisposeStreamProviderRef<UserX?> {
  /// The parameter `uId` of this provider.
  String get uId;
}

class _FetchUserStreamProviderElement
    extends AutoDisposeStreamProviderElement<UserX?> with FetchUserStreamRef {
  _FetchUserStreamProviderElement(super.provider);

  @override
  String get uId => (origin as FetchUserStreamProvider).uId;
}

String _$fetchUserHash() => r'449bb41def39e165d5feb27208553c48b4e7ab72';

/// See also [fetchUser].
@ProviderFor(fetchUser)
const fetchUserProvider = FetchUserFamily();

/// See also [fetchUser].
class FetchUserFamily extends Family<AsyncValue<UserX?>> {
  /// See also [fetchUser].
  const FetchUserFamily();

  /// See also [fetchUser].
  FetchUserProvider call({
    required String documentId,
  }) {
    return FetchUserProvider(
      documentId: documentId,
    );
  }

  @override
  FetchUserProvider getProviderOverride(
    covariant FetchUserProvider provider,
  ) {
    return call(
      documentId: provider.documentId,
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
  String? get name => r'fetchUserProvider';
}

/// See also [fetchUser].
class FetchUserProvider extends AutoDisposeFutureProvider<UserX?> {
  /// See also [fetchUser].
  FetchUserProvider({
    required String documentId,
  }) : this._internal(
          (ref) => fetchUser(
            ref as FetchUserRef,
            documentId: documentId,
          ),
          from: fetchUserProvider,
          name: r'fetchUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchUserHash,
          dependencies: FetchUserFamily._dependencies,
          allTransitiveDependencies: FetchUserFamily._allTransitiveDependencies,
          documentId: documentId,
        );

  FetchUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.documentId,
  }) : super.internal();

  final String documentId;

  @override
  Override overrideWith(
    FutureOr<UserX?> Function(FetchUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchUserProvider._internal(
        (ref) => create(ref as FetchUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        documentId: documentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserX?> createElement() {
    return _FetchUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchUserProvider && other.documentId == documentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, documentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchUserRef on AutoDisposeFutureProviderRef<UserX?> {
  /// The parameter `documentId` of this provider.
  String get documentId;
}

class _FetchUserProviderElement extends AutoDisposeFutureProviderElement<UserX?>
    with FetchUserRef {
  _FetchUserProviderElement(super.provider);

  @override
  String get documentId => (origin as FetchUserProvider).documentId;
}

String _$fetchAppManagementHash() =>
    r'379e93a4aa610d8c8a806698f7b9235c8f4b41b3';

/// See also [fetchAppManagement].
@ProviderFor(fetchAppManagement)
const fetchAppManagementProvider = FetchAppManagementFamily();

/// See also [fetchAppManagement].
class FetchAppManagementFamily extends Family<AsyncValue<UserX?>> {
  /// See also [fetchAppManagement].
  const FetchAppManagementFamily();

  /// See also [fetchAppManagement].
  FetchAppManagementProvider call({
    required String documentId,
  }) {
    return FetchAppManagementProvider(
      documentId: documentId,
    );
  }

  @override
  FetchAppManagementProvider getProviderOverride(
    covariant FetchAppManagementProvider provider,
  ) {
    return call(
      documentId: provider.documentId,
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
  String? get name => r'fetchAppManagementProvider';
}

/// See also [fetchAppManagement].
class FetchAppManagementProvider extends AutoDisposeFutureProvider<UserX?> {
  /// See also [fetchAppManagement].
  FetchAppManagementProvider({
    required String documentId,
  }) : this._internal(
          (ref) => fetchAppManagement(
            ref as FetchAppManagementRef,
            documentId: documentId,
          ),
          from: fetchAppManagementProvider,
          name: r'fetchAppManagementProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchAppManagementHash,
          dependencies: FetchAppManagementFamily._dependencies,
          allTransitiveDependencies:
              FetchAppManagementFamily._allTransitiveDependencies,
          documentId: documentId,
        );

  FetchAppManagementProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.documentId,
  }) : super.internal();

  final String documentId;

  @override
  Override overrideWith(
    FutureOr<UserX?> Function(FetchAppManagementRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchAppManagementProvider._internal(
        (ref) => create(ref as FetchAppManagementRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        documentId: documentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserX?> createElement() {
    return _FetchAppManagementProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAppManagementProvider &&
        other.documentId == documentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, documentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchAppManagementRef on AutoDisposeFutureProviderRef<UserX?> {
  /// The parameter `documentId` of this provider.
  String get documentId;
}

class _FetchAppManagementProviderElement
    extends AutoDisposeFutureProviderElement<UserX?>
    with FetchAppManagementRef {
  _FetchAppManagementProviderElement(super.provider);

  @override
  String get documentId => (origin as FetchAppManagementProvider).documentId;
}

String _$fetchDeletedUserHash() => r'd4a44b9db92fddbfc516983df9e90660c81ab8b3';

/// See also [fetchDeletedUser].
@ProviderFor(fetchDeletedUser)
const fetchDeletedUserProvider = FetchDeletedUserFamily();

/// See also [fetchDeletedUser].
class FetchDeletedUserFamily extends Family<AsyncValue<UserX?>> {
  /// See also [fetchDeletedUser].
  const FetchDeletedUserFamily();

  /// See also [fetchDeletedUser].
  FetchDeletedUserProvider call({
    required String documentId,
  }) {
    return FetchDeletedUserProvider(
      documentId: documentId,
    );
  }

  @override
  FetchDeletedUserProvider getProviderOverride(
    covariant FetchDeletedUserProvider provider,
  ) {
    return call(
      documentId: provider.documentId,
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
  String? get name => r'fetchDeletedUserProvider';
}

/// See also [fetchDeletedUser].
class FetchDeletedUserProvider extends AutoDisposeFutureProvider<UserX?> {
  /// See also [fetchDeletedUser].
  FetchDeletedUserProvider({
    required String documentId,
  }) : this._internal(
          (ref) => fetchDeletedUser(
            ref as FetchDeletedUserRef,
            documentId: documentId,
          ),
          from: fetchDeletedUserProvider,
          name: r'fetchDeletedUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchDeletedUserHash,
          dependencies: FetchDeletedUserFamily._dependencies,
          allTransitiveDependencies:
              FetchDeletedUserFamily._allTransitiveDependencies,
          documentId: documentId,
        );

  FetchDeletedUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.documentId,
  }) : super.internal();

  final String documentId;

  @override
  Override overrideWith(
    FutureOr<UserX?> Function(FetchDeletedUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchDeletedUserProvider._internal(
        (ref) => create(ref as FetchDeletedUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        documentId: documentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserX?> createElement() {
    return _FetchDeletedUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchDeletedUserProvider && other.documentId == documentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, documentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchDeletedUserRef on AutoDisposeFutureProviderRef<UserX?> {
  /// The parameter `documentId` of this provider.
  String get documentId;
}

class _FetchDeletedUserProviderElement
    extends AutoDisposeFutureProviderElement<UserX?> with FetchDeletedUserRef {
  _FetchDeletedUserProviderElement(super.provider);

  @override
  String get documentId => (origin as FetchDeletedUserProvider).documentId;
}

String _$fetchUserByComparisonPhoneStreamHash() =>
    r'e07ab8f50261ae065848d9fc841cf1b30c574d57';

/// See also [fetchUserByComparisonPhoneStream].
@ProviderFor(fetchUserByComparisonPhoneStream)
const fetchUserByComparisonPhoneStreamProvider =
    FetchUserByComparisonPhoneStreamFamily();

/// See also [fetchUserByComparisonPhoneStream].
class FetchUserByComparisonPhoneStreamFamily
    extends Family<AsyncValue<UserX?>> {
  /// See also [fetchUserByComparisonPhoneStream].
  const FetchUserByComparisonPhoneStreamFamily();

  /// See also [fetchUserByComparisonPhoneStream].
  FetchUserByComparisonPhoneStreamProvider call({
    required String phoneNumber,
  }) {
    return FetchUserByComparisonPhoneStreamProvider(
      phoneNumber: phoneNumber,
    );
  }

  @override
  FetchUserByComparisonPhoneStreamProvider getProviderOverride(
    covariant FetchUserByComparisonPhoneStreamProvider provider,
  ) {
    return call(
      phoneNumber: provider.phoneNumber,
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
  String? get name => r'fetchUserByComparisonPhoneStreamProvider';
}

/// See also [fetchUserByComparisonPhoneStream].
class FetchUserByComparisonPhoneStreamProvider
    extends AutoDisposeStreamProvider<UserX?> {
  /// See also [fetchUserByComparisonPhoneStream].
  FetchUserByComparisonPhoneStreamProvider({
    required String phoneNumber,
  }) : this._internal(
          (ref) => fetchUserByComparisonPhoneStream(
            ref as FetchUserByComparisonPhoneStreamRef,
            phoneNumber: phoneNumber,
          ),
          from: fetchUserByComparisonPhoneStreamProvider,
          name: r'fetchUserByComparisonPhoneStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchUserByComparisonPhoneStreamHash,
          dependencies: FetchUserByComparisonPhoneStreamFamily._dependencies,
          allTransitiveDependencies:
              FetchUserByComparisonPhoneStreamFamily._allTransitiveDependencies,
          phoneNumber: phoneNumber,
        );

  FetchUserByComparisonPhoneStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.phoneNumber,
  }) : super.internal();

  final String phoneNumber;

  @override
  Override overrideWith(
    Stream<UserX?> Function(FetchUserByComparisonPhoneStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchUserByComparisonPhoneStreamProvider._internal(
        (ref) => create(ref as FetchUserByComparisonPhoneStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UserX?> createElement() {
    return _FetchUserByComparisonPhoneStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchUserByComparisonPhoneStreamProvider &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phoneNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchUserByComparisonPhoneStreamRef
    on AutoDisposeStreamProviderRef<UserX?> {
  /// The parameter `phoneNumber` of this provider.
  String get phoneNumber;
}

class _FetchUserByComparisonPhoneStreamProviderElement
    extends AutoDisposeStreamProviderElement<UserX?>
    with FetchUserByComparisonPhoneStreamRef {
  _FetchUserByComparisonPhoneStreamProviderElement(super.provider);

  @override
  String get phoneNumber =>
      (origin as FetchUserByComparisonPhoneStreamProvider).phoneNumber;
}

String _$orderRulesStreamHash() => r'9b25a9b93815eb5ee011968cd6d043f1c8a3ce10';

/// See also [OrderRulesStream].
@ProviderFor(OrderRulesStream)
final orderRulesStreamProvider =
    AsyncNotifierProvider<OrderRulesStream, OrderRules?>.internal(
  OrderRulesStream.new,
  name: r'orderRulesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRulesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderRulesStream = AsyncNotifier<OrderRules?>;
String _$orderRulesXHash() => r'1b5354e5244a0afc68a418fcd52b52e63f7cf890';

/// See also [OrderRulesX].
@ProviderFor(OrderRulesX)
final orderRulesXProvider =
    AutoDisposeAsyncNotifierProvider<OrderRulesX, void>.internal(
  OrderRulesX.new,
  name: r'orderRulesXProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderRulesXHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderRulesX = AutoDisposeAsyncNotifier<void>;
String _$ordersStreamXHash() => r'32b233a92219644fb05511c6c7a44a6db31876fe';

abstract class _$OrdersStreamX extends BuildlessAsyncNotifier<List<OrderX>> {
  late final bool forActualDelivery;

  FutureOr<List<OrderX>> build({
    bool forActualDelivery = false,
  });
}

/// See also [OrdersStreamX].
@ProviderFor(OrdersStreamX)
const ordersStreamXProvider = OrdersStreamXFamily();

/// See also [OrdersStreamX].
class OrdersStreamXFamily extends Family<AsyncValue<List<OrderX>>> {
  /// See also [OrdersStreamX].
  const OrdersStreamXFamily();

  /// See also [OrdersStreamX].
  OrdersStreamXProvider call({
    bool forActualDelivery = false,
  }) {
    return OrdersStreamXProvider(
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  OrdersStreamXProvider getProviderOverride(
    covariant OrdersStreamXProvider provider,
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
  String? get name => r'ordersStreamXProvider';
}

/// See also [OrdersStreamX].
class OrdersStreamXProvider
    extends AsyncNotifierProviderImpl<OrdersStreamX, List<OrderX>> {
  /// See also [OrdersStreamX].
  OrdersStreamXProvider({
    bool forActualDelivery = false,
  }) : this._internal(
          () => OrdersStreamX()..forActualDelivery = forActualDelivery,
          from: ordersStreamXProvider,
          name: r'ordersStreamXProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ordersStreamXHash,
          dependencies: OrdersStreamXFamily._dependencies,
          allTransitiveDependencies:
              OrdersStreamXFamily._allTransitiveDependencies,
          forActualDelivery: forActualDelivery,
        );

  OrdersStreamXProvider._internal(
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
  FutureOr<List<OrderX>> runNotifierBuild(
    covariant OrdersStreamX notifier,
  ) {
    return notifier.build(
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  Override overrideWith(OrdersStreamX Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrdersStreamXProvider._internal(
        () => create()..forActualDelivery = forActualDelivery,
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
  AsyncNotifierProviderElement<OrdersStreamX, List<OrderX>> createElement() {
    return _OrdersStreamXProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrdersStreamXProvider &&
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
mixin OrdersStreamXRef on AsyncNotifierProviderRef<List<OrderX>> {
  /// The parameter `forActualDelivery` of this provider.
  bool get forActualDelivery;
}

class _OrdersStreamXProviderElement
    extends AsyncNotifierProviderElement<OrdersStreamX, List<OrderX>>
    with OrdersStreamXRef {
  _OrdersStreamXProviderElement(super.provider);

  @override
  bool get forActualDelivery =>
      (origin as OrdersStreamXProvider).forActualDelivery;
}

String _$mainOrderStreamHash() => r'6fc00c04bf5f0eba1039ad1cc261fc3e5815831e';

abstract class _$MainOrderStream extends BuildlessAsyncNotifier<MainOrder?> {
  late final String id;
  late final bool forActualDelivery;

  FutureOr<MainOrder?> build({
    required String id,
    bool forActualDelivery = false,
  });
}

/// See also [MainOrderStream].
@ProviderFor(MainOrderStream)
const mainOrderStreamProvider = MainOrderStreamFamily();

/// See also [MainOrderStream].
class MainOrderStreamFamily extends Family<AsyncValue<MainOrder?>> {
  /// See also [MainOrderStream].
  const MainOrderStreamFamily();

  /// See also [MainOrderStream].
  MainOrderStreamProvider call({
    required String id,
    bool forActualDelivery = false,
  }) {
    return MainOrderStreamProvider(
      id: id,
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  MainOrderStreamProvider getProviderOverride(
    covariant MainOrderStreamProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'mainOrderStreamProvider';
}

/// See also [MainOrderStream].
class MainOrderStreamProvider
    extends AsyncNotifierProviderImpl<MainOrderStream, MainOrder?> {
  /// See also [MainOrderStream].
  MainOrderStreamProvider({
    required String id,
    bool forActualDelivery = false,
  }) : this._internal(
          () => MainOrderStream()
            ..id = id
            ..forActualDelivery = forActualDelivery,
          from: mainOrderStreamProvider,
          name: r'mainOrderStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mainOrderStreamHash,
          dependencies: MainOrderStreamFamily._dependencies,
          allTransitiveDependencies:
              MainOrderStreamFamily._allTransitiveDependencies,
          id: id,
          forActualDelivery: forActualDelivery,
        );

  MainOrderStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.forActualDelivery,
  }) : super.internal();

  final String id;
  final bool forActualDelivery;

  @override
  FutureOr<MainOrder?> runNotifierBuild(
    covariant MainOrderStream notifier,
  ) {
    return notifier.build(
      id: id,
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  Override overrideWith(MainOrderStream Function() create) {
    return ProviderOverride(
      origin: this,
      override: MainOrderStreamProvider._internal(
        () => create()
          ..id = id
          ..forActualDelivery = forActualDelivery,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        forActualDelivery: forActualDelivery,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<MainOrderStream, MainOrder?> createElement() {
    return _MainOrderStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MainOrderStreamProvider &&
        other.id == id &&
        other.forActualDelivery == forActualDelivery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, forActualDelivery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MainOrderStreamRef on AsyncNotifierProviderRef<MainOrder?> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `forActualDelivery` of this provider.
  bool get forActualDelivery;
}

class _MainOrderStreamProviderElement
    extends AsyncNotifierProviderElement<MainOrderStream, MainOrder?>
    with MainOrderStreamRef {
  _MainOrderStreamProviderElement(super.provider);

  @override
  String get id => (origin as MainOrderStreamProvider).id;
  @override
  bool get forActualDelivery =>
      (origin as MainOrderStreamProvider).forActualDelivery;
}

String _$productLinesStreamHash() =>
    r'99ec0eb728a6b6bf5f25648d709be699d415ff41';

abstract class _$ProductLinesStream
    extends BuildlessAsyncNotifier<List<ProductLine>> {
  late final String id;
  late final bool forActualDelivery;

  FutureOr<List<ProductLine>> build({
    required String id,
    bool forActualDelivery = false,
  });
}

/// See also [ProductLinesStream].
@ProviderFor(ProductLinesStream)
const productLinesStreamProvider = ProductLinesStreamFamily();

/// See also [ProductLinesStream].
class ProductLinesStreamFamily extends Family<AsyncValue<List<ProductLine>>> {
  /// See also [ProductLinesStream].
  const ProductLinesStreamFamily();

  /// See also [ProductLinesStream].
  ProductLinesStreamProvider call({
    required String id,
    bool forActualDelivery = false,
  }) {
    return ProductLinesStreamProvider(
      id: id,
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  ProductLinesStreamProvider getProviderOverride(
    covariant ProductLinesStreamProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'productLinesStreamProvider';
}

/// See also [ProductLinesStream].
class ProductLinesStreamProvider
    extends AsyncNotifierProviderImpl<ProductLinesStream, List<ProductLine>> {
  /// See also [ProductLinesStream].
  ProductLinesStreamProvider({
    required String id,
    bool forActualDelivery = false,
  }) : this._internal(
          () => ProductLinesStream()
            ..id = id
            ..forActualDelivery = forActualDelivery,
          from: productLinesStreamProvider,
          name: r'productLinesStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productLinesStreamHash,
          dependencies: ProductLinesStreamFamily._dependencies,
          allTransitiveDependencies:
              ProductLinesStreamFamily._allTransitiveDependencies,
          id: id,
          forActualDelivery: forActualDelivery,
        );

  ProductLinesStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.forActualDelivery,
  }) : super.internal();

  final String id;
  final bool forActualDelivery;

  @override
  FutureOr<List<ProductLine>> runNotifierBuild(
    covariant ProductLinesStream notifier,
  ) {
    return notifier.build(
      id: id,
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  Override overrideWith(ProductLinesStream Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductLinesStreamProvider._internal(
        () => create()
          ..id = id
          ..forActualDelivery = forActualDelivery,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        forActualDelivery: forActualDelivery,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<ProductLinesStream, List<ProductLine>>
      createElement() {
    return _ProductLinesStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductLinesStreamProvider &&
        other.id == id &&
        other.forActualDelivery == forActualDelivery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, forActualDelivery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductLinesStreamRef on AsyncNotifierProviderRef<List<ProductLine>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `forActualDelivery` of this provider.
  bool get forActualDelivery;
}

class _ProductLinesStreamProviderElement
    extends AsyncNotifierProviderElement<ProductLinesStream, List<ProductLine>>
    with ProductLinesStreamRef {
  _ProductLinesStreamProviderElement(super.provider);

  @override
  String get id => (origin as ProductLinesStreamProvider).id;
  @override
  bool get forActualDelivery =>
      (origin as ProductLinesStreamProvider).forActualDelivery;
}

String _$demandLinesStreamHash() => r'c3b566b7c7b523125e228efa8faf3243c25e2d92';

abstract class _$DemandLinesStream
    extends BuildlessAsyncNotifier<List<DemandLine>> {
  late final String id;
  late final bool forActualDelivery;

  FutureOr<List<DemandLine>> build({
    required String id,
    bool forActualDelivery = false,
  });
}

/// See also [DemandLinesStream].
@ProviderFor(DemandLinesStream)
const demandLinesStreamProvider = DemandLinesStreamFamily();

/// See also [DemandLinesStream].
class DemandLinesStreamFamily extends Family<AsyncValue<List<DemandLine>>> {
  /// See also [DemandLinesStream].
  const DemandLinesStreamFamily();

  /// See also [DemandLinesStream].
  DemandLinesStreamProvider call({
    required String id,
    bool forActualDelivery = false,
  }) {
    return DemandLinesStreamProvider(
      id: id,
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  DemandLinesStreamProvider getProviderOverride(
    covariant DemandLinesStreamProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'demandLinesStreamProvider';
}

/// See also [DemandLinesStream].
class DemandLinesStreamProvider
    extends AsyncNotifierProviderImpl<DemandLinesStream, List<DemandLine>> {
  /// See also [DemandLinesStream].
  DemandLinesStreamProvider({
    required String id,
    bool forActualDelivery = false,
  }) : this._internal(
          () => DemandLinesStream()
            ..id = id
            ..forActualDelivery = forActualDelivery,
          from: demandLinesStreamProvider,
          name: r'demandLinesStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$demandLinesStreamHash,
          dependencies: DemandLinesStreamFamily._dependencies,
          allTransitiveDependencies:
              DemandLinesStreamFamily._allTransitiveDependencies,
          id: id,
          forActualDelivery: forActualDelivery,
        );

  DemandLinesStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.forActualDelivery,
  }) : super.internal();

  final String id;
  final bool forActualDelivery;

  @override
  FutureOr<List<DemandLine>> runNotifierBuild(
    covariant DemandLinesStream notifier,
  ) {
    return notifier.build(
      id: id,
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  Override overrideWith(DemandLinesStream Function() create) {
    return ProviderOverride(
      origin: this,
      override: DemandLinesStreamProvider._internal(
        () => create()
          ..id = id
          ..forActualDelivery = forActualDelivery,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        forActualDelivery: forActualDelivery,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<DemandLinesStream, List<DemandLine>>
      createElement() {
    return _DemandLinesStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DemandLinesStreamProvider &&
        other.id == id &&
        other.forActualDelivery == forActualDelivery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, forActualDelivery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DemandLinesStreamRef on AsyncNotifierProviderRef<List<DemandLine>> {
  /// The parameter `id` of this provider.
  String get id;

  /// The parameter `forActualDelivery` of this provider.
  bool get forActualDelivery;
}

class _DemandLinesStreamProviderElement
    extends AsyncNotifierProviderElement<DemandLinesStream, List<DemandLine>>
    with DemandLinesStreamRef {
  _DemandLinesStreamProviderElement(super.provider);

  @override
  String get id => (origin as DemandLinesStreamProvider).id;
  @override
  bool get forActualDelivery =>
      (origin as DemandLinesStreamProvider).forActualDelivery;
}

String _$productsStreamXHash() => r'8bba2327ce6a73fd3fbd2a079cf8b7275a78a67f';

/// See also [ProductsStreamX].
@ProviderFor(ProductsStreamX)
final productsStreamXProvider =
    AsyncNotifierProvider<ProductsStreamX, List<Product>>.internal(
  ProductsStreamX.new,
  name: r'productsStreamXProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsStreamXHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductsStreamX = AsyncNotifier<List<Product>>;
String _$discountSectionsStreamXHash() =>
    r'72b8dda254097a6e4a065292f0bb858eaa5d0f26';

/// See also [DiscountSectionsStreamX].
@ProviderFor(DiscountSectionsStreamX)
final discountSectionsStreamXProvider = AsyncNotifierProvider<
    DiscountSectionsStreamX, List<DiscountSection>>.internal(
  DiscountSectionsStreamX.new,
  name: r'discountSectionsStreamXProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$discountSectionsStreamXHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DiscountSectionsStreamX = AsyncNotifier<List<DiscountSection>>;
String _$usersStreamHash() => r'ce9548bf7e769d0e54731bea2515846110f944ac';

/// See also [UsersStream].
@ProviderFor(UsersStream)
final usersStreamProvider =
    AsyncNotifierProvider<UsersStream, List<UserX>>.internal(
  UsersStream.new,
  name: r'usersStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usersStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UsersStream = AsyncNotifier<List<UserX>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
