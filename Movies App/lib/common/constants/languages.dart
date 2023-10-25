import '../../domain/entities/language.dart';
import 'language_constants.dart';

class Languages {
  Languages._();

  static List<Language> languages = [
    const Language(code: 'en', value: LanguageConstants.english),
    const Language(code: 'ar', value: LanguageConstants.arabic),
  ];
}
