// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_detail.freezed.dart';
part 'unit_detail.g.dart';

@freezed
abstract class UnitDetail with _$UnitDetail {
  factory UnitDetail({
    required String id, // e.g. "unit_001"
    required double value, // e.g. 500
    @JsonKey(name: 'short_form') required String unitShortForm, // e.g. "ml"
    @JsonKey(name: 'full_form')
    required String unitFullForm, // e.g. "Milliliter"
    // NEW: conversion fields
    @JsonKey(name: 'display_base')
    required String displayBase, // e.g. "L", "Kg", "Piece"
    required double factor, // multiply by this to get displayBase
  }) = _UnitDetail;

  factory UnitDetail.empty() => UnitDetail(
        id: '',
        value: 0,
        unitShortForm: '',
        unitFullForm: '',
        displayBase: '',
        factor: 1,
      );
  factory UnitDetail.next(int index) {
    final id = 'unit_${(index + 1).toString().padLeft(3, '0')}';
    return UnitDetail(
      id: id,
      value: 0,
      unitFullForm: '',
      unitShortForm: '',
      displayBase: '',
      factor: 1,
    );
  }
  factory UnitDetail.fromJson(Map<String, dynamic> json) =>
      _$UnitDetailFromJson(json);
}

extension UnitDetailHelpers on UnitDetail {
  bool get isEmpty => id.isEmpty && id.isEmpty;
  bool get isNotEmpty => !isEmpty;
  String get displayLabel => '${value.toInt()} $unitShortForm'; // e.g. 500 ml

  /// Formats quantity with its unit label and converted measurement.
  ///
  /// Examples:
  /// - 1 pkt  (420 g)
  /// - 10 pkts (4.2 Kg)
  /// - 1 cup  (500 ml)
  /// - 4 cups (2 L)
  ///
  /// Behavior:
  /// - Automatically pluralizes the unit label if quantity > 1 (e.g., pkt → pkts).
  /// - Converts to `displayBase` only if total value >= 1, otherwise shows in original unit.
  /// - Trims trailing zeros in decimal values (e.g., 2.00 → 2, 4.20 → 4.2).
  String formatTotalWithCount(double quantity, {required String countLabel}) {
    final totalValue = quantity * value;
    final totalDisplay = quantity * value * factor;

    String formatNumber(double n) {
      final s = n.toStringAsFixed(2);
      if (s.endsWith('.00')) return s.substring(0, s.length - 3);
      if (s.endsWith('0')) return s.substring(0, s.length - 1);
      return s;
    }

    // Auto pluralize countLabel if qty > 1
    final label = quantity > 1 ? '${countLabel}s' : countLabel;

    // If less than 1 in displayBase, use original unit
    final unitToShow = totalDisplay < 1
        ? '${formatNumber(totalValue)} $unitShortForm'
        : '${formatNumber(totalDisplay)} $displayBase';

    return '${quantity.toInt()} $label ($unitToShow)';
  }

  String? validate() {
    if (unitShortForm.trim().isEmpty) return 'Unit short form is required';
    if (unitFullForm.trim().isEmpty) return 'Unit full form is required';
    if (displayBase.trim().isEmpty) return 'Display base is required';
    if (factor <= 0) return 'Factor must be greater than 0';
    return null;
  }
}
