import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../repositories/language_repository.dart';

class SavePreferencesLanguageUseCase extends UseCaseWithParams<void, String> {
  final LanguageRepository languageRepository;

  const SavePreferencesLanguageUseCase(this.languageRepository);

  @override
  ResultVoid call(String params) async {
    return await languageRepository.savePreferredLanguage(params);
  }
}
