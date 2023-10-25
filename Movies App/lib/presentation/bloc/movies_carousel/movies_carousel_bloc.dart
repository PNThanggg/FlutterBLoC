import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_trending_movies_usecase.dart';
import '../loading/loading_bloc.dart';
import '../movies_backdrop/movies_backdrop_bloc.dart';

part 'movies_carousel_event.dart';
part 'movies_carousel_state.dart';

class MoviesCarouselBloc
    extends Bloc<MoviesCarouselEvent, MoviesCarouselState> {
  final GetTrendingMoviesUseCase getTrendingMoviesUseCase;
  final MoviesBackdropBloc moviesBackdropBloc;
  final LoadingBloc loadingBloc;

  MoviesCarouselBloc({
    required this.getTrendingMoviesUseCase,
    required this.moviesBackdropBloc,
    required this.loadingBloc,
  }) : super(MoviesCarouselInitialState()) {
    on<MoviescarouselLoadEvent>(_onLoadMoviesCarouselEvent);
  }

  Future<void> _onLoadMoviesCarouselEvent(
      MoviescarouselLoadEvent event, Emitter<MoviesCarouselState> emit) async {
    loadingBloc.add(StartLoadingEvent());

    final response = await getTrendingMoviesUseCase.call();

    response.fold(
      (appError) =>
          emit(MoviesCarouselErrorState(errorType: appError.errorType)),
      (movies) {
        // Fire loading first movie backDrop
        moviesBackdropBloc
            .add(LoadMovieBackdropEvent(movie: movies[event.defaultIndex]));
        emit(
          MoviesCarouselLoadedState(
            carouselMovies: movies,
            defaultIndex: event.defaultIndex,
          ),
        );
      },
    );

    loadingBloc.add(FinishLoadingEvent());
  }
}
