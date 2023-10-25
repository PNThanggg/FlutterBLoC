import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../core/errors/failure.dart';
import '../repositories/theme_repository.dart';

class GetPreferencesThemeModeUseCase {
  final ThemeRepository themeRepository;

  const GetPreferencesThemeModeUseCase(this.themeRepository);

  Either<SharedPreferencesFailure, ThemeMode> call() {
    return themeRepository.getPreferencesThemeMode();
  }
}
