import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/navigation/home_navigator.dart';
import 'package:provider/provider.dart';

import 'navigation/route_generator.dart';
import 'theme/app_theme.dart';
import 'theme/theme_notifier.dart';

class InfitnessApp extends StatefulWidget {
  const InfitnessApp({Key? key}) : super(key: key);

  @override
  _InfitnessAppState createState() => _InfitnessAppState();
}

class _InfitnessAppState extends State<InfitnessApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [],
      child: _pageContent(context),
    );
  }

  Widget _pageContent(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      initialRoute: HomeNavigator.HOME,
      onGenerateRoute: RouteGenerator.routeFactory(context),
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: themeNotifier.getThemeMode(),
    );
  }
}
