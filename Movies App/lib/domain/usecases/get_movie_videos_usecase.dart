import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../entities/movie_details_parameters.dart';
import '../entities/video.dart';
import '../repositories/movies_repository.dart';

class GetMovieVideoUseCase
    extends UseCaseWithParams<List<Video>, MovieDetailsParameters> {
  final MoviesRepository moviesRepository;

  const GetMovieVideoUseCase({required this.moviesRepository});

  @override
  ResultFuture<List<Video>> call(MovieDetailsParameters params) async {
    return await moviesRepository.getMovieVideos(params.movieId);
  }
}
