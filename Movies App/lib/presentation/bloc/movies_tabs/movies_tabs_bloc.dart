import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies_usecase.dart';
import '../../../domain/usecases/get_popular_movies_usecase.dart';
import '../../../domain/usecases/get_upcoming_movies_usecase.dart';

part 'movies_tabs_event.dart';
part 'movies_tabs_state.dart';

class MoviesTabsBloc extends Bloc<MoviesTabsEvent, MoviesTabsState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;

  MoviesTabsBloc({
    required this.getNowPlayingMoviesUseCase,
    required this.getPopularMoviesUseCase,
    required this.getUpcomingMoviesUseCase,
  }) : super(const MoviesTabsInitialState()) {
    on<ChangeMoviesTabEvent>(_onChangeMoviesTabEvent);
  }

  Future<void> _onChangeMoviesTabEvent(
      ChangeMoviesTabEvent event, Emitter<MoviesTabsState> emit) async {
    emit(MovieTabsLoadingState());
    late Either<Failure, List<Movie>> response;
    switch (event.tabIndex) {
      case 0:
        response = await getPopularMoviesUseCase.call();
        break;
      case 1:
        response = await getNowPlayingMoviesUseCase.call();
        break;
      case 2:
        response = await getUpcomingMoviesUseCase.call();
        break;
    }

    response.fold(
      (appError) => emit(MoviesTabsErrorState(
          errorType: appError.errorType, currentTabIndex: event.tabIndex)),
      (movies) => emit(
        MoviesTabsLoadedState(movies: movies, currentTabIndex: event.tabIndex),
      ),
    );
  }
}
