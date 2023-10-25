import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/movie_details_parameters.dart';
import '../../../domain/entities/video.dart';
import '../../../domain/usecases/get_movie_videos_usecase.dart';

part 'movie_videos_event.dart';
part 'movie_videos_state.dart';

class MovieVideosBloc extends Bloc<MovieVideosEvent, MovieVideosState> {
  final GetMovieVideoUseCase getMovieVideoUseCase;

  MovieVideosBloc({
    required this.getMovieVideoUseCase,
  }) : super(MovieVideosLoadingState()) {
    on<LoadMovieVideosEvent>(_onLoadMovieVideosEvent);
  }

  Future<void> _onLoadMovieVideosEvent(
      LoadMovieVideosEvent event, Emitter<MovieVideosState> emitter) async {
    final Either<Failure, List<Video>> response = await getMovieVideoUseCase
        .call(MovieDetailsParameters(movieId: event.movieId));

    response.fold((appError) {
      emitter(MovieVideosErrorState(errorType: appError.errorType));
    }, (movieVideos) {
      emitter(MovieVideosLoadedState(movieVideos: movieVideos));
    });
  }
}
