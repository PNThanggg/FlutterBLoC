import 'package:equatable/equatable.dart';

import 'api_exception.dart';

abstract class Failure extends Equatable {
  const Failure({
    this.message,
    this.statusCode,
    required this.errorType,
  });

  final String? message;
  final int? statusCode;
  final ErrorType errorType;

  @override
  List<Object> get props => [message ?? "", statusCode ?? -1];
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message,
    super.statusCode,
    super.errorType = ErrorType.network,
  });

  NetworkFailure.fromException(ApiException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class SharedPreferencesFailure extends Failure {
  const SharedPreferencesFailure({
    super.message,
    super.statusCode,
    super.errorType = ErrorType.sharedPreferences,
  });

  SharedPreferencesFailure.fromException(ApiException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

enum ErrorType {
  api,
  network,
  database,
  sharedPreferences,
}
