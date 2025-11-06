import 'package:intl/intl.dart';

/// Shortcut alias
typedef DFU = DateFormatUtil;

/// Internal reusable formats
abstract class _DateTimeFormats {
  static final dayName = DateFormat('EEE'); // Mon
  static final dayNameFull = DateFormat('EEEE'); // Monday

  static final ddMMyyyy = DateFormat('dd-MM-yyyy'); // 02-06-2025
  static final ddMMMyyyy = DateFormat('dd-MMM-yyyy'); // 02-Jun-2025
  static final ddSlashed = DateFormat('dd/MM/yyyy'); // 02/06/2025

  static final fullDateTimeLabel =
      DateFormat('MMM d, yyyy h:mm a'); // Jun 2, 2025 1:30 PM
  static final timeOnly12h = DateFormat('h:mm a'); // 1:30 PM
  static final timeOnly24h = DateFormat('HH:mm'); // 13:30

  static final weekdayWithTime = DateFormat('EEE, h:mm a'); // Mon, 1:30 PM
  static final fullMonthDay = DateFormat('MMMM d'); // June 2
  static final yearMonth = DateFormat('yyyy-MM'); // 2025-06
  static final compactTimestamp =
      DateFormat('yyyyMMdd_HHmmss'); // 20250602_133045
  static final moreFriendlyFormat =
      DateFormat('MMM dd, yyyy'); // Jun 02, 2025 ✅

  /// ✅ Deterministic ID: date only (e.g., 20250821)
  static final dayId = DateFormat('yyyyMMdd');
}

/// Global helper for DateTime and Duration formatting
abstract class DateFormatUtil {
  static DateTime now() => DateTime.now();

  /// ✅ Returns DateTime for tomorrow
  static DateTime nextDay() => DateTime.now().add(const Duration(days: 1));

  // ----- Date Formats -----
  static String getDayName(DateTime dt) => _DateTimeFormats.dayName.format(dt);
  static String getDayNameFully(DateTime dt) =>
      _DateTimeFormats.dayNameFull.format(dt);

  static String ddMMyyyy(DateTime dt) => _DateTimeFormats.ddMMyyyy.format(dt);
  static String ddMMMyyyy(DateTime dt) => _DateTimeFormats.ddMMMyyyy.format(dt);
  static String ddSlashed(DateTime dt) => _DateTimeFormats.ddSlashed.format(dt);

  static String fullDateTimeLabel(DateTime dt) =>
      _DateTimeFormats.fullDateTimeLabel.format(dt);
  static String timeOnly12h(DateTime dt) =>
      _DateTimeFormats.timeOnly12h.format(dt);
  static String timeOnly24h(DateTime dt) =>
      _DateTimeFormats.timeOnly24h.format(dt);

  static String weekdayWithTime(DateTime dt) =>
      _DateTimeFormats.weekdayWithTime.format(dt);
  static String fullMonthDay(DateTime dt) =>
      _DateTimeFormats.fullMonthDay.format(dt);
  static String yearMonth(DateTime dt) => _DateTimeFormats.yearMonth.format(dt);
  static String compactTimestamp(DateTime dt) =>
      _DateTimeFormats.compactTimestamp.format(dt);

  /// ✅ Friendly format like "Jun 02, 2025"
  static String moreFriendlyFormat(DateTime dt) =>
      _DateTimeFormats.moreFriendlyFormat.format(dt);

  /// Deterministic day-id (e.g., 20250821)
  static String dayId(DateTime dt) => _DateTimeFormats.dayId.format(dt);

  // ----- Duration Formatter -----
  static String formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  // ----- Comparison Helpers -----
  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static bool isSameMonth(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month;

  static bool isSameMinute(DateTime a, DateTime b) =>
      a.year == b.year &&
      a.month == b.month &&
      a.day == b.day &&
      a.hour == b.hour &&
      a.minute == b.minute;
}

/// 🔑 ID Generator helpers
abstract class IdGenerator {
  /// Main Order ID for a given day → e.g., MO_20250821
  static String mainOrderId() {
    return "MO_${DateFormatUtil.dayId(DFU.nextDay())}";
  }

  /// Main Order ID for a given day → e.g., MO_20250821
  static String mainOrderIdUsingDate(DateTime selectedDate) {
    return "MO_${DateFormatUtil.dayId(selectedDate)}";
  }

  /// Actual Delivery ID for a given day → e.g., MO_20250821
  static String actualDeliveryId() {
    return "AD_${DateFormatUtil.dayId(DFU.now())}";
  }

  /// Actual Delivery ID for a given day → e.g., MO_20250821
  static String actualDeliveryIdUsingDate(DateTime selectedDate) {
    return "AD_${DateFormatUtil.dayId(selectedDate)}";
  }
}
