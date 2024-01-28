import 'package:bmstu_help/src/services/logging/logging.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class FimberLogging implements Logging {

  FimberLogging(String name) {
    fimber = FimberLog(name);
  }
  late FimberLog fimber;

  @override
  void debug(String message) {
    fimber.d(message);
  }

  @override
  void info(String message) {
    fimber.i(message);
  }

  @override
  void warning(String message) {
    fimber.w(message);
  }

  @override
  void error(String message, {Exception? error}) {
    fimber.e(message, ex: error);
  }
}
