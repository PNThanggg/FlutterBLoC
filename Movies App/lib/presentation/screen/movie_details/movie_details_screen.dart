import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/extensions/string_extensions.dart';

import '../../../common/constants/language_constants.dart';
import '../../../di/get_it.dart';
import '../../bloc/movie_cast/movie_cast_bloc.dart';
import '../../bloc/movie_details/movie_details_bloc.dart';
import '../../bloc/movie_videos/movie_videos_bloc.dart';
import '../../bloc/movies_favorite/movies_favorite_bloc.dart';
import '../../drawer/navigation_drawer.dart';
import '../../widgets/app_error.wiget.dart';
import 'movie_details_cast_widget.dart';
import 'movie_details_poster_widget.dart';
import 'wath_videos_button_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsBloc _movieDetailsBloc;
  late MovieCastBloc _movieCastBloc;
  late MovieVideosBloc _movieVideosBloc;
  late MoviesFavoriteBloc _moviesFavoriteBloc;

  @override
  void initState() {
    super.initState();

    _movieDetailsBloc = getItInstance();
    _movieDetailsBloc.add(LoadMovieDetailsEvent(movieId: widget.movieId));
    _movieCastBloc = _movieDetailsBloc.movieCastBloc;
    _movieVideosBloc = _movieDetailsBloc.movieVideosBloc;
    _moviesFavoriteBloc = _movieDetailsBloc.moviesFavoriteBloc;
  }

  @override
  void dispose() {
    _movieDetailsBloc.close();
    _movieCastBloc.close();
    _movieVideosBloc.close();
    _moviesFavoriteBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailsBloc>.value(value: _movieDetailsBloc),
        BlocProvider<MovieCastBloc>.value(value: _movieCastBloc),
        BlocProvider<MovieVideosBloc>.value(value: _movieVideosBloc),
        BlocProvider<MoviesFavoriteBloc>.value(value: _moviesFavoriteBloc),
      ],
      child: Scaffold(
          drawer: const CustomNavigationDrawer(),
          body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
            builder: (context, state) {
              if (state is MovieDetailsErrorState) {
                return AppErrorWidget(
                    errorType: state.errorType,
                    handleRetryPress: () {
                      _movieDetailsBloc
                          .add(LoadMovieDetailsEvent(movieId: widget.movieId));
                    });
              } else if (state is MovieDetailsLoadedState) {
                final movie = state.movieDetails;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      MovieDetailsPosterWidget(movie: movie),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          movie.overview!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Text(
                          LanguageConstants.cast.translate(context),
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      MovieDetailsCastWidget(movieId: widget.movieId),
                      WatchVideosButtonWidget(movieId: widget.movieId),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }
}
