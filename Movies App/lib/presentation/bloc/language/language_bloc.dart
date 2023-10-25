import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/app_log.dart';
import '../../../core/errors/failure.dart';
import '../../../domain/entities/language.dart';
import '../../../domain/usecases/get_preferences_language_usecase.dart';
import '../../../domain/usecases/save_preferences_language_usecase.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  GetPreferencesLanguageUseCase getPreferencesLanguageUseCase;
  SavePreferencesLanguageUseCase savePreferencesLanguageUseCase;

  LanguageBloc({
    required this.getPreferencesLanguageUseCase,
    required this.savePreferencesLanguageUseCase,
  }) : super(LanguageLoadingState()) {
    on<ChangePreferencesLanguageEvent>(_onChangePreferencesLanguageEvent);
    on<GetPreferredLanguageEvent>(_onGetPreferencesLanguageEvent);
  }

  Future<void> _onChangePreferencesLanguageEvent(
      ChangePreferencesLanguageEvent event, Emitter<LanguageState> emit) async {
    final response =
        await savePreferencesLanguageUseCase.call(event.language.code);

    response.fold((appError) {
      emit(const LanguageErrorState(errorType: ErrorType.api));
    }, (_) {
      emit(LanguageLoadedState(locale: Locale(event.language.code)));
    });
  }

  void _onGetPreferencesLanguageEvent(
      GetPreferredLanguageEvent event, Emitter<LanguageState> emit) async {
    final response = await getPreferencesLanguageUseCase.call();

    AppLog.debug(response, tag: "_onGetPreferencesLanguageEvent()");

    response.fold((appError) {
      emit(const LanguageErrorState(errorType: ErrorType.api));
    }, (langCode) {
      emit(LanguageLoadedState(locale: Locale(langCode)));
    });
  }
}
