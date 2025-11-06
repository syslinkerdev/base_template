// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_sections_cud.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$discountSectionsCudHash() =>
    r'9f2f1297aad14ec73f56470c5513d09e41e62610';

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

abstract class _$DiscountSectionsCud
    extends BuildlessAutoDisposeNotifier<void> {
  late final String? docPath;

  void build({
    String? docPath,
  });
}

/// See also [DiscountSectionsCud].
@ProviderFor(DiscountSectionsCud)
const discountSectionsCudProvider = DiscountSectionsCudFamily();

/// See also [DiscountSectionsCud].
class DiscountSectionsCudFamily extends Family<void> {
  /// See also [DiscountSectionsCud].
  const DiscountSectionsCudFamily();

  /// See also [DiscountSectionsCud].
  DiscountSectionsCudProvider call({
    String? docPath,
  }) {
    return DiscountSectionsCudProvider(
      docPath: docPath,
    );
  }

  @override
  DiscountSectionsCudProvider getProviderOverride(
    covariant DiscountSectionsCudProvider provider,
  ) {
    return call(
      docPath: provider.docPath,
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
  String? get name => r'discountSectionsCudProvider';
}

/// See also [DiscountSectionsCud].
class DiscountSectionsCudProvider
    extends AutoDisposeNotifierProviderImpl<DiscountSectionsCud, void> {
  /// See also [DiscountSectionsCud].
  DiscountSectionsCudProvider({
    String? docPath,
  }) : this._internal(
          () => DiscountSectionsCud()..docPath = docPath,
          from: discountSectionsCudProvider,
          name: r'discountSectionsCudProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$discountSectionsCudHash,
          dependencies: DiscountSectionsCudFamily._dependencies,
          allTransitiveDependencies:
              DiscountSectionsCudFamily._allTransitiveDependencies,
          docPath: docPath,
        );

  DiscountSectionsCudProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.docPath,
  }) : super.internal();

  final String? docPath;

  @override
  void runNotifierBuild(
    covariant DiscountSectionsCud notifier,
  ) {
    return notifier.build(
      docPath: docPath,
    );
  }

  @override
  Override overrideWith(DiscountSectionsCud Function() create) {
    return ProviderOverride(
      origin: this,
      override: DiscountSectionsCudProvider._internal(
        () => create()..docPath = docPath,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        docPath: docPath,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<DiscountSectionsCud, void>
      createElement() {
    return _DiscountSectionsCudProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DiscountSectionsCudProvider && other.docPath == docPath;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, docPath.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DiscountSectionsCudRef on AutoDisposeNotifierProviderRef<void> {
  /// The parameter `docPath` of this provider.
  String? get docPath;
}

class _DiscountSectionsCudProviderElement
    extends AutoDisposeNotifierProviderElement<DiscountSectionsCud, void>
    with DiscountSectionsCudRef {
  _DiscountSectionsCudProviderElement(super.provider);

  @override
  String? get docPath => (origin as DiscountSectionsCudProvider).docPath;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
