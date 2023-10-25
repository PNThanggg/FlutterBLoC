import 'package:hive/hive.dart';

import '../../../common/constants/database_constants.dart';

abstract class LanguageLocalDataSource {
  Future<void> savePreferredLanguage(String languageCode);
  Future<String> getPreferredLanguage();
}

class LanguageLocalDataSourceImpl extends LanguageLocalDataSource {
  @override
  Future<String> getPreferredLanguage() async {
    final languageBox = await Hive.openBox(DatabaseConstants.languageBox);
    return languageBox.get(
      DatabaseConstants.preferredLanguageCode,
      defaultValue: DatabaseConstants.preferredLanguageCodeDefaultValue,
    );
  }

  @override
  Future<void> savePreferredLanguage(String languageCode) async {
    final languageBox = await Hive.openBox(DatabaseConstants.languageBox);
    await languageBox.put(
      DatabaseConstants.preferredLanguageCode,
      languageCode,
    );
  }
}
