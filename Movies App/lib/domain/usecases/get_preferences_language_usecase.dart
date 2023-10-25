import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../repositories/language_repository.dart';

class GetPreferencesLanguageUseCase extends UseCaseWithoutParams<String> {
  final LanguageRepository languageRepository;

  const GetPreferencesLanguageUseCase(this.languageRepository);

  @override
  ResultFuture<String> call() async {
    return await languageRepository.getPreferredLanguage();
  }
}
