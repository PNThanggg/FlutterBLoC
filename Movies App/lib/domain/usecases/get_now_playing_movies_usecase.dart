import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

class GetNowPlayingMoviesUseCase extends UseCaseWithoutParams<List<Movie>> {
  final MoviesRepository moviesRepository;

  GetNowPlayingMoviesUseCase(this.moviesRepository);

  @override
  ResultFuture<List<Movie>> call() async {
    return await moviesRepository.getNowPlayingMovies();
  }
}
