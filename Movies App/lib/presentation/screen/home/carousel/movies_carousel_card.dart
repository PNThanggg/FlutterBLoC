import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/remote/provider/api_constant.dart';
import '../../movie_details/movie_details_screen.dart';

class MoviesCarouselCard extends StatelessWidget {
  final int movieId;
  final String posterPath;

  const MoviesCarouselCard({
    super.key,
    required this.movieId,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MovieDetailsScreen(movieId: movieId),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: ApiConstant.getPosterPath(posterPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
