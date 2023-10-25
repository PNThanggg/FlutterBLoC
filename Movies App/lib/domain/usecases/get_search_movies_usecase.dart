import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../entities/movie.dart';
import '../entities/search_movies_parameters.dart';
import '../repositories/movies_repository.dart';

class GetSearchMoviesUseCase
    extends UseCaseWithParams<List<Movie>, SearchMoviesParameters> {
  final MoviesRepository moviesRepository;
  const GetSearchMoviesUseCase(this.moviesRepository);

  @override
  ResultFuture<List<Movie>> call(SearchMoviesParameters params) async {
    return await moviesRepository.getSearchMovies(params);
  }
}
