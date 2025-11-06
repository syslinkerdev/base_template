import 'package:firebase_auth/firebase_auth.dart';

enum ExceptionType { internet, other }

class AppException implements Exception {
  AppException(
      {required this.title,
      this.code,
      required this.message,
      required this.originalException});

  final String title;
  final String? code;
  final String message;
  final dynamic originalException;

  @override
  String toString() {
    return "AppException(title: $title , code: $code , message: $message , originalException: $originalException)";
  }
}

/// Utility function to convert any Exception to AppException
AppException convertToAppException(
    {required String title,
    required dynamic exception,
    ExceptionType exceptionType = ExceptionType.other}) {
  if (exception is FirebaseAuthException) {
    return AppException(
        title: title,
        message: exception.message ?? 'An authentication error occurred.',
        originalException: exception,
        code: exception.code);
  }
  if (exception is FirebaseException) {
    return AppException(
        title: title,
        code: exception.code,
        message: exception.message ?? 'Internal Error Occurred',
        originalException: exception);
  }
  if (exception is FirebaseException && exception.plugin == 'cloud_firestore') {
    return AppException(
        title: title,
        code: exception.code,
        message: exception.message ?? 'Firestore Error Occurred',
        originalException: exception);
  }
  if (exception is FirebaseException &&
      exception.plugin == 'firebase_storage') {
    return AppException(
        title: title,
        code: exception.code,
        message: exception.message ?? 'Storage Error Occurred',
        originalException: exception);
  }
  if (exception is FirebaseException && exception.plugin == 'cloud_functions') {
    return AppException(
        title: title,
        code: exception.code,
        message: exception.message ?? 'Cloud Functions Error Occurred',
        originalException: exception);
  }

  /// You can add more converts here for different exceptions
  /// e.g.,
  /// if(exception is FireStoreException){....}

  /// for Location exception and for other exceptions
  /// example :
  /// state = AsyncValue.error(
  /// convertToAppException(
  ///   title: 'Location services',
  ///   exception: 'Location permissions are denied',
  /// ),
  /// StackTrace.current);

  if (exceptionType == ExceptionType.internet) {
    return AppException(
        title: title,
        message: exception,
        originalException: ExceptionType.internet);
  }

  if (exception is String) {
    return AppException(
        title: title, message: exception, originalException: exception);
  }

  /// Default case
  return AppException(
      title: title,
      message: 'An internal error occurred.',
      originalException: exception);
}
