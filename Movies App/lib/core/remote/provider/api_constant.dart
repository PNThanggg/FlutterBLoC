class ApiConstant {
  ApiConstant._();

  static const Duration connectTimeout = Duration(milliseconds: 10000);
  static const Duration receiveTimeout = Duration(milliseconds: 5000);

  static const String apiKey = "f03b091ad9c78bbc2450cc4e84caa068";
  static const String baseUrl = "https://api.themoviedb.org/3/";

  static String getPosterPath(String posterPath) =>
      "https://image.tmdb.org/t/p/w500$posterPath";

//////////////////////////////////// Movies /////////////////////////////////////////

  static const trendingMoviesUrl =
      "${baseUrl}trending/movie/day?apiKey=$apiKey";

  static const String upcomingMoviesUrl = "${baseUrl}movie/upcoming?apiKey=$apiKey";
  static const String popularMoviesUrl = "${baseUrl}movie/popular?apiKey=$apiKey";
  static const String nowPlayingMoviesUrl =
      "${baseUrl}movie/now_playing?apiKey=$apiKey";

  static String getMoviesSearchUrl(Map<String, dynamic> queries) {
    String query = '';
    queries.forEach((key, value) {
      //if (value != null)
      query += '&$key=$value';
    });

    return '${baseUrl}search/movie?apiKey=$apiKey$query';
  }

////////////////////////////////// Movie///////////////////////////////////////////
  static String getMovieDetailsUrl(int movieId) =>
      "${baseUrl}movie/$movieId?apiKey=$apiKey";

  static String getMovieCastUrl(int movieId) =>
      "${baseUrl}movie/$movieId/credits?apiKey=$apiKey";

  static String getMovieVideosUrl(int movieId) =>
      "${baseUrl}movie/$movieId/videos?apiKey=$apiKey";
}
