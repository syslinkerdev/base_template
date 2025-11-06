// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'id_name.freezed.dart';
part 'id_name.g.dart';

@freezed
abstract class IdName with _$IdName {
  const IdName._();
  
  factory IdName({
    required String id,
    @JsonKey(defaultValue: '') required String name,
  }) = _IdName;

  // Add an empty constructor
  factory IdName.empty() => IdName(
        id: '',
        name: '',
      );
  bool get isEmpty => this == IdName.empty();
  bool get isNotEmpty => !isEmpty;

  factory IdName.fromJson(Map<String, dynamic> json) => _$IdNameFromJson(json);
}
