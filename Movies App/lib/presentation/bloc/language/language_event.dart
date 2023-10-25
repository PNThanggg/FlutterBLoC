part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class GetPreferredLanguageEvent extends LanguageEvent {}

class ChangePreferencesLanguageEvent extends LanguageEvent {
  final Language language;

  const ChangePreferencesLanguageEvent({required this.language});

  @override
  List<Object> get props => [language.code];
}
