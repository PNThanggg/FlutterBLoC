import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

class GetPopularMoviesUseCase extends UseCaseWithoutParams<List<Movie>> {
  final MoviesRepository moviesRepository;

  GetPopularMoviesUseCase(this.moviesRepository);

  @override
  ResultFuture<List<Movie>> call() async {
    return await moviesRepository.getPopularMovies();
  }
}
