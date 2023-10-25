import 'package:flutter/cupertino.dart';

import '../../common/constants/routes_list.dart';
import '../../domain/entities/video.dart';
import '../../domain/entities/watch_videos_arguments.dart';
import '../screen/favorites/favorite_movies_screen.dart';
import '../screen/home/home_screen.dart';
import '../screen/movie_details/movie_details_screen.dart';
import '../screen/watch_videos/watch_videos_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) {
    return {
      RoutesList.initial: (context) => const HomeScreen(),
      RoutesList.favoriteMovies: (context) => const FavoriteMoviesScreen(),
      RoutesList.movieDetails: (context) => MovieDetailsScreen(
            movieId: settings.arguments as int,
          ),
      RoutesList.watchTrailler: (context) => WatchVideosScreen(
            watchVideosArguments: WatchVideosArguments(
              videos: settings.arguments as List<Video>,
            ),
          ),
    };
  }
}
