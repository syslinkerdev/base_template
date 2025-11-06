import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_filex/open_filex.dart';

Future<void> generateInvoicePdf({
  required BuildContext context,
  required OrderX order,
  required UserX user,
  Uint8List? logoBytes,
}) async {
  try {
    final fontData = await rootBundle.load('assets/Roboto-Medium.ttf');
    final ttf = pw.Font.ttf(fontData);
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: ttf),
        build: (context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(AppEnv.companyName,
                  style: pw.TextStyle(
                      fontSize: 36,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey500)),
              pw.SizedBox(height: 8),
              pw.Center(
                child: pw.Text('INVOICE', style: pw.TextStyle(fontSize: 24)),
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Divider(),

          // Invoice ID and date
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Invoice ID: ${order.orderId}',
                  style: pw.TextStyle(fontSize: 12)),
              pw.Text('Date: ${DFU.ddMMMyyyy(order.createdAt)}',
                  style: pw.TextStyle(fontSize: 12)),
            ],
          ),
          pw.SizedBox(height: 16),

          // Billed To section in box
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey),
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Billed To:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 6),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 70, child: pw.Text('Name')),
                    pw.Text(': ${user.firstName} ${user.lastName}'),
                  ],
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 70, child: pw.Text('Phone No.')),
                    pw.Text(': ${user.phoneNumber.phoneNoFormat}'),
                  ],
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 70, child: pw.Text('Shop')),
                    pw.Text(': ${user.shopName}'),
                  ],
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 70, child: pw.Text('Address')),
                    pw.Expanded(
                      child: pw.Text(
                        ': ${user.shopAddress.buildingNumber}, ${user.shopAddress.street}, ${user.shopAddress.locality}',
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 70, child: pw.Text('City/State')),
                    pw.Text(
                        ': ${user.shopAddress.city}, ${user.shopAddress.stateName} - ${user.shopAddress.pinCode}'),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Products Table
          pw.TableHelper.fromTextArray(
              headers: [
                'Product (key)',
                'Unit',
                'Qty',
                'Each ₹',
                'Dis ₹',
                'Total ₹'
              ],
              data: order.orderedProducts.map((item) {
                final discount = item.discount;
                final unit = item.unitPrice ?? 0;
                final qty = item.adjQty ?? item.origQty;
                final price = (unit - discount) * qty;
                return [
                  '${item.productName} (${item.searchKey.shortKey})',
                  '${item.unitLabel}',
                  item.adjLabel ?? item.origLabel,
                  unit.toStringAsFixed(2),
                  discount.toStringAsFixed(2),
                  price.toStringAsFixed(2),
                ];
              }).toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
              cellAlignment: pw.Alignment.center,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                2: pw.Alignment.centerLeft,
              }),
          pw.SizedBox(height: 6),
          buildBillSummary(order),
          // Footer
          pw.SizedBox(height: 8),
          pw.Divider(),
          pw.SizedBox(height: 8),
          pw.Center(
            child: pw.Text('Thank you for your purchase!',
                style: pw.TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
    final dir = await getDownloadsDirectory();
    final pdfBytes = await pdf.save();
    final file = File("${dir?.path}/Invoice.pdf");
    await file.writeAsBytes(pdfBytes, flush: true);
    await OpenFilex.open(file.path);
  } catch (e) {
    // print('Invoice Error: $e');
    if (context.mounted) {
      showMessageSnackbar(
        context: context,
        message: 'Failed to generate invoice PDF',
        type: SnackBarType.error,
      );
    }
  }
}

pw.Widget buildBillSummary(OrderX order) {
  final itemsTotal = order.originalTotalPrice;
  final serviceCharges = order.serviceCharges;
  final discounts = order.originalTotalPrice - order.totalPrice;

  // 👇 Grand total formula
  final grandTotal = itemsTotal + serviceCharges - discounts;

  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Bill Summary',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 6),

        // Items Total
        _billRow('Items Total', '₹${itemsTotal.toStringAsFixed(2)}'),

        // Service Charges
        _billRow('Service Charges', '+ ₹${serviceCharges.toStringAsFixed(2)}'),

        // Discounts
        _billRow('Total Discounts', '− ₹${discounts.toStringAsFixed(2)}'),

        pw.Divider(),

        // Grand Total
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Grand Total',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.Row(
              children: [
                if (discounts > 0)
                  pw.Text(
                    '₹${(itemsTotal + serviceCharges).toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      fontSize: 12,
                      decoration: pw.TextDecoration.lineThrough,
                    ),
                  ),
                if (discounts > 0) pw.SizedBox(width: 6),
                pw.Text(
                  '₹${grandTotal.toStringAsFixed(2)}',
                  style: pw.TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),

        pw.SizedBox(height: 8),

        // Savings
        if (discounts > 0)
          pw.Center(
            child: pw.Text(
              'You saved ₹${discounts.toStringAsFixed(2)} on this order',
              style: pw.TextStyle(fontSize: 10, color: PdfColors.teal),
            ),
          ),
      ],
    ),
  );
}

pw.Widget _billRow(String label, String value) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text(label, style: const pw.TextStyle(fontSize: 12)),
      pw.Text(value, style: const pw.TextStyle(fontSize: 12)),
    ],
  );
}
