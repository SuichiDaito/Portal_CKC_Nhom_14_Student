import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTime(DateTime date) {
    String formatted = DateFormat('h:mm a').format(date);
    return formatted;
  }

  static String formatDate(DateTime date) {
    String formatted = DateFormat('dd-MM-yyyy').format(date);
    return formatted;
  }
}
