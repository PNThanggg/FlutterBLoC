import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/movie_details.dart';
import '../../../domain/entities/movie_details_parameters.dart';
import '../../../domain/usecases/get_movie_details_usecase.dart';
import '../loading/loading_bloc.dart';
import '../movie_cast/movie_cast_bloc.dart';
import '../movie_videos/movie_videos_bloc.dart';
import '../movies_favorite/movies_favorite_bloc.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final MovieCastBloc movieCastBloc;
  final MovieVideosBloc movieVideosBloc;
  final MoviesFavoriteBloc moviesFavoriteBloc;
  final LoadingBloc loadingBloc;

  MovieDetailsBloc({
    required this.getMovieDetailsUseCase,
    required this.movieCastBloc,
    required this.movieVideosBloc,
    required this.moviesFavoriteBloc,
    required this.loadingBloc,
  }) : super(MovieDetailsLoadingState()) {
    on<LoadMovieDetailsEvent>(_onLoadMovieDetailsEvent);
  }

  Future<void> _onLoadMovieDetailsEvent(
      LoadMovieDetailsEvent event, Emitter<MovieDetailsState> emitter) async {
    loadingBloc.add(StartLoadingEvent());

    final response = await getMovieDetailsUseCase
        .call(MovieDetailsParameters(movieId: event.movieId));

    response.fold((appError) {
      emitter(MovieDetailsErrorState(errorType: appError.errorType));
    }, (movieDetails) {
      movieCastBloc.add(LoadMovieCastEvent(movieId: event.movieId));

      movieVideosBloc.add(LoadMovieVideosEvent(movieId: event.movieId));

      moviesFavoriteBloc
          .add(MoviesFavoriteCheckIfFavoriteEvent(movieId: event.movieId));

      emitter(MovieDetailsLoadedState(movieDetails: movieDetails));
    });

    loadingBloc.add(FinishLoadingEvent());
  }
}
