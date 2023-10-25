import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/extensions/string_extensions.dart';
import 'package:movies_app/presentation/themes/theme_text.dart';

import '../../../common/constants/language_constants.dart';
import '../../../domain/entities/search_movies_parameters.dart';
import '../../bloc/movies_search/movies_search_bloc.dart';
import '../../themes/theme_color.dart';
import '../../widgets/app_error.wiget.dart';
import 'movie_search_card.dart';

class MoviesSearchDelegate extends SearchDelegate {
  final MoviesSearchBloc moviesSearchBloc;

  MoviesSearchDelegate({required this.moviesSearchBloc});
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.greyTitleMedium,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: query.isEmpty
              ? null
              : () {
                  query = '';
                  moviesSearchBloc.add(
                    LoadMoviesSearchEvent(
                      searchMoviesParameters:
                          SearchMoviesParameters(queryText: query),
                    ),
                  );
                },
          icon: Icon(
            Icons.clear,
            color: query.isEmpty ? Colors.grey : AppColors.royalBlue,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //pass back null
        close(context, null);
      },
      child: const Icon(
        Icons.arrow_back_ios,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length > 2) {
      moviesSearchBloc.add(LoadMoviesSearchEvent(
          searchMoviesParameters: SearchMoviesParameters(queryText: query)));
    }
    return BlocBuilder<MoviesSearchBloc, MoviesSearchState>(
        bloc: moviesSearchBloc,
        builder: (context, state) {
          if (state is MoviesSearchErrorState) {
            return Center(
              child: AppErrorWidget(
                errorType: state.errorType,
                handleRetryPress: () {
                  moviesSearchBloc.add(
                    LoadMoviesSearchEvent(
                      searchMoviesParameters:
                          SearchMoviesParameters(queryText: query),
                    ),
                  );
                },
              ),
            );
          } else if (state is MoviesSearchLoadedState) {
            final movies = state.movies;
            if (movies.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    LanguageConstants.searchResultsNotFound.translate(context),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (ctx, i) => MovieSearchCard(movie: movies[i]),
              itemCount: movies.length,
            );
          }
          return const SizedBox.shrink();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
