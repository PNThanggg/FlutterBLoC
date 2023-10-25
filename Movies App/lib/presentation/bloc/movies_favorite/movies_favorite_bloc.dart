import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';
import '../../../data/local/movie_table.dart';
import '../../../domain/usecases/delete_favorite_movie_usecase.dart';
import '../../../domain/usecases/get_all_favorite_movies_usecase.dart';
import '../../../domain/usecases/is_favorite_movie_exists_usecase.dart';
import '../../../domain/usecases/save_favorite_movie_usecase.dart';
import '../loading/loading_bloc.dart';

part 'movies_favorite_event.dart';
part 'movies_favorite_state.dart';

class MoviesFavoriteBloc
    extends Bloc<MoviesFavoriteEvent, MoviesFavoriteState> {
  SaveFavoriteMovieUseCase saveFavoriteMovieUseCase;
  DeleteFavoriteMovieUseCase deleteFavoriteMovieUseCase;
  IsFavoriteMovieExistsUseCase isFavoriteMovieExistsUseCase;
  GetAllFavoriteMoviesUseCase getAllFavoriteMoviesUseCase;
  LoadingBloc loadingBloc;

  MoviesFavoriteBloc({
    required this.saveFavoriteMovieUseCase,
    required this.deleteFavoriteMovieUseCase,
    required this.isFavoriteMovieExistsUseCase,
    required this.getAllFavoriteMoviesUseCase,
    required this.loadingBloc,
  }) : super(MoviesFavoriteInitialState()) {
    on<MoviesFavoriteCheckIfFavoriteEvent>(
        _onMoviesFavoriteCheckIfFavoriteEvent);

    on<MoviesFavoriteToggleFavoriteEvent>(_onMoviesFavoriteToggleFavoriteEvent);

    on<MoviesFavoriteGetAllFavoritesEvent>(
        _onMoviesFavoriteGetAllFavoritesEvent);
    on<MoviesFavoriteDeleteMovieEvent>(_onMoviesFavoriteDeleteMovieEvent);
  }

////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _onMoviesFavoriteCheckIfFavoriteEvent(
    MoviesFavoriteCheckIfFavoriteEvent event,
    Emitter<MoviesFavoriteState> emitter,
  ) async {
    final response = await isFavoriteMovieExistsUseCase.call(event.movieId);

    response.fold((appError) {
      emitter(MoviesFavoriteErrorState(errorType: appError.errorType));
    }, (isFavorite) {
      emitter(MoviesFavoriteIsFavoriteOrNotState(
          isFavorite: isFavorite, movieId: event.movieId));
    });
  }
////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _onMoviesFavoriteToggleFavoriteEvent(
    MoviesFavoriteToggleFavoriteEvent event,
    Emitter<MoviesFavoriteState> emitter,
  ) async {
    final movieTable = event.movieTable;
    if (event.isFavorite) {
      await deleteFavoriteMovieUseCase.call(movieTable.id!);
    } else {
      await saveFavoriteMovieUseCase.call(movieTable);
    }

    final response = await isFavoriteMovieExistsUseCase.call(movieTable.id!);
    response.fold((appError) {
      emitter(MoviesFavoriteErrorState(errorType: appError.errorType));
    }, (isExisting) {
      emitter(MoviesFavoriteIsFavoriteOrNotState(
          isFavorite: isExisting, movieId: movieTable.id!));
    });
  }
////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _onMoviesFavoriteGetAllFavoritesEvent(
    MoviesFavoriteGetAllFavoritesEvent event,
    Emitter<MoviesFavoriteState> emitter,
  ) async {
    loadingBloc.add(StartLoadingEvent());

    final response = await getAllFavoriteMoviesUseCase.call();
    response.fold((appError) {
      emitter(MoviesFavoriteErrorState(errorType: appError.errorType));
    }, (favoriteMovies) {
      emitter(MoviesFavoriteLoadedState(favoriteMovies: favoriteMovies));
    });

    loadingBloc.add(FinishLoadingEvent());
  }

////////////////////////////////////////////////////////////////////////////////////////
  Future<void> _onMoviesFavoriteDeleteMovieEvent(
    MoviesFavoriteDeleteMovieEvent event,
    Emitter<MoviesFavoriteState> emitter,
  ) async {
    await deleteFavoriteMovieUseCase.call(event.movieId);
    final response = await getAllFavoriteMoviesUseCase.call();

    response.fold(
      (l) => emitter(MoviesFavoriteErrorState(errorType: l.errorType)),
      (r) => emitter(
        MoviesFavoriteLoadedState(favoriteMovies: r),
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////////////
}
