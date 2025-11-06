// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_manager_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsManagerHash() => r'c34a1de0ef524ebb81d4649d02fd8e94a9adb8e8';

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

/// See also [productsManager].
@ProviderFor(productsManager)
const productsManagerProvider = ProductsManagerFamily();

/// See also [productsManager].
class ProductsManagerFamily extends Family<AsyncValue<ProductsManagerState>> {
  /// See also [productsManager].
  const ProductsManagerFamily();

  /// See also [productsManager].
  ProductsManagerProvider call({
    String? brand,
    String? category,
  }) {
    return ProductsManagerProvider(
      brand: brand,
      category: category,
    );
  }

  @override
  ProductsManagerProvider getProviderOverride(
    covariant ProductsManagerProvider provider,
  ) {
    return call(
      brand: provider.brand,
      category: provider.category,
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
  String? get name => r'productsManagerProvider';
}

/// See also [productsManager].
class ProductsManagerProvider
    extends AutoDisposeFutureProvider<ProductsManagerState> {
  /// See also [productsManager].
  ProductsManagerProvider({
    String? brand,
    String? category,
  }) : this._internal(
          (ref) => productsManager(
            ref as ProductsManagerRef,
            brand: brand,
            category: category,
          ),
          from: productsManagerProvider,
          name: r'productsManagerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productsManagerHash,
          dependencies: ProductsManagerFamily._dependencies,
          allTransitiveDependencies:
              ProductsManagerFamily._allTransitiveDependencies,
          brand: brand,
          category: category,
        );

  ProductsManagerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.brand,
    required this.category,
  }) : super.internal();

  final String? brand;
  final String? category;

  @override
  Override overrideWith(
    FutureOr<ProductsManagerState> Function(ProductsManagerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsManagerProvider._internal(
        (ref) => create(ref as ProductsManagerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        brand: brand,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProductsManagerState> createElement() {
    return _ProductsManagerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsManagerProvider &&
        other.brand == brand &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brand.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsManagerRef on AutoDisposeFutureProviderRef<ProductsManagerState> {
  /// The parameter `brand` of this provider.
  String? get brand;

  /// The parameter `category` of this provider.
  String? get category;
}

class _ProductsManagerProviderElement
    extends AutoDisposeFutureProviderElement<ProductsManagerState>
    with ProductsManagerRef {
  _ProductsManagerProviderElement(super.provider);

  @override
  String? get brand => (origin as ProductsManagerProvider).brand;
  @override
  String? get category => (origin as ProductsManagerProvider).category;
}

String _$productsManagerServiceHash() =>
    r'97874612a6d1ac016800150834e13bdd46ed32da';

/// See also [productsManagerService].
@ProviderFor(productsManagerService)
final productsManagerServiceProvider =
    AutoDisposeProvider<ProductsManagerService>.internal(
  productsManagerService,
  name: r'productsManagerServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsManagerServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsManagerServiceRef
    = AutoDisposeProviderRef<ProductsManagerService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
