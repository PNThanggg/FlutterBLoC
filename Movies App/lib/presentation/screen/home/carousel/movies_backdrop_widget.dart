import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/remote/provider/api_constant.dart';
import '../../../bloc/movies_backdrop/movies_backdrop_bloc.dart';

class MoviesBackdropWidget extends StatelessWidget {
  const MoviesBackdropWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
      child: FractionallySizedBox(
        heightFactor: 0.7,
        alignment: Alignment.topCenter,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BlocBuilder<MoviesBackdropBloc, MoviesBackdropState>(
              builder: ((context, state) {
                if (state is MoviesBackdropLoadedState) {
                  return CachedNetworkImage(
                    imageUrl:
                        ApiConstant.getPosterPath(state.movie.backdropPath!),
                    fit: BoxFit.fitHeight,
                  );
                }
                return const SizedBox.shrink();
              }),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: SizedBox(width: MediaQuery.of(context).size.width),
            ),
          ],
        ),
      ),
    );
  }
}
