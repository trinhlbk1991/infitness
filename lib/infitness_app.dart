import 'package:fimber_io/fimber_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/di/hive_module.dart';

import 'navigation/infitness_navigator.dart';
import 'navigation/route_generator.dart';
import 'theme/app_theme.dart';
import 'theme/theme_notifier.dart';

class InfitnessApp extends StatefulWidget {
  const InfitnessApp({Key? key}) : super(key: key);

  @override
  _InfitnessAppState createState() {
    _setupLog();
    return _InfitnessAppState();
  }

  void _setupLog() async {
    Fimber.plantTree(DebugTree());
    // final path = await LogUtils.getLogFilePath();
    // Fimber.plantTree(FimberFileTree(
    //   path,
    //   logFormat: '${CustomFormatTree.timeStampToken}'
    //       '\t${CustomFormatTree.tagToken}'
    //       '\t${CustomFormatTree.messageToken}',
    // ));
  }
}

class _InfitnessAppState extends State<InfitnessApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: HiveModule.hives,
      child: _pageContent(context),
    );
  }

  Widget _pageContent(BuildContext context) {
    final themeNotifier = RepositoryProvider.of<ThemeNotifier>(context);

    return MaterialApp(
      initialRoute: InfitnessNavigator.HOME,
      onGenerateRoute: RouteGenerator.routeFactory(context),
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: themeNotifier.getThemeMode(),
    );
  }
}
