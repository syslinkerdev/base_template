// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'demand_line.freezed.dart';
part 'demand_line.g.dart';

@freezed
abstract class DemandLine with _$DemandLine {
  const DemandLine._();

  const factory DemandLine({
    @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
    required DateTime createdAt,
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'company_id') required String companyId,
    @JsonKey(name: 'company_name') required String companyName,
    @JsonKey(name: 'client_id') required String clientId,
    @JsonKey(name: 'client_name') required String clientName,
    @JsonKey(name: 'shop_name') required String shopName,
    @JsonKey(name: 'shop_address') required Address shopAddress,
    @JsonKey(name: 'products') required List<DemandLineItem> products,
    @JsonKey(name: 'client_total') required double clientTotal,
  }) = _DemandLine;

  factory DemandLine.fromJson(Map<String, dynamic> json) =>
      _$DemandLineFromJson(json);

  /// ✅ Empty factory
  factory DemandLine.empty() => DemandLine(
        createdAt: DateTime.now(),
        orderId: '',
        companyId: '',
        companyName: '',
        clientId: '',
        clientName: '',
        shopName: '',
        shopAddress: Address.empty(),
        products: const [],
        clientTotal: 0.0,
      );
}

/// ✅ Helpers
extension DemandLineApi on DemandLine {
  bool get isEmpty => orderId.isEmpty;
  bool get isNotEmpty => orderId.isNotEmpty;
}

/// ✅ Firestore-friendly converter
extension DemandLineApiX on DemandLine {
  Map<String, dynamic> toDocument() => {
        'created_at': createdAt,
        'order_id': orderId,
        'company_id': companyId,
        'company_name': companyName,
        'client_id': clientId,
        'client_name': clientName,
        'shop_name': shopName,
        'shop_address': shopAddress.toJson(),
        'products': products.map((p) => p.toDocument()).toList(),
        'client_total': clientTotal,
      };
}
