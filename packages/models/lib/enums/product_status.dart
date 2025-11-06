import 'package:flutter/material.dart';
import 'package:models/models.dart';

enum ProductStatus {
  activePublic, // live & visible to clients
  // activePrivate, // live but only visible to admin/internal
  draft, // work in progress, not live
  archived, // old product, temporarily hidden
  deleted, // logically deleted, never shown
}

extension ProductStatusApi on ProductStatus {
  String get label => switch (this) {
        ProductStatus.activePublic => 'Active Public',
        // ProductStatus.activePrivate => 'Active Private',
        ProductStatus.draft => 'Draft',
        ProductStatus.archived => 'Archived',
        ProductStatus.deleted => 'Deleted',
      };

  Color get color => switch (this) {
        ProductStatus.activePublic => Colors.green,
        // ProductStatus.activePrivate => Colors.teal,
        ProductStatus.draft => Colors.orange,
        ProductStatus.archived => Colors.grey,
        ProductStatus.deleted => Colors.red,
      };

  IconData get icon => switch (this) {
        ProductStatus.activePublic => Icons.public,
        // ProductStatus.activePrivate => Icons.lock,
        ProductStatus.draft => Icons.edit,
        ProductStatus.archived => Icons.archive,
        ProductStatus.deleted => Icons.delete,
      };
}

class ProductStatusConverter {
  static final _converter = EnumJsonConverter(ProductStatus.values);

  static ProductStatus fromJson(Object json) => _converter.fromJson(json);
  static String toJson(ProductStatus status) => _converter.toJson(status);
  static ProductStatus? fromJsonNullable(Object? json) =>
      _converter.fromJsonNullable(json);
  static String? toJsonNullable(ProductStatus? status) =>
      _converter.toJsonNullable(status);
}
