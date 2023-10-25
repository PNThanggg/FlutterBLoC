import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../core/errors/failure.dart';
import '../../core/utils/typedef.dart';

abstract class ThemeRepository {
  ResultVoid savePreferencesThemeMode(ThemeMode themeMode);

  Either<SharedPreferencesFailure, ThemeMode> getPreferencesThemeMode();
}
