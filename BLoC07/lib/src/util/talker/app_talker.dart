import 'package:flutter/foundation.dart';

import 'talker.dart';

class AppTalker {
  AppTalker._();

  static Talker talker = Talker();

  static debug(dynamic message) {
    if (kDebugMode) {
      talker.debug(message);
    }
  }

  static info(dynamic message) {
    if (kDebugMode) {
      talker.info(message);
    }
  }

  static warning(dynamic message) {
    if (kDebugMode) {
      talker.warning(message);
    }
  }

  static error(dynamic message) {
    if (kDebugMode) {
      talker.error(message);
    }
  }

  static verbose(dynamic message) {
    if (kDebugMode) {
      talker.good(message);
    }
  }
}
