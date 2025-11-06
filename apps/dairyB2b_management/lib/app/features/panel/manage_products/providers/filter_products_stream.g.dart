// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_products_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredProductsStreamHash() =>
    r'b079430ab5a99c3e351b37c5f8ebaa69f51ccab2';

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

/// See also [filteredProductsStream].
@ProviderFor(filteredProductsStream)
const filteredProductsStreamProvider = FilteredProductsStreamFamily();

/// See also [filteredProductsStream].
class FilteredProductsStreamFamily
    extends Family<AsyncValue<List<ProductWithDiscount>>> {
  /// See also [filteredProductsStream].
  const FilteredProductsStreamFamily();

  /// See also [filteredProductsStream].
  FilteredProductsStreamProvider call({
    required Brand brand,
    required Category category,
    required ProductStatus status,
    Duration? updatedWithin,
  }) {
    return FilteredProductsStreamProvider(
      brand: brand,
      category: category,
      status: status,
      updatedWithin: updatedWithin,
    );
  }

  @override
  FilteredProductsStreamProvider getProviderOverride(
    covariant FilteredProductsStreamProvider provider,
  ) {
    return call(
      brand: provider.brand,
      category: provider.category,
      status: provider.status,
      updatedWithin: provider.updatedWithin,
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
  String? get name => r'filteredProductsStreamProvider';
}

/// See also [filteredProductsStream].
class FilteredProductsStreamProvider
    extends AutoDisposeFutureProvider<List<ProductWithDiscount>> {
  /// See also [filteredProductsStream].
  FilteredProductsStreamProvider({
    required Brand brand,
    required Category category,
    required ProductStatus status,
    Duration? updatedWithin,
  }) : this._internal(
          (ref) => filteredProductsStream(
            ref as FilteredProductsStreamRef,
            brand: brand,
            category: category,
            status: status,
            updatedWithin: updatedWithin,
          ),
          from: filteredProductsStreamProvider,
          name: r'filteredProductsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredProductsStreamHash,
          dependencies: FilteredProductsStreamFamily._dependencies,
          allTransitiveDependencies:
              FilteredProductsStreamFamily._allTransitiveDependencies,
          brand: brand,
          category: category,
          status: status,
          updatedWithin: updatedWithin,
        );

  FilteredProductsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.brand,
    required this.category,
    required this.status,
    required this.updatedWithin,
  }) : super.internal();

  final Brand brand;
  final Category category;
  final ProductStatus status;
  final Duration? updatedWithin;

  @override
  Override overrideWith(
    FutureOr<List<ProductWithDiscount>> Function(
            FilteredProductsStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredProductsStreamProvider._internal(
        (ref) => create(ref as FilteredProductsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        brand: brand,
        category: category,
        status: status,
        updatedWithin: updatedWithin,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductWithDiscount>> createElement() {
    return _FilteredProductsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredProductsStreamProvider &&
        other.brand == brand &&
        other.category == category &&
        other.status == status &&
        other.updatedWithin == updatedWithin;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, brand.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);
    hash = _SystemHash.combine(hash, updatedWithin.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredProductsStreamRef
    on AutoDisposeFutureProviderRef<List<ProductWithDiscount>> {
  /// The parameter `brand` of this provider.
  Brand get brand;

  /// The parameter `category` of this provider.
  Category get category;

  /// The parameter `status` of this provider.
  ProductStatus get status;

  /// The parameter `updatedWithin` of this provider.
  Duration? get updatedWithin;
}

class _FilteredProductsStreamProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductWithDiscount>>
    with FilteredProductsStreamRef {
  _FilteredProductsStreamProviderElement(super.provider);

  @override
  Brand get brand => (origin as FilteredProductsStreamProvider).brand;
  @override
  Category get category => (origin as FilteredProductsStreamProvider).category;
  @override
  ProductStatus get status => (origin as FilteredProductsStreamProvider).status;
  @override
  Duration? get updatedWithin =>
      (origin as FilteredProductsStreamProvider).updatedWithin;
}

String _$forJsonXXHash() => r'a9d2a350892c983175ca8e7c12fbfe6afe9dc975';

/// See also [ForJsonXX].
@ProviderFor(ForJsonXX)
final forJsonXXProvider =
    AutoDisposeAsyncNotifierProvider<ForJsonXX, void>.internal(
  ForJsonXX.new,
  name: r'forJsonXXProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$forJsonXXHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ForJsonXX = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
