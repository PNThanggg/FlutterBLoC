import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/get_it.dart';
import '../../bloc/movies_backdrop/movies_backdrop_bloc.dart';
import '../../bloc/movies_carousel/movies_carousel_bloc.dart';
import '../../bloc/movies_search/movies_search_bloc.dart';
import '../../bloc/movies_tabs/movies_tabs_bloc.dart';
import '../../drawer/navigation_drawer.dart';
import '../../widgets/app_error.wiget.dart';
import 'carousel/movies_carousel_widget.dart';
import 'movies_tabs/movies_tabs_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MoviesCarouselBloc moviesCarouselBloc;
  late MoviesBackdropBloc moviesBackdropBloc;
  late MoviesTabsBloc moviesTabsBloc;
  late MoviesSearchBloc moviesSearchBloc;

  @override
  void initState() {
    super.initState();
    moviesCarouselBloc = getItInstance();
    moviesCarouselBloc.add(const MoviescarouselLoadEvent(defaultIndex: 0));
    moviesBackdropBloc = moviesCarouselBloc.moviesBackdropBloc;
    moviesTabsBloc = getItInstance();
    moviesSearchBloc = getItInstance();
  }

  @override
  void dispose() {
    moviesCarouselBloc.close();
    moviesBackdropBloc.close();
    moviesTabsBloc.close();
    moviesSearchBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MoviesCarouselBloc>.value(value: moviesCarouselBloc),
          BlocProvider<MoviesBackdropBloc>.value(value: moviesBackdropBloc),
          BlocProvider<MoviesTabsBloc>.value(value: moviesTabsBloc),
          BlocProvider<MoviesSearchBloc>.value(value: moviesSearchBloc),
        ],
        child: Scaffold(
          drawer: const CustomNavigationDrawer(),
          body: BlocBuilder<MoviesCarouselBloc, MoviesCarouselState>(
            bloc: moviesCarouselBloc,
            builder: (context, state) {
              if (state is MoviesCarouselLoadedState) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.6,
                      child: MoviesCarouselWidget(
                        movies: state.carouselMovies,
                        defaultIndex: state.defaultIndex,
                      ),
                    ),
                    const FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 0.4,
                      child: MoviesTabsWidget(),
                    ),
                  ],
                );
              } else if (state is MoviesCarouselErrorState) {
                return AppErrorWidget(
                  errorType: state.errorType,
                  handleRetryPress: () {
                    moviesCarouselBloc.add(
                      const MoviescarouselLoadEvent(defaultIndex: 0),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
