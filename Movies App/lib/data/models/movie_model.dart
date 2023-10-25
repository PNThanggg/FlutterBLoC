import 'package:movies_app/domain/entities/movie.dart';

class MovieModel extends Movie {
  final bool? adult;
  final String? originalLanguage;
  final String? originalTitle;
  final String? mediaType;
  final List<int>? genreIds;
  final double? popularity;
  final bool? video;
  final int? voteCount;

  const MovieModel({
    this.adult,
    super.backdropPath,
    super.id,
    super.title,
    this.originalLanguage,
    this.originalTitle,
    super.overview,
    super.posterPath,
    this.mediaType,
    this.genreIds,
    this.popularity,
    super.releaseDate,
    this.video,
    super.voteAverage,
    this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      id: json['id'],
      title: json['title'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '/6e452Tr1GUTQdChgf0WKRP9qWKV.jpg',
      mediaType: json['media_type'],
      genreIds: List<int>.from(json['genre_ids'].map((id) => id)),
      popularity: json['popularity']?.toDouble() ?? 0.0,
      releaseDate: json['release_date'],
      video: json['video'],
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      voteCount: json['vote_count'],
    );
  }
}
