import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/usecases/get_preferences_theme_mode_usecase.dart';
import '../../../domain/usecases/save_preferences_theme_mode_usecase.dart';

part 'theme_mode_event.dart';
part 'theme_mode_state.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeModeState> {
  final SavePreferencesThemeModeUseCase savePreferencesThemeModeUseCase;
  final GetPreferencesThemeModeUseCase getPreferencesThemeModeUseCase;

  ThemeModeBloc(
      this.getPreferencesThemeModeUseCase, this.savePreferencesThemeModeUseCase)
      : super(ThemeModeInitial()) {
    on<ChangeThemeModeEvent>(_onChangeThemeModeEvent);
    on<GetThemeModeEvent>(_onGetThemeModeEvent);
  }

  Future<void> _onChangeThemeModeEvent(
      ChangeThemeModeEvent event, Emitter<ThemeModeState> emitter) async {
    final response =
        await savePreferencesThemeModeUseCase.call(event.themeMode);
    response.fold((appError) {
      emitter(ThemeModeErrorState(errorType: appError.errorType));
    }, (_) {
      emitter(ThemeModeLoadedState(themeMode: event.themeMode));
    });
  }

  void _onGetThemeModeEvent(
      GetThemeModeEvent event, Emitter<ThemeModeState> emit) {
    final response = getPreferencesThemeModeUseCase.call();

    response.fold((appError) {
      emit(ThemeModeErrorState(errorType: appError.errorType));
    }, (themeMode) {
      emit(ThemeModeLoadedState(themeMode: themeMode));
    });
  }
}
