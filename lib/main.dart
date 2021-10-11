import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infitness/database/hive_utils.dart';
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

  await HiveUtils.init();
  final themeMode = SettingsHive().getThemeMode();

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) => ThemeNotifier(themeMode),
      child: InfitnessApp(),
    ),
  );
}
