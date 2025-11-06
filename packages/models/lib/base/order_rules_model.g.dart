// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_rules_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderRules _$OrderRulesFromJson(Map<String, dynamic> json) => _OrderRules(
      orderStart: TimeStampConverter.fromJsonNullable(json['order_start']),
      orderEnd: TimeStampConverter.fromJsonNullable(json['order_end']),
      defaultOrderStart:
          TimeStampConverter.fromJsonNullable(json['default_order_start']),
      defaultOrderEnd:
          TimeStampConverter.fromJsonNullable(json['default_order_end']),
      overrideDate: TimeStampConverter.fromJsonNullable(json['override_date']),
      enabled: json['enabled'] as bool?,
      lastUpdated: TimeStampConverter.fromJsonNullable(json['last_updated']),
    );

Map<String, dynamic> _$OrderRulesToJson(_OrderRules instance) =>
    <String, dynamic>{
      'order_start': instance.orderStart?.toIso8601String(),
      'order_end': instance.orderEnd?.toIso8601String(),
      'default_order_start': instance.defaultOrderStart?.toIso8601String(),
      'default_order_end': instance.defaultOrderEnd?.toIso8601String(),
      'override_date': instance.overrideDate?.toIso8601String(),
      'enabled': instance.enabled,
      'last_updated': instance.lastUpdated?.toIso8601String(),
    };
