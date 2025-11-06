import 'package:flutter/material.dart';
import 'package:models/models.dart';

enum OrderStatus {
  placed, // 🟦 Initial order
  edited, // 🟩 User edited within their allowed time
  modified, // 🟪  Admin modified after edit window but before delivery
  adjusted, // 🟨 Admin adjusted after delivery
  deleted, // 🟥 Canceled / removed
}

extension OrderStatusApi on OrderStatus {
  String get emoji => switch (this) {
        OrderStatus.placed => '🛒', // user placed a new order
        OrderStatus.edited => '✏️', // user edited within window
        OrderStatus.modified => '🧾', // admin modified after window
        OrderStatus.adjusted => '⚙️', // adjusted after delivery
        OrderStatus.deleted => '🗑️', // deleted
      };

  String get label => switch (this) {
        OrderStatus.placed => 'Placed',
        OrderStatus.edited => 'Edited',
        OrderStatus.modified => 'Modified',
        OrderStatus.adjusted => 'Adjusted',
        OrderStatus.deleted => 'Deleted',
      };

  Color get color => switch (this) {
        OrderStatus.placed => Colors.blue.shade700,
        OrderStatus.edited => Colors.teal.shade700,
        OrderStatus.modified => Colors.deepPurple.shade700,
        OrderStatus.adjusted => Colors.orange.shade700,
        OrderStatus.deleted => Colors.red.shade700,
      };

  IconData get icon => switch (this) {
        OrderStatus.placed => Icons.receipt_long_outlined,
        OrderStatus.edited => Icons.edit_outlined,
        OrderStatus.modified => Icons.manage_history_outlined,
        OrderStatus.adjusted => Icons.tune_outlined,
        OrderStatus.deleted => Icons.delete_outline,
      };
}

/// Handles JSON conversion for Firestore / API serialization
class OrderStatusConverter {
  static final _converter = EnumJsonConverter(OrderStatus.values);

  static OrderStatus fromJson(Object json) => _converter.fromJson(json);
  static String toJson(OrderStatus status) => _converter.toJson(status);

  static OrderStatus? fromJsonNullable(Object? json) =>
      _converter.fromJsonNullable(json);
  static String? toJsonNullable(OrderStatus? status) =>
      _converter.toJsonNullable(status);
}
