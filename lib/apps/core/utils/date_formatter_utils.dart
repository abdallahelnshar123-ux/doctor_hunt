import 'package:intl/intl.dart';

import '../../../../generated/translations.g.dart';

class DateFormatterUtils {
  /// Formats a DateTime object to a String with format: YYYY-MM-DD
  static String formatToDateString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Formats a DateTime to a relative day and date string.
  /// Output examples: "Today, 23 Feb" / "اليوم، 23 فبراير"
  static String formatToRelativeDayAndDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final targetDate = DateTime(date.year, date.month, date.day);

    final locale = LocaleSettings.currentLocale.languageCode;
    final formattedDate = DateFormat('d MMM', locale).format(date);

    if (targetDate == today) {
      return '${t.core.common.today}, $formattedDate';
    } else if (targetDate == tomorrow) {
      return '${t.core.common.tomorrow}, $formattedDate';
    } else {
      final dayName = DateFormat('EEEE', locale).format(date);
      return '$dayName, $formattedDate';
    }
  }

  /// Formats a DateTime to a localized Date string (e.g. 23 Feb 2026 / 23 فبراير 2026)
  static String formatLocalizedDate(DateTime date, {String pattern = 'dd MMM yyyy'}) {
    final locale = LocaleSettings.currentLocale.languageCode;
    return DateFormat(pattern, locale).format(date);
  }

  /// Formats a DateTime to a localized Time string (e.g. 09:30 AM / 09:30 ص)
  static String formatLocalizedTime(DateTime date, {String pattern = 'hh:mm a'}) {
    final locale = LocaleSettings.currentLocale.languageCode;
    return DateFormat(pattern, locale).format(date);
  }
}
