import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

class GetUpcomingMoviesUseCase extends UseCaseWithoutParams<List<Movie>> {
  final MoviesRepository moviesRepository;

  const GetUpcomingMoviesUseCase(this.moviesRepository);

  @override
  ResultFuture<List<Movie>> call() async {
    return await moviesRepository.getUpcomingMovies();
  }
}
