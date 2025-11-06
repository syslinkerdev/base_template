import 'dart:io';
import 'dart:math' as math;
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/filter_company_reports.dart';
import 'package:dairyB2b_management/app/features/to_day/providers/today_providers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:repo/repo.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'company_report_actions_service.g.dart';

@riverpod
CompanyReportActionsService companyReportActionsService(Ref ref) {
  return CompanyReportActionsService(ref: ref);
}

class CompanyReportActionsService {
  CompanyReportActionsService({required this.ref});
  final Ref ref;

  // -------------------- 🔹 COMMON HELPERS --------------------

  Future<void> _saveAndOpenFile(
    List<int> bytes,
    String fileName,
  ) async {
    final dir = await getDownloadsDirectory();
    if (dir == null) throw Exception("Download directory not available");

    final file = File("${dir.path}/$fileName");
    await file.writeAsBytes(bytes, flush: true);
    await OpenFilex.open(file.path);
  }

  Future<void> _savePdfAndOpenFile(
    pw.Document pdf,
    String fileName,
  ) async {
    final pdfBytes = await pdf.save();
    await _saveAndOpenFile(pdfBytes, fileName);
  }

  // -------------------- 🔹 DEMAND LINE HELPERS --------------------

  List<String> _extractProductKeys(List<DemandLine> demandLines) {
    final productKeys = <String>{};
    for (final line in demandLines) {
      for (final item in line.products) {
        productKeys.add(
            '${item.productKey.shortKey} (${item.unitDetails.displayLabel})');
      }
    }
    return productKeys.toList();
  }

  List<String> _buildHeaders(List<String> productList) {
    return ["S NO", "CUSTOMER NAME", ...productList];
  }

  List<List<String>> _buildDataRows(
    List<DemandLine> demandLines,
    List<String> productList,
  ) {
    final rows = <List<String>>[];

    // --- Normal rows ---
    for (int i = 0; i < demandLines.length; i++) {
      final line = demandLines[i];

      final productMap = {
        for (var p in line.products)
          '${p.productKey.shortKey} (${p.unitDetails.displayLabel})':
              p.unitDetails.formatTotalWithCount(
            p.quantity.toDouble(),
            countLabel: p.productType.shortForm,
          ),
      };

      final row = [
        (i + 1).toString(),
        line.clientName,
        ...productList.map((k) => productMap[k] ?? ""),
      ];
      rows.add(row);
    }

    // --- Compute totals ---
    final totals = <String>[];

    for (final key in productList) {
      double sum = 0;
      UnitDetail? unit;
      String? countLabel;

      for (final line in demandLines) {
        final item = line.products.firstWhere(
          (p) =>
              '${p.productKey.shortKey} (${p.unitDetails.displayLabel})' == key,
          orElse: () => DemandLineItem.empty(),
        );
        if (item.productId.isNotEmpty) {
          sum += item.quantity.toDouble();
          unit ??= item.unitDetails; // store unit details for formatting
          countLabel ??= item.productType.shortForm;
        }
      }

      if (sum == 0 || unit == null) {
        totals.add("");
      } else {
        totals.add(
            unit.formatTotalWithCount(sum, countLabel: countLabel ?? 'Pkts'));
      }
    }

    // --- Add TOTAL row ---
    rows.add([
      "",
      "TOTAL",
      ...totals,
    ]);

    return rows;
  }

  // -------------------- 🔹 PRODUCT SUMMARY HELPERS --------------------

  List<String> getProductSummaryHeaders() => [
        "S NO",
        "PRODUCT NAME",
        "PRODUCT KEY",
        "UNIT",
        "TOTAL QTY",
        "UNIT PRICE",
        "DISCOUNT",
        "SUBTOTAL",
        "AFT DIS SUBTOTAL",
      ];

  List<List<dynamic>> buildProductSummaryRows(List<ProductLine> productLines) {
    return List.generate(productLines.length, (i) {
      final line = productLines[i];
      final discountTotal = line.totalQuantity * line.discount;
      final netTotal = line.subtotal - discountTotal;
      return [
        (i + 1),
        '${line.companyName} ${line.productName}',
        line.productKey.shortKey,
        line.unitDetails.displayLabel,
        line.unitDetails.formatTotalWithCount(line.totalQuantity.toDouble(),
            countLabel: line.productType.shortForm),
        line.unitPrice,
        line.discount,
        line.subtotal,
        netTotal,
      ];
    });
  }

  // -------------------- 🔹 EXCEL GENERATORS --------------------

  Future<void> generateCompanyDailySheet(
    List<DemandLine> demandLines,
    CompanyEntry companyEntry,
  ) async {
    final workbook = Workbook();
    final sheet = workbook.worksheets[0];
    sheet.name = companyEntry.companyName;

    final productList = _extractProductKeys(demandLines);
    final headers = _buildHeaders(productList);
    final dataRows = _buildDataRows(demandLines, productList);

    // Title
    sheet.getRangeByIndex(1, 1).setText(DFU.ddMMyyyy(DFU.now()));
    sheet.getRangeByIndex(1, 2)
      ..setText("${companyEntry.companyName.toUpperCase()} DAILY DEMAND SHEET")
      ..cellStyle.bold = true;

    // Headers
    for (int i = 0; i < headers.length; i++) {
      final cell = sheet.getRangeByIndex(2, i + 1);
      cell
        ..setText(headers[i])
        ..cellStyle.bold = true
        ..cellStyle.backColor = '#FFE5B4';
    }

    // Data
    for (int i = 0; i < dataRows.length; i++) {
      final rowIndex = i + 3;
      for (int j = 0; j < dataRows[i].length; j++) {
        final val = dataRows[i][j];
        final cell = sheet.getRangeByIndex(rowIndex, j + 1);
        cell.setText(val);
      }
    }

    // Autosize
    for (int i = 1; i <= headers.length; i++) {
      sheet.autoFitColumn(i);
    }

    final bytes = workbook.saveAsStream();
    workbook.dispose();
    await _saveAndOpenFile(bytes, "who_ordered.xlsx");
  }

  Future<void> generateCompanyProductSummarySheet(
    List<ProductLine> productLines,
    CompanyEntry companyEntry,
  ) async {
    final workbook = Workbook();
    final sheet = workbook.worksheets[0];
    sheet.name = companyEntry.companyName;

    final headers = getProductSummaryHeaders();
    final rows = buildProductSummaryRows(productLines);

    // Title
    sheet.getRangeByIndex(1, 1).setText(DFU.ddMMyyyy(DFU.now()));
    sheet.getRangeByIndex(1, 2)
      ..setText("${companyEntry.companyName.toUpperCase()} PRODUCT SUMMARY")
      ..cellStyle.bold = true;
    ;

    // Headers
    for (int i = 0; i < headers.length; i++) {
      final cell = sheet.getRangeByIndex(2, i + 1);
      cell
        ..setText(headers[i])
        ..cellStyle.bold = true
        ..cellStyle.backColor = '#D9EAF7';
    }

    // Data rows
    for (int i = 0; i < rows.length; i++) {
      final rowIndex = i + 3;
      for (int j = 0; j < rows[i].length; j++) {
        final val = rows[i][j];
        final cell = sheet.getRangeByIndex(rowIndex, j + 1);

        if (j == 0) {
          cell.setNumber(val.toDouble());
        } else if (j >= 5) {
          cell.setNumber(val.toDouble());
          cell.numberFormat = '₹#,##0.00';
        } else {
          cell.setText(val);
        }
      }
    }

    for (int i = 1; i <= headers.length; i++) {
      sheet.autoFitColumn(i);
    }

    final bytes = workbook.saveAsStream();
    workbook.dispose();
    await _saveAndOpenFile(bytes, "product_summary.xlsx");
  }

  // -------------------- 🔹 PDF GENERATORS --------------------

  Future<void> generateCompanyDailyPdf(
    List<DemandLine> demandLines,
    CompanyEntry companyEntry,
  ) async {
    final fontData = await rootBundle.load('assets/Roboto-Medium.ttf');
    final ttf = pw.Font.ttf(fontData);

    final productList = _extractProductKeys(demandLines);
    final headers = _buildHeaders(productList);
    final dataRows = _buildDataRows(demandLines, productList);

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (_) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              "${companyEntry.companyName.toUpperCase()} DAILY DEMAND SHEET",
              style: pw.TextStyle(
                font: ttf,
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Paragraph(
            text: "Date: ${DFU.ddMMyyyy(DFU.now())}",
            style: pw.TextStyle(font: ttf, fontSize: 12),
          ),
          pw.SizedBox(height: 10),
          pw.Table.fromTextArray(
            headers: headers,
            data: dataRows,
            border: pw.TableBorder.all(),
            headerStyle: pw.TextStyle(
              font: ttf,
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
            ),
            headerDecoration:
                pw.BoxDecoration(color: PdfColor.fromInt(0xFFFFE5B4)),
            cellStyle: pw.TextStyle(font: ttf, fontSize: 10),
            cellAlignment: pw.Alignment.centerLeft,
            cellHeight: 25,
          ),
        ],
      ),
    );
    await _savePdfAndOpenFile(pdf, "who_ordered.pdf");
  }

  Future<void> generateCompanyProductSummaryPdf(
    List<ProductLine> productLines,
    CompanyEntry companyEntry,
  ) async {
    final fontData = await rootBundle.load('assets/Roboto-Medium.ttf');
    final ttf = pw.Font.ttf(fontData);

    final headers = getProductSummaryHeaders();
    final rawRows = buildProductSummaryRows(productLines);

    final dataRows = rawRows.map((row) {
      return [
        row[0],
        row[1],
        row[2],
        row[3],
        row[4],
        "₹${row[5]}",
        "₹${row[6]}",
        "₹${row[7]}",
        "₹${row[8]}",
      ];
    }).toList();

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (_) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              "${companyEntry.companyName.toUpperCase()} PRODUCT SUMMARY",
              style: pw.TextStyle(
                font: ttf,
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.Table.fromTextArray(
            headers: headers,
            data: dataRows,
            border: pw.TableBorder.all(),
            headerStyle: pw.TextStyle(
              font: ttf,
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
            headerDecoration:
                pw.BoxDecoration(color: PdfColor.fromInt(0xFFD9EAF7)),
            cellStyle: pw.TextStyle(font: ttf, fontSize: 10),
            cellAlignment: pw.Alignment.centerLeft,
            cellHeight: 25,
          ),
        ],
      ),
    );

    await _savePdfAndOpenFile(pdf, "product_summary.pdf");
  }

// -------------------- 🔹 Export All Reports --------------------
  Future<void> exportAllReportsSheet(
      {DateTime? selectedDate, bool forActualDelivery = false}) async {
    print("📦 ExportAllReports started...");
    final dateX = forActualDelivery
        ? selectedDate ?? DFU.now()
        : selectedDate ?? DFU.nextDay();
    final mainHeading = forActualDelivery
        ? 'Actual Deliveries Date : ${DFU.ddMMyyyy(dateX)}'
        : 'Master Order Date : ${DFU.ddMMyyyy(dateX)}';

    final users = await ref.watch(usersStreamProvider.notifier).completeUsers;
    final orders =
        await ref.read(dairyB2bRepositoryProvider).fetchOrdersOfDate(date: dateX);

    final usersWithOrders = combineUsersAndOrders(users: users, orders: orders);

    // 1️⃣ Fetch all company reports
    final allCompanyReports = await ref.watch(
      AllCompanyReportsProvider(
              forActualDelivery: forActualDelivery, selectedDate: selectedDate)
          .future,
    );

    if (allCompanyReports.isEmpty) {
      print("⚠️ No company reports found!");
      return;
    }

    // 2️⃣ Create workbook
    final workbook = Workbook();

    // ---------------- Company Sheets ----------------
    for (int idx = 0; idx < allCompanyReports.length; idx++) {
      final report = allCompanyReports[idx];
      final company = report.companyEntry;
      final productLines = report.productLines;
      final demandLines = report.demandLines;

      Worksheet sheet;
      if (idx == 0) {
        sheet = workbook.worksheets[0];
        sheet.name = _safeSheetName(company.companyName, fallback: 'Company-1');
      } else {
        sheet = workbook.worksheets.addWithName(_safeSheetName(
            company.companyName,
            fallback: 'Company-${idx + 1}'));
      }

      int currentRow = 1;
      // --- Main Heading Date ---
      sheet.getRangeByIndex(currentRow, 1)
        ..setText(mainHeading)
        ..cellStyle.bold = true
        ..cellStyle.fontSize = 14;
      currentRow += 2; // leave a row gap before Product Summary

      // --- Product Summary Section ---
      final headers = getProductSummaryHeaders();
      final rows = buildProductSummaryRows(productLines);

      sheet.getRangeByIndex(currentRow, 1)
        ..setText("${company.companyName.toUpperCase()} PRODUCT SUMMARY")
        ..cellStyle.bold = true
        ..cellStyle.fontSize = 13;
      currentRow += 1;

      for (int i = 0; i < headers.length; i++) {
        final cell = sheet.getRangeByIndex(currentRow, i + 1);
        cell
          ..setText(headers[i])
          ..cellStyle.bold = true
          ..cellStyle.backColor = '#D9EAF7';
      }
      currentRow += 1;

      for (int i = 0; i < rows.length; i++) {
        for (int j = 0; j < rows[i].length; j++) {
          final val = rows[i][j];
          final cell = sheet.getRangeByIndex(currentRow, j + 1);
          if (val is num) {
            cell.setNumber(val.toDouble());
            if (j >= 5) cell.numberFormat = '₹#,##0.00';
          } else {
            cell.setText(val.toString());
          }
        }
        currentRow += 1;
      }

      // --- Daily Demand Section ---
      final productList = _extractProductKeys(demandLines);
      final demandHeaders = _buildHeaders(productList);
      final demandData = _buildDataRows(demandLines, productList);

      currentRow += 2;
      sheet.getRangeByIndex(currentRow, 1)
        ..setText("${company.companyName.toUpperCase()} DAILY DEMAND SHEET")
        ..cellStyle.bold = true
        ..cellStyle.fontSize = 13;
      currentRow += 1;

      for (int i = 0; i < demandHeaders.length; i++) {
        final cell = sheet.getRangeByIndex(currentRow, i + 1);
        cell
          ..setText(demandHeaders[i])
          ..cellStyle.bold = true
          ..cellStyle.backColor = '#FFE5B4';
      }
      currentRow += 1;

      for (int i = 0; i < demandData.length; i++) {
        for (int j = 0; j < demandData[i].length; j++) {
          sheet
              .getRangeByIndex(currentRow, j + 1)
              .setText(demandData[i][j].toString());
        }
        currentRow += 1;
      }

      // Auto-fit columns
      final maxCols = math.max(headers.length, demandHeaders.length);
      for (int c = 1; c <= maxCols; c++) {
        sheet.autoFitColumn(c);
      }

      print("✅ Sheet created for ${company.companyName}");
    }

    // ---------------- Bills Sheet ----------------
    final billsSheet = workbook.worksheets
        .addWithName(_safeSheetName("Bills", fallback: "Bills"));
    int currentRow = 1;
    // --- Main Heading Date ---
    billsSheet.getRangeByIndex(currentRow, 1)
      ..setText(mainHeading)
      ..cellStyle.bold = true
      ..cellStyle.fontSize = 14;
    currentRow += 2; // leave a row gap before Product Summary

    billsSheet.getRangeByIndex(currentRow, 1)
      ..setText('📦 ALL ORDERS / BILLS')
      ..cellStyle.bold = true
      ..cellStyle.fontSize = 12;
    currentRow += 2;

    for (final userWithOrder in usersWithOrders) {
      final user = userWithOrder.user;
      final order = userWithOrder.order;
      if (order == null) continue;

      // ── Header ──
      billsSheet.getRangeByIndex(currentRow, 1)
        ..setText('Invoice for ${user.shopName}')
        ..cellStyle.bold = true
        ..cellStyle.fontSize = 12;
      currentRow += 1;

      billsSheet
          .getRangeByIndex(currentRow, 1)
          .setText('Customer: ${user.firstName} ${user.lastName}');
      billsSheet
          .getRangeByIndex(currentRow, 2)
          .setText('Phone: ${user.phoneNumber.phoneNoFormat}');
      currentRow += 1;

      billsSheet.getRangeByIndex(currentRow, 1).setText(
          'Address: ${user.shopAddress.buildingNumber}, ${user.shopAddress.street}, ${user.shopAddress.locality}');
      billsSheet.getRangeByIndex(currentRow, 2).setText(
          '${user.shopAddress.city}, ${user.shopAddress.stateName} - ${user.shopAddress.pinCode}');
      currentRow += 2;

      // ── Product Table Header ──
      final billHeaders = [
        'Product',
        'Unit',
        'Qty',
        'Each ₹',
        'Dis ₹',
        'Total ₹'
      ];
      for (int i = 0; i < billHeaders.length; i++) {
        final cell = billsSheet.getRangeByIndex(currentRow, i + 1);
        cell.setText(billHeaders[i]);
        cell.cellStyle.bold = true;
        cell.cellStyle.backColor = '#D9EAF7';
      }
      currentRow += 1;

      // ── Product Rows ──
      for (final item in order.orderedProducts) {
        final unit = item.unitPrice ?? 0;
        final qty = item.adjQty ?? item.origQty;
        final discount = item.discount;
        final total = (unit - discount) * qty;

        final rowData = [
          '${item.productName} (${item.searchKey.shortKey})',
          item.unitLabel,
          item.adjLabel ?? item.origLabel,
          unit.toStringAsFixed(2),
          discount.toStringAsFixed(2),
          total.toStringAsFixed(2),
        ];

        for (int j = 0; j < rowData.length; j++) {
          final cell = billsSheet.getRangeByIndex(currentRow, j + 1);
          cell.setText(rowData[j]);
          if (j >= 3) cell.numberFormat = '₹#,##0.00';
        }
        currentRow += 1;
      }

      // ── Bill Summary ──
      final itemsTotal = order.originalTotalPrice;
      final serviceCharges = order.serviceCharges;
      final discounts = order.originalTotalPrice - order.totalPrice;
      final grandTotal = itemsTotal + serviceCharges - discounts;

      currentRow += 1;
      billsSheet.getRangeByIndex(currentRow, 5).setText('Items Total');
      billsSheet.getRangeByIndex(currentRow, 6).setNumber(itemsTotal);
      currentRow += 1;

      billsSheet.getRangeByIndex(currentRow, 5).setText('Service Charges');
      billsSheet.getRangeByIndex(currentRow, 6).setNumber(serviceCharges);
      currentRow += 1;

      billsSheet.getRangeByIndex(currentRow, 5).setText('Total Discounts');
      billsSheet.getRangeByIndex(currentRow, 6).setNumber(discounts);
      currentRow += 1;

      billsSheet.getRangeByIndex(currentRow, 5).setText('Grand Total');
      billsSheet.getRangeByIndex(currentRow, 6).setNumber(grandTotal);
      currentRow += 3; // leave space before next invoice
    }

    // Auto-fit columns for Bills sheet
    for (int c = 1; c <= 6; c++) {
      billsSheet.autoFitColumn(c);
    }

    // 3️⃣ Save & open file
    final bytes = workbook.saveAsStream();
    workbook.dispose();

    await _saveAndOpenFile(bytes, "All_Company_Reports_With_DailySheet.xlsx");
    print("🎉 Export completed!");
  }

// ---------- helpers ----------
  String _safeSheetName(String name, {required String fallback}) {
    // Sheet name must be <= 31 chars and cannot contain some special chars
    final cleaned = name.replaceAll(RegExp(r'[\\\/*?:\[\]]'), '').trim();
    if (cleaned.isEmpty) return fallback;
    return cleaned.length <= 31 ? cleaned : cleaned.substring(0, 31);
  }

  /// Combine users and orders into a list of UserWithOrder
  List<UserWithOrder> combineUsersAndOrders({
    required List<UserX> users,
    required List<OrderX> orders,
  }) {
    return users.map((user) {
      // Find the order for this user (if any)
      final order = orders.firstWhere(
        (o) => o.userUid == user.uid,
        orElse: () => OrderX.empty(), // empty order if none found
      );

      return UserWithOrder(user: user, order: order.isEmpty ? null : order);
    }).toList();
  }
}
