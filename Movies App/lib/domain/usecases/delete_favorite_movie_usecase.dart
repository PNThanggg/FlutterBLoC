import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../repositories/movies_repository.dart';

class DeleteFavoriteMovieUseCase extends UseCaseWithParams<void, int> {
  final MoviesRepository moviesRepository;

  const DeleteFavoriteMovieUseCase(this.moviesRepository);

  @override
  ResultVoid call(int params) async {
    return await moviesRepository.deleteFavoriteMovie(params);
  }
}
