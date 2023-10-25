import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/presentation/movie_app.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/local/movie_table.dart';
import 'di/get_it.dart' as get_it;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    ),
  );

  await get_it.init();

  final appDocsDirectory = await getApplicationDocumentsDirectory();

  // Hive.init(appDocsDirectory.path);
  await Hive.initFlutter(appDocsDirectory.path);
  Hive.registerAdapter(MovieTableAdapter());

  runApp(const MovieApp());
}
