import 'dart:convert';

import '../../../common/app_log.dart';
import '../../../core/remote/models/base_response.dart';
import '../../../core/remote/provider/api_client.dart';
import '../../../core/remote/provider/api_constant.dart';
import '../../../domain/entities/movie_details.dart';
import '../../../domain/entities/search_movies_parameters.dart';
import '../../models/cast_member_model.dart';
import '../../models/cast_result_model.dart';
import '../../models/movie_details_model.dart';
import '../../models/movie_model.dart';
import '../../models/movies_result_model.dart';
import '../../models/video_model.dart';
import '../../models/videos_result_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getUpcomingMovies();
  Future<MovieDetails> getMovieDetails(int movieId);
  Future<List<CastMemberModel>> getMovieCastMembers(int movieId);
  Future<List<VideoModel>> getMovieVideos(int movieId);
  Future<List<MovieModel>> getSearchMovies(SearchMoviesParameters parameters);
}

class MoviesRemoteDataSourceImpl extends MoviesRemoteDataSource {
  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.trendingMoviesUrl,
      method: ApiClient.get,
    );

    if (response.code == 200) {
      final decodedResponse = jsonDecode(response.data);
      final movies = MoviesResultModel.fromJson(decodedResponse).movies;
      return movies;
    } else {
      throw Exception(response.message);
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.popularMoviesUrl,
      method: ApiClient.get,
    );

    if (response.code == 200) {
      final decodedResponse = jsonDecode(response.data);
      return MoviesResultModel.fromJson(decodedResponse).movies;
    } else {
      throw (Exception(response.message));
    }
  }
//////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.nowPlayingMoviesUrl,
      method: ApiClient.get,
    );

    if (response.code == 200) {
      final decodedResponse = jsonDecode(response.data);
      return MoviesResultModel.fromJson(decodedResponse).movies;
    } else {
      throw (Exception(response.message));
    }
  }
//////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.upcomingMoviesUrl,
      method: ApiClient.get,
    );

    if (response.code == 200) {
      final decodedResponse = jsonDecode(response.data);
      return MoviesResultModel.fromJson(decodedResponse).movies;
    } else {
      throw Exception(response.message);
    }
  }
//////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.getMovieDetailsUrl(movieId),
      method: ApiClient.get,
    );

    if (response.code == 200) {
      final decodedResponse = jsonDecode(response.data);
      return MovieDetailsModel.fromJson(decodedResponse);
    } else {
      throw Exception(response.message);
    }
  }
//////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<List<CastMemberModel>> getMovieCastMembers(int movieId) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.getMovieCastUrl(movieId),
      method: ApiClient.get,
    );

    if (response.code == 200) {
      final decodedResponse = jsonDecode(response.data);
      final List<CastMemberModel> castMembers =
          CastResultModel.fromJson(decodedResponse).castMembers;
      return castMembers;
    } else {
      throw Exception(response.message);
    }
  }
//////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<List<VideoModel>> getMovieVideos(int movieId) async {
    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.getMovieVideosUrl(movieId),
      method: ApiClient.get,
    );

    if (response.code == 200) {
      final decodedResponse = jsonDecode(response.data);
      final List<VideoModel> videos =
          VideosResultModel.fromJson(decodedResponse).videos;
      return videos;
    } else {
      throw Exception(response.message);
    }
  }

  @override
  Future<List<MovieModel>> getSearchMovies(
      SearchMoviesParameters parameters) async {
    final queries = parameters.toMap();

    AppLog.debug(ApiConstant.getMoviesSearchUrl(queries), tag: "getSearchMovies()");

    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.getMoviesSearchUrl(queries),
      method: ApiClient.get,
    );

    final Map<String, dynamic> decodedResponse = jsonDecode(response.data);

    if (response.code == 200) {
      final movies = MoviesResultModel.fromJson(decodedResponse).movies;
      return movies;
    } else {
      throw Exception(decodedResponse['errors'][0] ?? response.message);
    }
  }
}
