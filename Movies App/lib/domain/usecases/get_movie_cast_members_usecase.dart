import '../../core/use_cases/use_case.dart';
import '../../core/utils/typedef.dart';
import '../entities/cast_member.dart';
import '../entities/movie_details_parameters.dart';
import '../repositories/movies_repository.dart';

class GetMovieCastMembersUseCase
    extends UseCaseWithParams<List<CastMember>, MovieDetailsParameters> {
  final MoviesRepository moviesRepository;

  const GetMovieCastMembersUseCase({required this.moviesRepository});

  @override
  ResultFuture<List<CastMember>> call(MovieDetailsParameters params) async {
    return await moviesRepository.getMovieCastMembers(params.movieId);
  }
}
