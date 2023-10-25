import 'dart:developer';

import '../../logger.dart';

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(log);
  }
}
