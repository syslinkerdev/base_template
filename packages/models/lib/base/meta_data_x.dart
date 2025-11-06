// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'meta_data_x.freezed.dart';
part 'meta_data_x.g.dart';

@freezed
abstract class MetaDataX with _$MetaDataX {
  const factory MetaDataX({
    @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? createdAt,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'updated_at', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? updatedAt,
    @JsonKey(name: 'updated_by') String? updatedBy,
  }) = _MetaData;

  factory MetaDataX.empty() => const MetaDataX();

  factory MetaDataX.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);
}
