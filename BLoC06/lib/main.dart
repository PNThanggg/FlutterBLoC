import 'package:bloc_06/presentation/view/screen/home/home_sreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'presentation/base/app_bloc.dart';
import 'presentation/view/resources/app_theme.dart';
import 'presentation/view/screen/sign_in/bloc/sign_in_bloc.dart';
import 'presentation/view/screen/sign_in/sign_in_screen.dart';
import 'presentation/view/screen/welcome/bloc/welcome_bloc.dart';
import 'presentation/view/screen/welcome/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: true,
          create: (context) => WelcomeBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => AppBloc(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: AppThem.appTheme,
          debugShowCheckedModeBanner: false,
          home: const WelcomeScreen(),
          routes: {
            "/home_screen": (context) => const HomeScreen(),
            "/sign_in_screen": (context) => const SignInScreen(),
          },
        ),
      ),
    );
  }
}
