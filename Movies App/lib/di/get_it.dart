import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/remote/data_source/language_local_data_source.dart';
import '../data/remote/data_source/movies_local_data_source.dart';
import '../data/remote/data_source/movies_remote_data_source.dart';
import '../data/remote/data_source/theme_local_data_source.dart';
import '../data/remote/repositories/language_repository_impl.dart';
import '../data/remote/repositories/movies_repository_impl.dart';
import '../data/remote/repositories/theme_repository_impl.dart';
import '../domain/repositories/language_repository.dart';
import '../domain/repositories/movies_repository.dart';
import '../domain/repositories/theme_repository.dart';
import '../domain/usecases/delete_favorite_movie_usecase.dart';
import '../domain/usecases/get_all_favorite_movies_usecase.dart';
import '../domain/usecases/get_movie_cast_members_usecase.dart';
import '../domain/usecases/get_movie_details_usecase.dart';
import '../domain/usecases/get_movie_videos_usecase.dart';
import '../domain/usecases/get_now_playing_movies_usecase.dart';
import '../domain/usecases/get_popular_movies_usecase.dart';
import '../domain/usecases/get_preferences_language_usecase.dart';
import '../domain/usecases/get_preferences_theme_mode_usecase.dart';
import '../domain/usecases/get_search_movies_usecase.dart';
import '../domain/usecases/get_trending_movies_usecase.dart';
import '../domain/usecases/get_upcoming_movies_usecase.dart';
import '../domain/usecases/is_favorite_movie_exists_usecase.dart';
import '../domain/usecases/save_favorite_movie_usecase.dart';
import '../domain/usecases/save_preferences_language_usecase.dart';
import '../domain/usecases/save_preferences_theme_mode_usecase.dart';
import '../presentation/bloc/language/language_bloc.dart';
import '../presentation/bloc/loading/loading_bloc.dart';
import '../presentation/bloc/movie_cast/movie_cast_bloc.dart';
import '../presentation/bloc/movie_details/movie_details_bloc.dart';
import '../presentation/bloc/movie_videos/movie_videos_bloc.dart';
import '../presentation/bloc/movies_backdrop/movies_backdrop_bloc.dart';
import '../presentation/bloc/movies_carousel/movies_carousel_bloc.dart';
import '../presentation/bloc/movies_favorite/movies_favorite_bloc.dart';
import '../presentation/bloc/movies_search/movies_search_bloc.dart';
import '../presentation/bloc/movies_tabs/movies_tabs_bloc.dart';
import '../presentation/bloc/theme_mode/theme_mode_bloc.dart';

final getItInstance = GetIt.instance;

Future<void> init() async {
  getItInstance.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  getItInstance.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl());
  getItInstance.registerLazySingleton<MoviesLocalDatasource>(
      () => MoviesLocalDataSourceImpl());
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImp(sharedPreferences: getItInstance()));
  getItInstance.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<LanguageRepository>(
      () => LanguageRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(getItInstance()));

//////////////////////////////////////// UseCases /////////////////////////////////////////////////
  getItInstance.registerLazySingleton<GetTrendingMoviesUseCase>(
      () => GetTrendingMoviesUseCase(getItInstance()));
  getItInstance.registerLazySingleton<GetPopularMoviesUseCase>(
      () => GetPopularMoviesUseCase(getItInstance()));
  getItInstance.registerLazySingleton<GetNowPlayingMoviesUseCase>(
      () => GetNowPlayingMoviesUseCase(getItInstance()));
  getItInstance.registerLazySingleton<GetUpcomingMoviesUseCase>(
      () => GetUpcomingMoviesUseCase(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetailsUseCase>(
      () => GetMovieDetailsUseCase(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieCastMembersUseCase>(
      () => GetMovieCastMembersUseCase(moviesRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetMovieVideoUseCase>(
      () => GetMovieVideoUseCase(moviesRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetSearchMoviesUseCase>(
      () => GetSearchMoviesUseCase(getItInstance()));
  ////////////////////////////////////////////
  getItInstance.registerLazySingleton<SaveFavoriteMovieUseCase>(
      () => SaveFavoriteMovieUseCase(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavoriteMovieUseCase>(
      () => DeleteFavoriteMovieUseCase(getItInstance()));

  getItInstance.registerLazySingleton<IsFavoriteMovieExistsUseCase>(
      () => IsFavoriteMovieExistsUseCase(getItInstance()));

  getItInstance.registerLazySingleton<GetAllFavoriteMoviesUseCase>(
      () => GetAllFavoriteMoviesUseCase(getItInstance()));

  ////////////////////////////////////////////
  getItInstance.registerLazySingleton<GetPreferencesLanguageUseCase>(
      () => GetPreferencesLanguageUseCase(getItInstance()));
  getItInstance.registerLazySingleton<SavePreferencesLanguageUseCase>(
      () => SavePreferencesLanguageUseCase(getItInstance()));

  /////////////////////////////////////////////
  getItInstance.registerLazySingleton<SavePreferencesThemeModeUseCase>(
      () => SavePreferencesThemeModeUseCase(getItInstance()));
  getItInstance.registerLazySingleton<GetPreferencesThemeModeUseCase>(
      () => GetPreferencesThemeModeUseCase(getItInstance()));

/////////////////////////////////////// Blocs //////////////////////////////////////////////////
  getItInstance.registerFactory<MoviesBackdropBloc>(() => MoviesBackdropBloc());

  getItInstance.registerFactory<MoviesCarouselBloc>(() => MoviesCarouselBloc(
        getTrendingMoviesUseCase: getItInstance(),
        moviesBackdropBloc: getItInstance(),
        loadingBloc: getItInstance(),
      ));

  getItInstance.registerFactory<MoviesTabsBloc>(() => MoviesTabsBloc(
        getNowPlayingMoviesUseCase: getItInstance(),
        getPopularMoviesUseCase: getItInstance(),
        getUpcomingMoviesUseCase: getItInstance(),
      ));

  getItInstance.registerFactory<MovieDetailsBloc>(() => MovieDetailsBloc(
        getMovieDetailsUseCase: getItInstance(),
        movieCastBloc: getItInstance(),
        movieVideosBloc: getItInstance(),
        moviesFavoriteBloc: getItInstance(),
        loadingBloc: getItInstance(),
      ));

  getItInstance.registerFactory<MovieCastBloc>(
      () => MovieCastBloc(getMovieCastMembersUseCase: getItInstance()));

  getItInstance.registerFactory<MovieVideosBloc>(() => MovieVideosBloc(
        getMovieVideoUseCase: getItInstance(),
      ));

  getItInstance.registerFactory<MoviesSearchBloc>(
    () => MoviesSearchBloc(
      searchMoviesUseCase: getItInstance(),
    ),
  );

  getItInstance.registerFactory<MoviesFavoriteBloc>(() => MoviesFavoriteBloc(
        saveFavoriteMovieUseCase: getItInstance(),
        deleteFavoriteMovieUseCase: getItInstance(),
        isFavoriteMovieExistsUseCase: getItInstance(),
        getAllFavoriteMoviesUseCase: getItInstance(),
        loadingBloc: getItInstance(),
      ));

  ///////////////////////////
  getItInstance.registerSingleton<ThemeModeBloc>(ThemeModeBloc(
    getItInstance(),
    getItInstance(),
  ));

  getItInstance.registerSingleton<LoadingBloc>(LoadingBloc());

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc(
    getPreferencesLanguageUseCase: getItInstance(),
    savePreferencesLanguageUseCase: getItInstance(),
  ));
}
