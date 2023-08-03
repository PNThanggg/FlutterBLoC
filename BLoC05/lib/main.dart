import 'package:bloc_05/blocs/switch_bloc/switch_bloc.dart';
import 'package:bloc_05/screen/recycle_bin.dart';
import 'package:bloc_05/services/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/task_bloc/task_bloc.dart';
import 'screen/task_screen.dart';

Future<void> main() async {
  // BlocOverrides.runZoned(() => runApp(const MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Task App',
            debugShowCheckedModeBanner: false,
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            routes: {
              "/": (context) => const TaskScreen(),
              "/recycle_bin_screen": (context) => const RecycleBinScreen(),
            },
            initialRoute: "/",
            onGenerateRoute: (settings) {
              if (settings.name == '/recycle_bin_screen') {
                return MaterialPageRoute(
                  builder: (context) => const RecycleBinScreen(),
                );
              }

              return MaterialPageRoute(
                builder: (context) => const TaskScreen(),
              );
            },
            // home: const TaskScreen(),
          );
        },
      ),
    );
  }
}
