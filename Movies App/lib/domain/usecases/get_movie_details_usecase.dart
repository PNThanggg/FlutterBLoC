import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../entities/movie_details.dart';
import '../entities/movie_details_parameters.dart';
import '../repositories/movies_repository.dart';

class GetMovieDetailsUseCase
    extends UseCaseWithParams<MovieDetails, MovieDetailsParameters> {
  final MoviesRepository moviesRepository;
  const GetMovieDetailsUseCase(this.moviesRepository);

  @override
  ResultFuture<MovieDetails> call(MovieDetailsParameters params) {
    return moviesRepository.getMovieDetails(params.movieId);
  }
}
