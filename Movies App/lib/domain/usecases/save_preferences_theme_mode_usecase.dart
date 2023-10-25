import 'package:flutter/material.dart';

import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../repositories/theme_repository.dart';

class SavePreferencesThemeModeUseCase
    extends UseCaseWithParams<void, ThemeMode> {
  final ThemeRepository themeRepository;

  const SavePreferencesThemeModeUseCase(this.themeRepository);

  @override
  ResultVoid call(ThemeMode params) async {
    return themeRepository.savePreferencesThemeMode(params);
  }
}
