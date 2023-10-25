import '../../core/utils/typedef.dart';

abstract class LanguageRepository {
  ResultFuture<String> getPreferredLanguage();
  ResultVoid savePreferredLanguage(String languageCode);
}
