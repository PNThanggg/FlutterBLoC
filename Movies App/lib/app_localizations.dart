import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/constants/languages.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    final langString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    final Map<String, dynamic> decodedLangString = json.decode(langString);
    _localizedStrings = decodedLangString
        .map<String, String>((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? 'UndefinedLocalization';
  }

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    final languagesCodes =
        Languages.languages.map<String>((e) => e.code).toList();
    return languagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
