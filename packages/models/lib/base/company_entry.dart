// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'company_entry.freezed.dart';
part 'company_entry.g.dart';

@freezed
abstract class CompanyEntry with _$CompanyEntry {
  const CompanyEntry._();
  const factory CompanyEntry({
    @JsonKey(name: 'company_id') required String companyId,
    @JsonKey(name: 'company_name') required String companyName,

    /// Total value before discount
    @JsonKey(name: 'total') required double total,

    /// Total after discount (net payable)
    @JsonKey(name: 'total_after_dis') required double totalAfterDis,

    /// No. of products ordered for this company
    @JsonKey(name: 'prod_count') required int prodCount,

    /// No. of distinct clients who ordered
    @JsonKey(name: 'client_count') required int clientCount,

    /// Optional: if you want to store timestamp of this company’s entry
    @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
    required DateTime createdAt,
  }) = _CompanyEntry;

  factory CompanyEntry.empty() => CompanyEntry(
        companyId: '',
        companyName: '',
        total: 0.0,
        totalAfterDis: 0.0,
        prodCount: 0,
        clientCount: 0,
        createdAt: DateTime.now(),
      );

  factory CompanyEntry.fromJson(Map<String, dynamic> json) =>
      _$CompanyEntryFromJson(json);
}

extension CompanyEntryApi on CompanyEntry {
  /// ✅ Helpers
  bool get isEmpty => companyId.isEmpty;
  bool get isNotEmpty => companyId.isNotEmpty;
}

extension CompanyEntryApiX on CompanyEntry {
  /// ✅ Firestore-friendly converter
  Map<String, dynamic> toDocument() => {
        'company_id': companyId,
        'company_name': companyName,
        'total': total,
        'total_after_dis': totalAfterDis,
        'prod_count': prodCount,
        'client_count': clientCount,
        'created_at': createdAt,
      };
}
