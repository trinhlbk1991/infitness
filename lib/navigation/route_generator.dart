import 'package:flutter/material.dart';
import 'package:infitness/navigation/infitness_navigator.dart';

import 'screen_generator.dart';

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
      case InfitnessNavigator.HOME:
        screen = homeScreen(context, settings);
        break;
      case InfitnessNavigator.ADD_WORKOUT:
        screen = addWorkoutScreen(context, settings);
        break;
      default:
        throw Exception('Unsupported route: ${settings.name}');
    }
    return screen;
  }
}
