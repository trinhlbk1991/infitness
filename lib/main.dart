import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infitness/database/settings_hive.dart';
import 'package:infitness/infitness_app.dart';
import 'package:provider/provider.dart';

import 'theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(
        details.exception, details.stack ?? StackTrace.fromString('Unknown'));
  };

  await Hive.initFlutter();
  final themeMode = await SettingsHive().getThemeMode();

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) {
        return ThemeNotifier(themeMode);
      },
      child: InfitnessApp(),
    ),
  );
}
