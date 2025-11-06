import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/to_day/company_report_actions_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_actions.g.dart';

@riverpod
class ReportActions extends _$ReportActions {
  @override
  FutureOr<void> build() {}

  Future<void> generateCompanyDailyPdf(
      List<DemandLine> demandLines, CompanyEntry companyEntry) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => ref
          .read(companyReportActionsServiceProvider)
          .generateCompanyDailyPdf(demandLines, companyEntry),
    );
  }

  Future<void> generateCompanyDailySheet(
      List<DemandLine> demandLines, CompanyEntry companyEntry) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => ref
          .read(companyReportActionsServiceProvider)
          .generateCompanyDailySheet(demandLines, companyEntry),
    );
  }

  Future<void> generateCompanyProductSummarySheet(
      List<ProductLine> productLines, CompanyEntry companyEntry) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => ref
          .read(companyReportActionsServiceProvider)
          .generateCompanyProductSummarySheet(productLines, companyEntry),
    );
  }

  Future<void> generateCompanyProductSummaryPdf(
      List<ProductLine> productLines, CompanyEntry companyEntry) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => ref
          .read(companyReportActionsServiceProvider)
          .generateCompanyProductSummaryPdf(productLines, companyEntry),
    );
  }

  Future<void> exportAllReportsSheet(
      {DateTime? selectedDate, bool forActualDelivery = false}) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await ref
          .read(companyReportActionsServiceProvider)
          .exportAllReportsSheet(
              forActualDelivery: forActualDelivery, selectedDate: selectedDate),
    );
  }
}
