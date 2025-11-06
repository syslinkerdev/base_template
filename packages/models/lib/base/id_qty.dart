// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'id_qty.freezed.dart';
part 'id_qty.g.dart';

@freezed
abstract class IdQty with _$IdQty {
  const IdQty._();
  factory IdQty({
    required String id,
    int? qty,
  }) = _IdQty;

  // Add an empty constructor
  factory IdQty.empty() => IdQty(
        id: '',
        qty: 0,
      );
  bool get isEmpty => this == IdQty.empty();
  bool get isNotEmpty => !isEmpty;

  factory IdQty.fromJson(Map<String, dynamic> json) => _$IdQtyFromJson(json);
}
