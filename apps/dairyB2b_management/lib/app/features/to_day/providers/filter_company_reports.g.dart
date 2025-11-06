// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_company_reports.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredCompanyReportStreamHash() =>
    r'8cece67c94d670688f694af5951facb7b82a7539';

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

/// See also [filteredCompanyReportStream].
@ProviderFor(filteredCompanyReportStream)
const filteredCompanyReportStreamProvider = FilteredCompanyReportStreamFamily();

/// See also [filteredCompanyReportStream].
class FilteredCompanyReportStreamFamily
    extends Family<AsyncValue<CompanyReport?>> {
  /// See also [filteredCompanyReportStream].
  const FilteredCompanyReportStreamFamily();

  /// See also [filteredCompanyReportStream].
  FilteredCompanyReportStreamProvider call({
    required String companyId,
    DateTime? selectedDate,
    bool forActualDelivery = false,
  }) {
    return FilteredCompanyReportStreamProvider(
      companyId: companyId,
      selectedDate: selectedDate,
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  FilteredCompanyReportStreamProvider getProviderOverride(
    covariant FilteredCompanyReportStreamProvider provider,
  ) {
    return call(
      companyId: provider.companyId,
      selectedDate: provider.selectedDate,
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
  String? get name => r'filteredCompanyReportStreamProvider';
}

/// See also [filteredCompanyReportStream].
class FilteredCompanyReportStreamProvider
    extends AutoDisposeFutureProvider<CompanyReport?> {
  /// See also [filteredCompanyReportStream].
  FilteredCompanyReportStreamProvider({
    required String companyId,
    DateTime? selectedDate,
    bool forActualDelivery = false,
  }) : this._internal(
          (ref) => filteredCompanyReportStream(
            ref as FilteredCompanyReportStreamRef,
            companyId: companyId,
            selectedDate: selectedDate,
            forActualDelivery: forActualDelivery,
          ),
          from: filteredCompanyReportStreamProvider,
          name: r'filteredCompanyReportStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredCompanyReportStreamHash,
          dependencies: FilteredCompanyReportStreamFamily._dependencies,
          allTransitiveDependencies:
              FilteredCompanyReportStreamFamily._allTransitiveDependencies,
          companyId: companyId,
          selectedDate: selectedDate,
          forActualDelivery: forActualDelivery,
        );

  FilteredCompanyReportStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
    required this.selectedDate,
    required this.forActualDelivery,
  }) : super.internal();

  final String companyId;
  final DateTime? selectedDate;
  final bool forActualDelivery;

  @override
  Override overrideWith(
    FutureOr<CompanyReport?> Function(FilteredCompanyReportStreamRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredCompanyReportStreamProvider._internal(
        (ref) => create(ref as FilteredCompanyReportStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
        selectedDate: selectedDate,
        forActualDelivery: forActualDelivery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CompanyReport?> createElement() {
    return _FilteredCompanyReportStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredCompanyReportStreamProvider &&
        other.companyId == companyId &&
        other.selectedDate == selectedDate &&
        other.forActualDelivery == forActualDelivery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);
    hash = _SystemHash.combine(hash, selectedDate.hashCode);
    hash = _SystemHash.combine(hash, forActualDelivery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredCompanyReportStreamRef
    on AutoDisposeFutureProviderRef<CompanyReport?> {
  /// The parameter `companyId` of this provider.
  String get companyId;

  /// The parameter `selectedDate` of this provider.
  DateTime? get selectedDate;

  /// The parameter `forActualDelivery` of this provider.
  bool get forActualDelivery;
}

class _FilteredCompanyReportStreamProviderElement
    extends AutoDisposeFutureProviderElement<CompanyReport?>
    with FilteredCompanyReportStreamRef {
  _FilteredCompanyReportStreamProviderElement(super.provider);

  @override
  String get companyId =>
      (origin as FilteredCompanyReportStreamProvider).companyId;
  @override
  DateTime? get selectedDate =>
      (origin as FilteredCompanyReportStreamProvider).selectedDate;
  @override
  bool get forActualDelivery =>
      (origin as FilteredCompanyReportStreamProvider).forActualDelivery;
}

String _$allCompanyReportsHash() => r'e7275acc643b5e180f2a4db9ca8cea6fda435059';

/// See also [allCompanyReports].
@ProviderFor(allCompanyReports)
const allCompanyReportsProvider = AllCompanyReportsFamily();

/// See also [allCompanyReports].
class AllCompanyReportsFamily extends Family<AsyncValue<List<CompanyReport>>> {
  /// See also [allCompanyReports].
  const AllCompanyReportsFamily();

  /// See also [allCompanyReports].
  AllCompanyReportsProvider call({
    DateTime? selectedDate,
    bool forActualDelivery = false,
  }) {
    return AllCompanyReportsProvider(
      selectedDate: selectedDate,
      forActualDelivery: forActualDelivery,
    );
  }

  @override
  AllCompanyReportsProvider getProviderOverride(
    covariant AllCompanyReportsProvider provider,
  ) {
    return call(
      selectedDate: provider.selectedDate,
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
  String? get name => r'allCompanyReportsProvider';
}

/// See also [allCompanyReports].
class AllCompanyReportsProvider
    extends AutoDisposeFutureProvider<List<CompanyReport>> {
  /// See also [allCompanyReports].
  AllCompanyReportsProvider({
    DateTime? selectedDate,
    bool forActualDelivery = false,
  }) : this._internal(
          (ref) => allCompanyReports(
            ref as AllCompanyReportsRef,
            selectedDate: selectedDate,
            forActualDelivery: forActualDelivery,
          ),
          from: allCompanyReportsProvider,
          name: r'allCompanyReportsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$allCompanyReportsHash,
          dependencies: AllCompanyReportsFamily._dependencies,
          allTransitiveDependencies:
              AllCompanyReportsFamily._allTransitiveDependencies,
          selectedDate: selectedDate,
          forActualDelivery: forActualDelivery,
        );

  AllCompanyReportsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.selectedDate,
    required this.forActualDelivery,
  }) : super.internal();

  final DateTime? selectedDate;
  final bool forActualDelivery;

  @override
  Override overrideWith(
    FutureOr<List<CompanyReport>> Function(AllCompanyReportsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AllCompanyReportsProvider._internal(
        (ref) => create(ref as AllCompanyReportsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        selectedDate: selectedDate,
        forActualDelivery: forActualDelivery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CompanyReport>> createElement() {
    return _AllCompanyReportsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllCompanyReportsProvider &&
        other.selectedDate == selectedDate &&
        other.forActualDelivery == forActualDelivery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, selectedDate.hashCode);
    hash = _SystemHash.combine(hash, forActualDelivery.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AllCompanyReportsRef
    on AutoDisposeFutureProviderRef<List<CompanyReport>> {
  /// The parameter `selectedDate` of this provider.
  DateTime? get selectedDate;

  /// The parameter `forActualDelivery` of this provider.
  bool get forActualDelivery;
}

class _AllCompanyReportsProviderElement
    extends AutoDisposeFutureProviderElement<List<CompanyReport>>
    with AllCompanyReportsRef {
  _AllCompanyReportsProviderElement(super.provider);

  @override
  DateTime? get selectedDate =>
      (origin as AllCompanyReportsProvider).selectedDate;
  @override
  bool get forActualDelivery =>
      (origin as AllCompanyReportsProvider).forActualDelivery;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
