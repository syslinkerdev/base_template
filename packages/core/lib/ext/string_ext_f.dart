import 'package:core/core.dart';

extension StringExtF on String? {
  bool get isNotValidName => containsValidValue && this!.length < 3;
  String get valueOrEmpty => this ?? '';
  String get valueOrHyphen => this ?? '-';
  String get valueOrNil => this ?? '-Nil-';

  bool equals(String? str) => StringUtils.equals(this, str);

  bool equalsIgnoreCase(String? str) => StringUtils.equals(this, str);

  bool get isValidNum => containsValidValue && num.tryParse(this!) != null;

  String concat([String? s2, String? s3]) => StringUtils.concat(this, [s2, s3]);

  bool get isSVG => containsValidValue && this!.split('.').last == 'svg';

  String get captilizeName => valueOrEmpty.trim().split(' ').map((word) {
        if (word.isNotEmpty) {
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        } else {
          return '';
        }
      }).join(' ');

  bool get isImage => StringUtils.isImage(this!.replaceAll('.', ''));
  bool get isDocument => StringUtils.isDoc(this!.replaceAll('.', ''));

  bool containsIgnoreCase(String? other) {
    if (this == null || other == null) {
      return false;
    }
    return this!.toLowerCase().contains(other.toLowerCase());
  }

  bool get containsValidValue =>
      this != null && (this!.trim().isNotEmpty) && this!.trim() != 'null';

  bool get doesNotHaveValue => !containsValidValue;

  /// Converts snake_case or any string with underscores to Title Case
  String get toTitleCase {
    return valueOrEmpty
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) =>
            word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  /// Converts camelCase or PascalCase or normal text to snake_case
  String get snakeCase {
    final regex = RegExp(r'(?<=[a-z])[A-Z]');
    return valueOrEmpty
        .replaceAllMapped(regex, (match) => '_${match.group(0)}')
        .toLowerCase()
        .replaceAll(' ', '_');
  }

  /// Returns a shortened product code by stripping the last "-xxx" part if present.
  String get shortKey {
    if (this == null || this!.isEmpty) return '';
    final raw = this!;
    return raw.contains('-') ? raw.substring(0, raw.lastIndexOf('-')) : raw;
  }

  /// ✅ Formats phone numbers like:
  /// "+919876543210" → "+91 9876543210"
  /// Leaves normal 10-digit numbers unchanged.
  String get phoneNoFormat {
    if (this == null || this!.trim().isEmpty) return '';
    final digits = this!.replaceAll(RegExp(r'\D'), '');

    if (digits.length == 12 && digits.startsWith('91')) {
      // +91XXXXXXXXXX → +91 XXXXXXXX
      return '+91 ${digits.substring(2)}';
    } else {
      // leave other formats as is
      return this!;
    }
  }
}
