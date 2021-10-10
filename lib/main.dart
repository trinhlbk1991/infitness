import 'dart:async';

import 'package:fimber_io/fimber_io.dart';
import 'package:flutter/material.dart';
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

  await runZonedGuarded<Future<void>>(() async {
    final themeMode = SettingsHive().getThemeMode();
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (context) => ThemeNotifier(themeMode),
        child: InfitnessApp(),
      ),
    );
  }, (error, stackTrace) async {
    Fimber.e('Uncaught error', ex: error, stacktrace: stackTrace);
  });
}
