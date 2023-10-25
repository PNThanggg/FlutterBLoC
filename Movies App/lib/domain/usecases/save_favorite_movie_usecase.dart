import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

class SaveFavoriteMovieUseCase extends UseCaseWithParams<void, Movie> {
  final MoviesRepository moviesRepository;

  const SaveFavoriteMovieUseCase(this.moviesRepository);

  @override
  ResultVoid call(Movie params) async {
    return await moviesRepository.saveFavoriteMovie(params);
  }
}
