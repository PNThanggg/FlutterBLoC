import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/app_log.dart';
import '../../../domain/entities/movie.dart';

part 'movies_backdrop_event.dart';
part 'movies_backdrop_state.dart';

class MoviesBackdropBloc
    extends Bloc<MoviesBackdropEvent, MoviesBackdropState> {

  MoviesBackdropBloc() : super(MoviesBackdropInitialState()) {
    AppLog.info("MoviesBackdropBloc Created");

    on<LoadMovieBackdropEvent>(_onLoadMovieBackdropEvent);
  }

  void _onLoadMovieBackdropEvent(
      LoadMovieBackdropEvent event, Emitter<MoviesBackdropState> emit) {
    emit(MoviesBackdropLoadedState(movie: event.movie));
  }
}
