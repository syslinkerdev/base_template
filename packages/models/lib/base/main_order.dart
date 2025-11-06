// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'main_order.freezed.dart';
part 'main_order.g.dart';

@freezed
abstract class MainOrder with _$MainOrder {
  const MainOrder._();
  const factory MainOrder({
    @JsonKey(name: 'main_order_id') required String mainOrderId,
    // 📅 Delivery date
    @JsonKey(name: 'delivery_date', fromJson: TimeStampConverter.fromJson)
    required DateTime deliveryDate,
    required List<CompanyEntry> companies,
    // smaller keys
    @JsonKey(name: 'overall_total') required double overallTotal,
    @JsonKey(name: 'overall_total_after_dis')
    required double overallTotalAfterDis,
    @JsonKey(name: 'service_charges') required double serviceCharges,
    // extra fields
    @JsonKey(name: 'no_of_products') required int noOfProducts,
    @JsonKey(name: 'no_of_clients') required int noOfClients,
    @JsonKey(name: 'generated_by') required String generatedBy,
    @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
    required DateTime createdAt,
  }) = _MainOrder;

  /// ✅ Empty factory
  factory MainOrder.empty() => MainOrder(
        mainOrderId: '',
        deliveryDate: DateTime.now().add(const Duration(days: 1)),
        companies: [],
        overallTotal: 0.0,
        overallTotalAfterDis: 0.0,
        serviceCharges: 0.0,
        noOfProducts: 0,
        noOfClients: 0,
        generatedBy: '',
        createdAt: DateTime.now(),
      );

  factory MainOrder.fromJson(Map<String, dynamic> json) =>
      _$MainOrderFromJson(json);
}

extension MainOrderApi on MainOrder {
  /// ✅ Helpers
  bool get isEmpty => mainOrderId.isEmpty;
  bool get isNotEmpty => mainOrderId.isNotEmpty;
}

extension MainOrderApiX on MainOrder {
  /// ✅ Convert MainOrder to Firestore-friendly document
  Map<String, dynamic> toDocument() => {
        'main_order_id': mainOrderId,
        'delivery_date': deliveryDate,
        'companies': companies.map((c) => c.toJson()).toList(),
        'overall_total': overallTotal,
        'overall_total_after_dis': overallTotalAfterDis,
        'service_charges': serviceCharges,
        'no_of_products': noOfProducts,
        'no_of_clients': noOfClients,
        'generated_by': generatedBy,
        'created_at': createdAt,
      };
}
