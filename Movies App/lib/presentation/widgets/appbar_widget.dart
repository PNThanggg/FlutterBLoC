import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/movies_search/movies_search_bloc.dart';
import '../screen/movies_search/movies_search_delegate.dart';
import 'logo_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        top: (10.0 + MediaQuery.of(context).padding.top),
        right: 15.0,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              'assets/svgs/menu.svg',
              theme: const SvgTheme(
                currentColor: Colors.white,
              ),
              height: 24,
            ),
          ),
          const Expanded(
            child: LogoWidget(height: 30),
          ),
          IconButton(
            onPressed: () {
              //returns a future(data passed through close() from delegate)
              showSearch(
                context: context,
                delegate: MoviesSearchDelegate(
                  moviesSearchBloc: BlocProvider.of<MoviesSearchBloc>(context),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
