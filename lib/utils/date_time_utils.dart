import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static const FORMAT_DD_MM_YYYY = 'dd MMM, yyyy';
  static const FORMAT_DD_MM_YYYY_HH_MM = 'dd MMM, yyyy HH:mm';

  static int currentTimeUtc() => DateTime.now().toUtc().millisecondsSinceEpoch;

  static int daysToMilliseconds(int day) => day * 24 * 60 * 60 * 1000;

  static String format(DateTime dateTime, String pattern) {
    final formatter = DateFormat(pattern);
    return formatter.format(dateTime);
  }

  static String formatMonth(DateTime dateTime) {
    final formatter = DateFormat('MMM yyyy');
    return formatter.format(dateTime);
  }

  static String formatSimple(DateTime dateTime) {
    final formatter = DateFormat('dd-MM-yyy');
    return formatter.format(dateTime);
  }

  static bool isSameWeek(DateTime first, DateTime second) {
    return first.add(Duration(days: -first.weekday)).day ==
        second.add(Duration(days: -second.weekday)).day;
  }

  static DateTime parse(String string, String format) {
    final formatter = DateFormat(format);
    return formatter.parseLoose(string);
  }
}
