import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/common/extensions/string_extensions.dart';

import '../../common/constants/language_constants.dart';
import '../../common/constants/languages.dart';
import '../bloc/theme_mode/theme_mode_bloc.dart';
import '../screen/favorites/favorite_movies_screen.dart';
import '../widgets/logo_widget.dart';
import 'navigation_expansion_list_item.dart';
import 'navigation_list_item.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          )
        ],
      ),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                  top: 8.0,
                  right: 8.0,
                  bottom: 18.0,
                ),
                child: LogoWidget(
                  height: 200,
                ),
              ),
              NavigationListItem(
                title: LanguageConstants.favoriteMovies,
                handlePress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const FavoriteMoviesScreen(),
                    ),
                  );
                },
              ),
              NavigationExpansionListItem(
                title: LanguageConstants.language.translate(context),
                childList:
                    Languages.languages.map<String>((e) => e.value).toList(),
              ),
              NavigationListItem(
                title: LanguageConstants.feedback,
                handlePress: () {},
              ),
              NavigationListItem(
                title: LanguageConstants.about,
                handlePress: () {},
              ),
              const SizedBox(height: 30),
              IconButton(
                onPressed: () {
                  final currentBrightness =
                      Theme.of(context).colorScheme.brightness;
                  final desiredThemeMode = currentBrightness == Brightness.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                  context
                      .read<ThemeModeBloc>()
                      .add(ChangeThemeModeEvent(themeMode: desiredThemeMode));
                },
                icon: Icon(
                  Icons.brightness_2,
                  size: 40,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
