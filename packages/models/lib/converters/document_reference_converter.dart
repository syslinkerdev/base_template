import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentReferenceJsonConverter {
  const DocumentReferenceJsonConverter();

  /// Converts JSON (which is a DocumentReference) to a DocumentReference object.
  static DocumentReference fromJson(Object json) {
    if (json is DocumentReference) {
      return json; // Already a DocumentReference, return as is
    }
    if (json is String) {
      return FirebaseFirestore.instance
          .doc(json); // Convert string path to DocumentReference
    }
    throw ArgumentError('Invalid JSON for DocumentReference');
  }

  /// Nullable
  static DocumentReference? fromJsonNullable(Object? json) {
    if (json == null) return null;
    return fromJson(json);
  }

  /// Converts a DocumentReference to its Firestore path (string).
  static String toJson(DocumentReference documentReference) =>
      documentReference.path;

  /// Nullable
  static String? toJsonNullable(DocumentReference? documentReference) =>
      documentReference?.path;
}
