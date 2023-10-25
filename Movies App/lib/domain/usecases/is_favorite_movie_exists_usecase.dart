import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../repositories/movies_repository.dart';

class IsFavoriteMovieExistsUseCase extends UseCaseWithParams<bool, int> {
  final MoviesRepository moviesRepository;

  const IsFavoriteMovieExistsUseCase(this.moviesRepository);

  @override
  ResultFuture<bool> call(int params) async {
    return await moviesRepository.isFavoriteMovieExists(params);
  }
}
