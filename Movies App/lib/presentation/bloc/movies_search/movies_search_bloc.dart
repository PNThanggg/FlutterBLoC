import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/search_movies_parameters.dart';
import '../../../domain/usecases/get_search_movies_usecase.dart';

part 'movies_search_event.dart';
part 'movies_search_state.dart';

class MoviesSearchBloc extends Bloc<MoviesSearchEvent, MoviesSearchState> {
  final GetSearchMoviesUseCase searchMoviesUseCase;

  MoviesSearchBloc({
    required this.searchMoviesUseCase,
  }) : super(MoviesSearchInitialState()) {
    on<LoadMoviesSearchEvent>(_onLoadMoviesSearchEvent);
  }

  Future<void> _onLoadMoviesSearchEvent(
      LoadMoviesSearchEvent event, Emitter<MoviesSearchState> emitter) async {
    final response =
        await searchMoviesUseCase.call(event.searchMoviesParameters);

    response.fold((appError) {
      emitter(MoviesSearchErrorState(errorType: appError.errorType));
    }, (movies) {
      emitter(MoviesSearchLoadedState(movies: movies));
    });
  }
}
