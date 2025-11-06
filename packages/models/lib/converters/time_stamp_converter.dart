import 'package:cloud_firestore/cloud_firestore.dart';

class TimeStampConverter {
  const TimeStampConverter();

  /// Converts Firestore Timestamp (or DateTime) from JSON to Dart DateTime
  static DateTime fromJson(Object? json) {
    if (json is Timestamp) {
      return json.toDate(); // Convert Firestore Timestamp to Dart DateTime
    } else if (json is DateTime) {
      return json; // Already DateTime, return as-is
    } else if (json is String) {
      return DateTime.parse(json); // Parse ISO 8601 string to DateTime
    }
    throw ArgumentError('Invalid JSON format for Timestamp: $json');
  }

  /// For nullable DateTime fields
  static DateTime? fromJsonNullable(Object? json) {
    if (json == null) return null;
    return fromJson(json);
  }
}
