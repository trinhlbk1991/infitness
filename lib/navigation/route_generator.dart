import 'package:flutter/material.dart';
import 'package:infitness/features/home/home_screen.dart';
import 'package:infitness/navigation/home_navigator.dart';

class RouteGenerator {
  RouteGenerator._();

  static RouteFactory routeFactory(BuildContext appContext) {
    return (settings) {
      return MaterialPageRoute(builder: (context) {
        return _createScreen(appContext, settings);
      });
    };
  }

  static Widget _createScreen(BuildContext context, RouteSettings settings) {
    late Widget screen;
    switch (settings.name) {
      /* Home */
      case HomeNavigator.HOME:
        screen = HomeScreen();
        break;
      default:
        throw Exception('Unsupported route: ${settings.name}');
    }
    return screen;
  }
}
