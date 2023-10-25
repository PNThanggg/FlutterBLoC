import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../../data/local/movie_table.dart';
import '../repositories/movies_repository.dart';

class GetAllFavoriteMoviesUseCase
    extends UseCaseWithoutParams<List<MovieTable>> {
  final MoviesRepository moviesRepository;

  const GetAllFavoriteMoviesUseCase(this.moviesRepository);

  @override
  ResultFuture<List<MovieTable>> call() async {
    return await moviesRepository.getAllFavoriteMovies();
  }
}
