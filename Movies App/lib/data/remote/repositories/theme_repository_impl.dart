import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/errors/failure.dart';
import '../../../core/utils/typedef.dart';
import '../../../domain/repositories/theme_repository.dart';
import '../data_source/theme_local_data_source.dart';

class ThemeRepositoryImpl extends ThemeRepository {
  final ThemeLocalDataSource themeLocalDataSource;

  ThemeRepositoryImpl(this.themeLocalDataSource);

  @override
  Either<SharedPreferencesFailure, ThemeMode> getPreferencesThemeMode() {
    try {
      ThemeMode themeMode = themeLocalDataSource.getPreferencesThemeMode();
      return Right(themeMode);
    } on Exception {
      return const Left(SharedPreferencesFailure());
    }
  }

  @override
  ResultVoid savePreferencesThemeMode(ThemeMode themeMode) async {
    try {
      final response =
          await themeLocalDataSource.savePreferencesThemeMode(themeMode);
      return Right(response);
    } on Exception {
      return const Left(SharedPreferencesFailure());
    }
  }
}
