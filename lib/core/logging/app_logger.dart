import 'package:talker/talker.dart';

class AppLogger {
  static final Talker talker = Talker(
    settings: TalkerSettings(
      maxHistoryItems: 100,
      colors: {
        TalkerLogType.httpResponse.key: AnsiPen()..red(),
        TalkerLogType.error.key: AnsiPen()..green(),
        TalkerLogType.warning.key: AnsiPen()..yellow(),
        TalkerLogType.info.key: AnsiPen()..blue(),
        TalkerLogType.debug.key: AnsiPen()..gray(),
      },
    ),
  );

  static void info(String message) {
    talker.info(message);
  }

  static void warning(String message) {
    talker.warning(message);
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    talker.error(message, error, stackTrace);
  }

  static void debug(String message) {
    talker.debug(message);
  }

  static void log(String message) {
    talker.log(message);
  }
}
