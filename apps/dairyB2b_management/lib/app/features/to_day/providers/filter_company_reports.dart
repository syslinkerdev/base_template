import 'package:core/core.dart';
import 'package:repo/repo.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_company_reports.g.dart';

class CompanyReport {
  final CompanyEntry companyEntry;
  final List<ProductLine> productLines;
  final List<DemandLine> demandLines;
  CompanyReport({
    required this.companyEntry,
    required this.productLines,
    required this.demandLines,
  });
}

@riverpod
Future<CompanyReport?> filteredCompanyReportStream(
  Ref ref, {
  required String companyId,
  DateTime? selectedDate,
  bool forActualDelivery = false,
}) async {
  final id = forActualDelivery
      ? (selectedDate != null
          ? IdGenerator.actualDeliveryIdUsingDate(selectedDate)
          : IdGenerator.actualDeliveryId())
      : (selectedDate != null
          ? IdGenerator.mainOrderIdUsingDate(selectedDate)
          : IdGenerator.mainOrderId());
  // 1️⃣ Load the master order
  final mainOrder = await ref.watch(
      MainOrderStreamProvider(id: id, forActualDelivery: forActualDelivery)
          .future);
  if (mainOrder == null || mainOrder.isEmpty) {
    return null;
  }

  // 2️⃣ Extract the CompanyEntry for this company
  final companyEntry = mainOrder.companies.firstWhere(
    (c) => c.companyId == companyId,
    orElse: () => CompanyEntry.empty(),
  );
  if (companyEntry.isEmpty) {
    return null;
  }

  // 3️⃣ Filter product lines for this company
  final allProductLines = await ref.watch(
      ProductLinesStreamProvider(id: id, forActualDelivery: forActualDelivery)
          .future);
  final productLines =
      allProductLines.where((pl) => pl.companyId == companyId).toList();

  // 4️⃣ Filter demand lines for this company
  final allDemandLines = await ref.watch(
      DemandLinesStreamProvider(id: id, forActualDelivery: forActualDelivery)
          .future);
  final demandLines =
      allDemandLines.where((dl) => dl.companyId == companyId).toList();

  // 5️⃣ Return final CompanyReport
  return CompanyReport(
    companyEntry: companyEntry,
    productLines: productLines,
    demandLines: demandLines,
  );
}

@riverpod
Future<List<CompanyReport>> allCompanyReports(
  Ref ref, {
  DateTime? selectedDate,
  bool forActualDelivery = false,
}) async {
  // 1️⃣ Generate the ID
  final id = forActualDelivery
      ? (selectedDate != null
          ? IdGenerator.actualDeliveryIdUsingDate(selectedDate)
          : IdGenerator.actualDeliveryId())
      : (selectedDate != null
          ? IdGenerator.mainOrderIdUsingDate(selectedDate)
          : IdGenerator.mainOrderId());

  // 2️⃣ Load the master order
  final mainOrder = await ref.watch(
      MainOrderStreamProvider(id: id, forActualDelivery: forActualDelivery)
          .future);
  if (mainOrder == null || mainOrder.isEmpty) {
    return [];
  }

  // 3️⃣ Load all product and demand lines once
  final allProductLines = await ref.watch(
      ProductLinesStreamProvider(id: id, forActualDelivery: forActualDelivery)
          .future);
  final allDemandLines = await ref.watch(
      DemandLinesStreamProvider(id: id, forActualDelivery: forActualDelivery)
          .future);

  // 4️⃣ Generate reports for all companies
  final reports = <CompanyReport>[];

  for (final companyEntry in mainOrder.companies) {
    if (companyEntry.isEmpty) continue;

    final companyId = companyEntry.companyId;

    final companyProducts =
        allProductLines.where((pl) => pl.companyId == companyId).toList();
    final companyDemands =
        allDemandLines.where((dl) => dl.companyId == companyId).toList();

    reports.add(CompanyReport(
      companyEntry: companyEntry,
      productLines: companyProducts,
      demandLines: companyDemands,
    ));
  }

  return reports;
}
