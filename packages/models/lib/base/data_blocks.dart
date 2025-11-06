// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_blocks.freezed.dart';
part 'data_blocks.g.dart';

@freezed
abstract class DataBlock3 with _$DataBlock3 {
  const DataBlock3._();

  const factory DataBlock3({
    required String v1,
    required String v2,
    required String v3,
  }) = _DataBlock3;

  factory DataBlock3.empty() => const DataBlock3(v1: '', v2: '', v3: '');

  bool get isEmpty => this == DataBlock3.empty();
  bool get isNotEmpty => !isEmpty;

  factory DataBlock3.fromJson(Map<String, dynamic> json) =>
      _$DataBlock3FromJson(json);
}
