import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime date) {
    return DateFormat('EEEE, MMM d, yyyy').format(date);
  }
  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year && now.month == date.month && now.day == date.day;
  }

  static bool isPastDate(DateTime date) {
    return date.isBefore(DateTime.now().subtract(const Duration(days: 1)));
  }
  static String getCurrentTimestamp() {
    return formatDateTime(DateTime.now());
  }
}
