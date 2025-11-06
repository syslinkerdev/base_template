import 'package:flutter/material.dart';
import 'package:models/models.dart';

enum DiscountSectionStatus {
  /// Automatically created by logic (like based on category or rule)
  generated,

  /// Predefined (static/default) section, not supposed to be edited often
  base,

  /// Manually built by admin by selecting each discount
  custom,
}

extension DiscountSectionStatusApi on DiscountSectionStatus {
  String get label => switch (this) {
        DiscountSectionStatus.generated => 'Generated',
        DiscountSectionStatus.base => 'Base',
        DiscountSectionStatus.custom => 'Custom',
      };

  Color get color => switch (this) {
        DiscountSectionStatus.generated => Colors.deepOrangeAccent, // bold and attention-grabbing
        DiscountSectionStatus.base => Colors.teal,                 // stable, trustworthy
        DiscountSectionStatus.custom => Colors.lightGreen,         // clean and user-created
      };

  IconData get icon => switch (this) {
        DiscountSectionStatus.generated => Icons.auto_awesome,
        DiscountSectionStatus.base => Icons.layers,
        DiscountSectionStatus.custom => Icons.design_services,
      };
}

class DiscountSectionStatusConverter {
  static final _converter = EnumJsonConverter(DiscountSectionStatus.values);

  static DiscountSectionStatus fromJson(Object json) =>
      _converter.fromJson(json);
  static String toJson(DiscountSectionStatus status) =>
      _converter.toJson(status);
  static DiscountSectionStatus? fromJsonNullable(Object? json) =>
      _converter.fromJsonNullable(json);
  static String? toJsonNullable(DiscountSectionStatus? status) =>
      _converter.toJsonNullable(status);
}
