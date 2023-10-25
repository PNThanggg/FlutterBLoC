import 'api_exception.dart';
import 'failure.dart';

class ApiFailure extends Failure {
  const ApiFailure({
    super.message,
    super.statusCode,
    super.errorType = ErrorType.api,
  });

  ApiFailure.fromException(ApiException exception)
      : this(
    message: exception.message,
    statusCode: exception.statusCode,
  );
}