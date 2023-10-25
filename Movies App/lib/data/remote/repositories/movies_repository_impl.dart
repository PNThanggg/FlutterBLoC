import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/errors/api_failure.dart';
import '../../../core/errors/database_failure.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils/typedef.dart';
import '../../../domain/entities/cast_member.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_details.dart';
import '../../../domain/entities/search_movies_parameters.dart';
import '../../../domain/entities/video.dart';
import '../../../domain/repositories/movies_repository.dart';
import '../../local/movie_table.dart';
import '../data_source/movies_local_data_source.dart';
import '../data_source/movies_remote_data_source.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesRemoteDataSource moviesRemoteDataSource;
  final MoviesLocalDatasource moviesLocalDatasource;

  MoviesRepositoryImpl(this.moviesRemoteDataSource, this.moviesLocalDatasource);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  ResultFuture<List<Movie>> getTrendingMovies() async {
    try {
      final movies = await moviesRemoteDataSource.getTrendingMovies();
      return Right(movies);
    } on SocketException {
      return const Left(NetworkFailure());
    } on Exception {
      return const Left(ApiFailure());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  ResultFuture<List<Movie>> getNowPlayingMovies() async {
    try {
      final movies = await moviesRemoteDataSource.getNowPlayingMovies();
      return Right(movies);
    } on SocketException {
      return const Left(NetworkFailure());
    } on Exception {
      return const Left(ApiFailure());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  ResultFuture<List<Movie>> getPopularMovies() async {
    try {
      final movies = await moviesRemoteDataSource.getPopularMovies();
      return Right(movies);
    } on SocketException {
      return const Left(NetworkFailure());
    } on Exception {
      return const Left(ApiFailure());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  ResultFuture<List<Movie>> getUpcomingMovies() async {
    try {
      final movies = await moviesRemoteDataSource.getUpcomingMovies();
      return Right(movies);
    } on SocketException {
      return const Left(NetworkFailure());
    } on Exception {
      return const Left(ApiFailure());
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  ResultFuture<MovieDetails> getMovieDetails(int movieId) async {
    try {
      final MovieDetails movie =
          await moviesRemoteDataSource.getMovieDetails(movieId);
      return Right(movie);
    } on SocketException {
      return const Left(NetworkFailure());
    } on Exception {
      return const Left(ApiFailure());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  ResultFuture<List<CastMember>> getMovieCastMembers(int movieId) async {
    try {
      final castMembers =
          await moviesRemoteDataSource.getMovieCastMembers(movieId);
      return Right(castMembers);
    } on SocketException {
      return const Left(NetworkFailure());
    } on Exception {
      return const Left(ApiFailure());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  ResultFuture<List<Video>> getMovieVideos(int movieId) async {
    try {
      final videos = await moviesRemoteDataSource.getMovieVideos(movieId);
      return Right(videos);
    } on SocketException {
      return const Left(NetworkFailure());
    } on Exception {
      return const Left(ApiFailure());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  ResultFuture<List<Movie>> getSearchMovies(
      SearchMoviesParameters parameters) async {
    try {
      final movies = await moviesRemoteDataSource.getSearchMovies(parameters);
      return Right(movies);
    } on SocketException {
      return const Left(NetworkFailure());
    } on Exception {
      return const Left(ApiFailure());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  ResultVoid deleteFavoriteMovie(int movieId) async {
    try {
      final response = await moviesLocalDatasource.deleteFavoriteMovie(movieId);
      return Right(response);
    } on Exception {
      return const Left(DatabaseFailure());
    }
  }

  @override
  ResultFuture<List<MovieTable>> getAllFavoriteMovies() async {
    try {
      final movies = await moviesLocalDatasource.getAllFavoriteMovies();
      return Right(movies);
    } on Exception {
      return const Left(DatabaseFailure());
    }
  }

  @override
  ResultFuture<bool> isFavoriteMovieExists(int movieId) async {
    try {
      final response =
          await moviesLocalDatasource.isFavoriteMovieExists(movieId);
      return Right(response);
    } on Exception {
      return const Left(DatabaseFailure());
    }
  }

  @override
  ResultVoid saveFavoriteMovie(Movie movie) async {
    try {
      final response = await moviesLocalDatasource
          .saveFavoriteMovie(MovieTable.fromMovie(movie));
      return Right(response);
    } on Exception {
      return const Left(DatabaseFailure());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////
}
