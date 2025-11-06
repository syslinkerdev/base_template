// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_discounts_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredDiscountsStreamHash() =>
    r'98e447ee05e8df3fe2b73de1557ddbf240692094';

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

/// See also [filteredDiscountsStream].
@ProviderFor(filteredDiscountsStream)
const filteredDiscountsStreamProvider = FilteredDiscountsStreamFamily();

/// See also [filteredDiscountsStream].
class FilteredDiscountsStreamFamily extends Family<AsyncValue<List<Discount>>> {
  /// See also [filteredDiscountsStream].
  const FilteredDiscountsStreamFamily();

  /// See also [filteredDiscountsStream].
  FilteredDiscountsStreamProvider call({
    String? disSectionId,
    DiscountFillFilter? discountFillFilter,
  }) {
    return FilteredDiscountsStreamProvider(
      disSectionId: disSectionId,
      discountFillFilter: discountFillFilter,
    );
  }

  @override
  FilteredDiscountsStreamProvider getProviderOverride(
    covariant FilteredDiscountsStreamProvider provider,
  ) {
    return call(
      disSectionId: provider.disSectionId,
      discountFillFilter: provider.discountFillFilter,
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
  String? get name => r'filteredDiscountsStreamProvider';
}

/// See also [filteredDiscountsStream].
class FilteredDiscountsStreamProvider
    extends AutoDisposeFutureProvider<List<Discount>> {
  /// See also [filteredDiscountsStream].
  FilteredDiscountsStreamProvider({
    String? disSectionId,
    DiscountFillFilter? discountFillFilter,
  }) : this._internal(
          (ref) => filteredDiscountsStream(
            ref as FilteredDiscountsStreamRef,
            disSectionId: disSectionId,
            discountFillFilter: discountFillFilter,
          ),
          from: filteredDiscountsStreamProvider,
          name: r'filteredDiscountsStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredDiscountsStreamHash,
          dependencies: FilteredDiscountsStreamFamily._dependencies,
          allTransitiveDependencies:
              FilteredDiscountsStreamFamily._allTransitiveDependencies,
          disSectionId: disSectionId,
          discountFillFilter: discountFillFilter,
        );

  FilteredDiscountsStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.disSectionId,
    required this.discountFillFilter,
  }) : super.internal();

  final String? disSectionId;
  final DiscountFillFilter? discountFillFilter;

  @override
  Override overrideWith(
    FutureOr<List<Discount>> Function(FilteredDiscountsStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredDiscountsStreamProvider._internal(
        (ref) => create(ref as FilteredDiscountsStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        disSectionId: disSectionId,
        discountFillFilter: discountFillFilter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Discount>> createElement() {
    return _FilteredDiscountsStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredDiscountsStreamProvider &&
        other.disSectionId == disSectionId &&
        other.discountFillFilter == discountFillFilter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, disSectionId.hashCode);
    hash = _SystemHash.combine(hash, discountFillFilter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredDiscountsStreamRef
    on AutoDisposeFutureProviderRef<List<Discount>> {
  /// The parameter `disSectionId` of this provider.
  String? get disSectionId;

  /// The parameter `discountFillFilter` of this provider.
  DiscountFillFilter? get discountFillFilter;
}

class _FilteredDiscountsStreamProviderElement
    extends AutoDisposeFutureProviderElement<List<Discount>>
    with FilteredDiscountsStreamRef {
  _FilteredDiscountsStreamProviderElement(super.provider);

  @override
  String? get disSectionId =>
      (origin as FilteredDiscountsStreamProvider).disSectionId;
  @override
  DiscountFillFilter? get discountFillFilter =>
      (origin as FilteredDiscountsStreamProvider).discountFillFilter;
}

String _$discountProgressHash() => r'5ea0a8a72bf25137b25f0982e5ac042172f4e0a1';

/// See also [discountProgress].
@ProviderFor(discountProgress)
const discountProgressProvider = DiscountProgressFamily();

/// See also [discountProgress].
class DiscountProgressFamily extends Family<AsyncValue<String>> {
  /// See also [discountProgress].
  const DiscountProgressFamily();

  /// See also [discountProgress].
  DiscountProgressProvider call(
    String? disSectionId,
  ) {
    return DiscountProgressProvider(
      disSectionId,
    );
  }

  @override
  DiscountProgressProvider getProviderOverride(
    covariant DiscountProgressProvider provider,
  ) {
    return call(
      provider.disSectionId,
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
  String? get name => r'discountProgressProvider';
}

/// See also [discountProgress].
class DiscountProgressProvider extends AutoDisposeFutureProvider<String> {
  /// See also [discountProgress].
  DiscountProgressProvider(
    String? disSectionId,
  ) : this._internal(
          (ref) => discountProgress(
            ref as DiscountProgressRef,
            disSectionId,
          ),
          from: discountProgressProvider,
          name: r'discountProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$discountProgressHash,
          dependencies: DiscountProgressFamily._dependencies,
          allTransitiveDependencies:
              DiscountProgressFamily._allTransitiveDependencies,
          disSectionId: disSectionId,
        );

  DiscountProgressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.disSectionId,
  }) : super.internal();

  final String? disSectionId;

  @override
  Override overrideWith(
    FutureOr<String> Function(DiscountProgressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DiscountProgressProvider._internal(
        (ref) => create(ref as DiscountProgressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        disSectionId: disSectionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _DiscountProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DiscountProgressProvider &&
        other.disSectionId == disSectionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, disSectionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DiscountProgressRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `disSectionId` of this provider.
  String? get disSectionId;
}

class _DiscountProgressProviderElement
    extends AutoDisposeFutureProviderElement<String> with DiscountProgressRef {
  _DiscountProgressProviderElement(super.provider);

  @override
  String? get disSectionId => (origin as DiscountProgressProvider).disSectionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
