import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/theme_prefs_constants.dart';

abstract class ThemeLocalDataSource {
  Future<void> savePreferencesThemeMode(ThemeMode themeMode);
  ThemeMode getPreferencesThemeMode();
}

class ThemeLocalDataSourceImp extends ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;
  ThemeLocalDataSourceImp({required this.sharedPreferences});

  @override
  ThemeMode getPreferencesThemeMode() {
    String? themeStringValue =
        sharedPreferences.getString(ThemePrefsConstants.prefsThemeKey);

    final themeMode = themeStringValue == ThemePrefsConstants.darkTheme
        ? ThemeMode.dark
        : ThemeMode.light;

    return themeMode;
  }

  @override
  Future<void> savePreferencesThemeMode(ThemeMode themeMode) async {
    final String themeStringValue = themeMode == ThemeMode.light
        ? ThemePrefsConstants.lightTheme
        : ThemePrefsConstants.darkTheme;
    await sharedPreferences.setString(
      ThemePrefsConstants.prefsThemeKey,
      themeStringValue,
    );
  }
}
