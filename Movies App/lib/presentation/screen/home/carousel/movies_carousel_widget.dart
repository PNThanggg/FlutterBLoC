import 'package:flutter/material.dart';

import '../../../../domain/entities/movie.dart';
import '../../../widgets/appbar_widget.dart';
import 'movie_carousel_separator.dart';
import 'movie_title_widget.dart';
import 'movies_backdrop_widget.dart';
import 'movies_carousel_page_view.dart';

class MoviesCarouselWidget extends StatelessWidget {
  final List<Movie> movies;
  final int defaultIndex;

  const MoviesCarouselWidget({
    super.key,
    required this.movies,
    required this.defaultIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const MoviesBackdropWidget(),
        Column(
          children: [
            const AppBarWidget(),
            MoviesCarouselPageView(movies: movies, defaultIndex: defaultIndex),
            const MovieTitleWidget(),
            const MovieCarouselSeparator(),
          ],
        ),
      ],
    );
  }
}
