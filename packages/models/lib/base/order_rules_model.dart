// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'order_rules_model.freezed.dart';
part 'order_rules_model.g.dart';

@freezed
abstract class OrderRules with _$OrderRules {
  const OrderRules._();

  factory OrderRules({
    @JsonKey(name: 'order_start', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? orderStart,
    @JsonKey(name: 'order_end', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? orderEnd,
    @JsonKey(
        name: 'default_order_start',
        fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? defaultOrderStart,
    @JsonKey(
        name: 'default_order_end',
        fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? defaultOrderEnd,
    @JsonKey(
        name: 'override_date', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? overrideDate,
    @JsonKey(name: 'enabled') bool? enabled,
    @JsonKey(
        name: 'last_updated', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? lastUpdated,
  }) = _OrderRules;

  factory OrderRules.empty() => OrderRules(
        orderStart: null,
        orderEnd: null,
        defaultOrderStart: null,
        defaultOrderEnd: null,
        overrideDate: null,
        enabled: true,
        lastUpdated: null,
      );

  static const String orderRulesDocId = 'order_rules';
  bool get isEmpty => this == OrderRules.empty();
  bool get isNotEmpty => !isEmpty;

  /// ✅ Start time today as DateTime for today’s date
  DateTime? get todayEffectiveOrderStart {
    final base = orderStart;
    if (base == null) return null;
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, base.hour, base.minute);
  }

  /// ✅ End time today as DateTime for today’s date
  DateTime? get todayEffectiveOrderEnd {
    final base = orderEnd;
    if (base == null) return null;
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, base.hour, base.minute);
  }

  /// ✅ Today version of default start
  DateTime? get todayDefaultOrderStart {
    if (defaultOrderStart == null) return null;
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, defaultOrderStart!.hour,
        defaultOrderStart!.minute);
  }

  /// ✅ Today version of default end
  DateTime? get todayDefaultOrderEnd {
    if (defaultOrderEnd == null) return null;
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, defaultOrderEnd!.hour,
        defaultOrderEnd!.minute);
  }

  /// ✅ True if now is between today’s start and end
  bool get canEdit {
    final start = todayEffectiveOrderStart;
    final end = todayEffectiveOrderEnd;
    final now = DateTime.now();
    if (start == null || end == null) return false;
    return now.isAfter(start) && now.isBefore(end);
  }

  factory OrderRules.fromJson(Map<String, dynamic> json) =>
      _$OrderRulesFromJson(json);
}
