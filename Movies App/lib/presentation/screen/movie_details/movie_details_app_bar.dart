import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_log.dart';
import '../../../data/local/movie_table.dart';
import '../../../domain/entities/movie_details.dart';
import '../../bloc/movies_favorite/movies_favorite_bloc.dart';

class MovieDetailsAppBar extends StatelessWidget {
  final MovieDetails movieDetails;

  const MovieDetailsAppBar({
    Key? key,
    required this.movieDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
        BlocBuilder<MoviesFavoriteBloc, MoviesFavoriteState>(
          builder: (context, state) {
            if (state is MoviesFavoriteIsFavoriteOrNotState) {
              AppLog.info("MoviesFavoriteIsFavoriteOrNotState Here",
                  tag: "movie_details_app_bar()");

              final bool isFavorite = state.isFavorite;
              return GestureDetector(
                onTap: () {
                  context
                      .read<MoviesFavoriteBloc>()
                      .add(MoviesFavoriteToggleFavoriteEvent(
                        movieTable: MovieTable.fromMovieDetails(movieDetails),
                        isFavorite: state.isFavorite,
                      ));
                },
                child: isFavorite
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 30,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 30,
                      ),
              );
            }
            return GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            );
          },
        ),
      ],
    );
  }
}
