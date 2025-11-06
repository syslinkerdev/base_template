// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UnitDetail _$UnitDetailFromJson(Map<String, dynamic> json) => _UnitDetail(
      id: json['id'] as String,
      value: (json['value'] as num).toDouble(),
      unitShortForm: json['short_form'] as String,
      unitFullForm: json['full_form'] as String,
      displayBase: json['display_base'] as String,
      factor: (json['factor'] as num).toDouble(),
    );

Map<String, dynamic> _$UnitDetailToJson(_UnitDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'short_form': instance.unitShortForm,
      'full_form': instance.unitFullForm,
      'display_base': instance.displayBase,
      'factor': instance.factor,
    };
