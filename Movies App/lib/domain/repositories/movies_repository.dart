import '../../core/utils/typedef.dart';
import '../../data/local/movie_table.dart';
import '../entities/cast_member.dart';
import '../entities/movie.dart';
import '../entities/movie_details.dart';
import '../entities/search_movies_parameters.dart';
import '../entities/video.dart';

abstract class MoviesRepository {
  /// API
  ResultFuture<List<Movie>> getTrendingMovies();
  ResultFuture<List<Movie>> getPopularMovies();
  ResultFuture<List<Movie>> getNowPlayingMovies();
  ResultFuture<List<Movie>> getUpcomingMovies();
  ResultFuture<MovieDetails> getMovieDetails(int movieId);
  ResultFuture<List<CastMember>> getMovieCastMembers(int movieId);
  ResultFuture<List<Video>> getMovieVideos(int movieId);
  ResultFuture<List<Movie>> getSearchMovies(
    SearchMoviesParameters parameters,
  );

  /// Database
  ResultVoid saveFavoriteMovie(Movie movie);
  ResultVoid deleteFavoriteMovie(int movieId);
  ResultFuture<bool> isFavoriteMovieExists(int movieId);
  ResultFuture<List<MovieTable>> getAllFavoriteMovies();
}
