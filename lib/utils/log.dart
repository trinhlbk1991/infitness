import 'package:fimber_io/fimber_io.dart';

class Log {
  static void i(String tag, String message) {
    Fimber.withTag(tag, (log) => log.i(message));
  }

  static void info(String message) {
    Fimber.i(message);
  }

  static void d(String tag, String message) {
    Fimber.withTag(tag, (log) => log.d(message));
  }

  static void debug(String message) {
    Fimber.d(message);
  }

  static void e(String tag, String message,
      {dynamic exception, StackTrace? stackTrace}) {
    Fimber.withTag(tag, (log) => log.e(message, ex: exception, stacktrace: stackTrace));
  }

  static void error(String message, {dynamic exception, StackTrace? stackTrace}) {
    Fimber.e(message, ex: exception, stacktrace: stackTrace);
  }
}
