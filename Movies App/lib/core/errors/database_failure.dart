import 'package:hive/hive.dart';

import 'failure.dart';

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    super.message,
    super.errorType = ErrorType.database,
  });

  DatabaseFailure.fromException(HiveError exception)
      : this(
          message: exception.message,
        );
}
