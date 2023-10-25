import 'package:dartz/dartz.dart';

import '../../../core/errors/database_failure.dart';
import '../../../core/utils/typedef.dart';
import '../../../domain/repositories/language_repository.dart';
import '../data_source/language_local_data_source.dart';

class LanguageRepositoryImpl extends LanguageRepository {
  final LanguageLocalDataSource languageLocalDataSource;

  LanguageRepositoryImpl(this.languageLocalDataSource);

  @override
  ResultFuture<String> getPreferredLanguage() async {
    try {
      final langCode = await languageLocalDataSource.getPreferredLanguage();
      return Right(langCode);
    } on Exception {
      return const Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  ResultVoid savePreferredLanguage(String languageCode) async {
    try {
      return Right(
        await languageLocalDataSource.savePreferredLanguage(languageCode),
      );
    } on Exception {
      return const Left(
        DatabaseFailure(),
      );
    }
  }
}
