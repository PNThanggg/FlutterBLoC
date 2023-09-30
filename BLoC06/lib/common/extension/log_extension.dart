import '../utils/app_log.dart';

extension Log on Object? {
  void info({String tag = "Info"}) => AppLog.info(this, tag: tag);

  void debug({String tag = "Debug"}) => AppLog.debug(this, tag: tag);

  void error({String tag = "Error"}) => AppLog.error(this, tag: tag);

  void warning({String tag = "Warning"}) => AppLog.warning(this, tag: tag);

  void verbose({String tag = "Verbose"}) => AppLog.verbose(this);

  void logWtf({String tag = "Verbose"}) => AppLog.logWtf(this);
}
