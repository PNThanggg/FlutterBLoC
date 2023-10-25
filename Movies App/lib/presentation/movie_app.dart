import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../app_localizations.dart';
import '../common/constants/languages.dart';
import '../di/get_it.dart';
import 'bloc/language/language_bloc.dart';
import 'bloc/loading/loading_bloc.dart';
import 'bloc/theme_mode/theme_mode_bloc.dart';
import 'screen/home/home_screen.dart';
import 'screen/loading/loading_screen.dart';
import 'themes/theme_color.dart';
import 'themes/theme_text.dart';
import 'widgets/loading_circle_widget.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageBloc _languageBloc;
  late LoadingBloc _loadingBloc;
  late ThemeModeBloc _themeModeBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance();
    _languageBloc.add(GetPreferredLanguageEvent());
    _loadingBloc = getItInstance();
    _themeModeBloc = getItInstance();
    _themeModeBloc.add(GetThemeModeEvent());
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loadingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: _languageBloc),
        BlocProvider<LoadingBloc>.value(value: _loadingBloc),
        BlocProvider<ThemeModeBloc>.value(value: _themeModeBloc),
      ],
      child: BlocBuilder<ThemeModeBloc, ThemeModeState>(
        builder: (context, themeModeState) {
          if (themeModeState is ThemeModeLoadedState) {
            return BlocBuilder<LanguageBloc, LanguageState>(
                bloc: _languageBloc,
                builder: (context, langStates) {
                  if (langStates is LanguageLoadingState) {
                    return const Center(
                      child: LoadingCircleWidget(
                        size: 200,
                      ),
                    );
                  } else if (langStates is LanguageLoadedState) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      themeMode: themeModeState.themeMode,
                      theme: ThemeData(
                        primaryColor: Colors.white,
                        colorScheme: const ColorScheme.light().copyWith(
                          primary: Colors.white,
                          secondary: AppColors.vulcan,
                          brightness: Brightness.light,
                        ),
                        scaffoldBackgroundColor: Colors.white,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        textTheme: ThemeText.getLightTextTheme(),
                        appBarTheme: const AppBarTheme(
                          elevation: 0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      darkTheme: ThemeData(
                        primaryColor: AppColors.vulcan,
                        colorScheme: const ColorScheme.light().copyWith(
                          primary: AppColors.vulcan,
                          secondary: Colors.white,
                          brightness: Brightness.dark,
                        ),
                        scaffoldBackgroundColor: AppColors.vulcan,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        textTheme: ThemeText.getDarkTextTheme(),
                        appBarTheme: const AppBarTheme(
                          elevation: 0,
                          backgroundColor: AppColors.vulcan,
                        ),
                      ),

                      locale: langStates.locale,
                      supportedLocales: Languages.languages
                          .map<Locale>(
                            (language) => Locale(language.code),
                          )
                          .toList(),
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      builder: (context, child) {
                        return LoadingScreen(child: child!);
                      },
                      home: const HomeScreen(),
                      // initialRoute: RoutesList.initial,
                      // onGenerateRoute: (RouteSettings settings) {
                      //   final routes = Routes.getRoutes(settings);
                      //   final WidgetBuilder widgetBuilder = routes[settings.name]!;
                      //   return FadePageRouteBuilder(
                      //       widgetBuilder: widgetBuilder, setting: settings);
                      //   //final WidgetBuilder builder = routes[settings.name]?? ;
                      // },
                    );
                  }
                  return const SizedBox.shrink();
                });
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
