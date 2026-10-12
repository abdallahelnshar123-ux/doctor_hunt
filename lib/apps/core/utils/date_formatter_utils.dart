import 'package:intl/intl.dart';

class DateFormatterUtils {
  /// Formats a DateTime object to a String with format: YYYY-MM-DD
  static String formatToDateString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Formats a DateTime to a relative day and date string.
  /// Output examples: "Today, 23 Feb", "Tomorrow, 24 Feb", "Friday, 25 Feb"
  static String formatToRelativeDayAndDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final targetDate = DateTime(date.year, date.month, date.day);
    
    final formattedDate = DateFormat('d MMM').format(date);
    
    if (targetDate == today) {
      return 'Today, $formattedDate';
    } else if (targetDate == tomorrow) {
      return 'Tomorrow, $formattedDate';
    } else {
      final dayName = DateFormat('EEEE').format(date);
      return '$dayName, $formattedDate';
    }
  }
}
