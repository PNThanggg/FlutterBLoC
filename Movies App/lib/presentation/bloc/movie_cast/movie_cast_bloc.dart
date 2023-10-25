import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/app_log.dart';
import '../../../core/errors/failure.dart';
import '../../../domain/entities/cast_member.dart';
import '../../../domain/entities/movie_details_parameters.dart';
import '../../../domain/usecases/get_movie_cast_members_usecase.dart';

part 'movie_cast_event.dart';
part 'movie_cast_state.dart';

class MovieCastBloc extends Bloc<MovieCastEvent, MovieCastState> {
  final GetMovieCastMembersUseCase getMovieCastMembersUseCase;

  MovieCastBloc({
    required this.getMovieCastMembersUseCase,
  }) : super(MovieCastLoadingState()) {
    AppLog.info("MovieCastBloc Created with hash $hashCode");
    on<LoadMovieCastEvent>(_onLoadMovieCastEvent);
  }

  Future<void> _onLoadMovieCastEvent(
      LoadMovieCastEvent event, Emitter<MovieCastState> emitter) async {

    emitter(MovieCastLoadingState());

    final response = await getMovieCastMembersUseCase
        .call(MovieDetailsParameters(movieId: event.movieId));

    response.fold((appError) {
      emitter(MovieCastErrorState(errorType: appError.errorType));
    }, (castMembers) {
      emitter(MovieCastLoadedState(castMembers: castMembers));
    });
  }
}
