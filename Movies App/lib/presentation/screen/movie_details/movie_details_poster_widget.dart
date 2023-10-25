import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/common/extensions/double_extensions.dart';
import 'package:movies_app/presentation/themes/theme_text.dart';

import '../../../core/remote/provider/api_constant.dart';
import '../../../domain/entities/movie_details.dart';
import 'movie_details_app_bar.dart';

class MovieDetailsPosterWidget extends StatelessWidget {
  final MovieDetails movie;

  const MovieDetailsPosterWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                Theme.of(context).primaryColor
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: ApiConstant.getPosterPath(movie.posterPath!),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: ListTile(
            title: Text(
              movie.title!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: Text(
              movie.releaseDate!,
              style: Theme.of(context).textTheme.greyTitleMedium,
            ),
            trailing: Text(
              (movie.voteAverage ?? 0.0).convertVoteAverageToPercentageString,
              style: Theme.of(context).textTheme.royalBlueTitleMedium,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 16,
          left: 16,
          child: MovieDetailsAppBar(movieDetails: movie),
        ),
      ],
    );
  }
}
