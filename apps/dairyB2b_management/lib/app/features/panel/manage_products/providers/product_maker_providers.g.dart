// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_maker_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productMakerXHash() => r'e6e30c84b214f6e2664f51d48f96bfd5d81009e7';

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

abstract class _$ProductMakerX
    extends BuildlessAutoDisposeAsyncNotifier<ProductMakerState> {
  late final ProductMakerMode mode;

  FutureOr<ProductMakerState> build({
    required ProductMakerMode mode,
  });
}

/// See also [ProductMakerX].
@ProviderFor(ProductMakerX)
const productMakerXProvider = ProductMakerXFamily();

/// See also [ProductMakerX].
class ProductMakerXFamily extends Family<AsyncValue<ProductMakerState>> {
  /// See also [ProductMakerX].
  const ProductMakerXFamily();

  /// See also [ProductMakerX].
  ProductMakerXProvider call({
    required ProductMakerMode mode,
  }) {
    return ProductMakerXProvider(
      mode: mode,
    );
  }

  @override
  ProductMakerXProvider getProviderOverride(
    covariant ProductMakerXProvider provider,
  ) {
    return call(
      mode: provider.mode,
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
  String? get name => r'productMakerXProvider';
}

/// See also [ProductMakerX].
class ProductMakerXProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ProductMakerX, ProductMakerState> {
  /// See also [ProductMakerX].
  ProductMakerXProvider({
    required ProductMakerMode mode,
  }) : this._internal(
          () => ProductMakerX()..mode = mode,
          from: productMakerXProvider,
          name: r'productMakerXProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productMakerXHash,
          dependencies: ProductMakerXFamily._dependencies,
          allTransitiveDependencies:
              ProductMakerXFamily._allTransitiveDependencies,
          mode: mode,
        );

  ProductMakerXProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mode,
  }) : super.internal();

  final ProductMakerMode mode;

  @override
  FutureOr<ProductMakerState> runNotifierBuild(
    covariant ProductMakerX notifier,
  ) {
    return notifier.build(
      mode: mode,
    );
  }

  @override
  Override overrideWith(ProductMakerX Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductMakerXProvider._internal(
        () => create()..mode = mode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mode: mode,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductMakerX, ProductMakerState>
      createElement() {
    return _ProductMakerXProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductMakerXProvider && other.mode == mode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductMakerXRef
    on AutoDisposeAsyncNotifierProviderRef<ProductMakerState> {
  /// The parameter `mode` of this provider.
  ProductMakerMode get mode;
}

class _ProductMakerXProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductMakerX,
        ProductMakerState> with ProductMakerXRef {
  _ProductMakerXProviderElement(super.provider);

  @override
  ProductMakerMode get mode => (origin as ProductMakerXProvider).mode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
