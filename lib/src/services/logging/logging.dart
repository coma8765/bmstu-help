abstract class Logging {
  void debug(String message);

  void info(String message);

  void warning(String message);

  void error(String message, {Exception? error});
}
