import 'package:flutter/cupertino.dart';
import 'package:infitness/features/home/home_screen.dart';

class HomeNavigator {
  static const String HOME = '/';

  HomeNavigator._();

  static gotoHome(BuildContext context) {
    Navigator.popAndPushNamed(context, HOME);
  }

  static homeScreen(BuildContext context, RouteSettings settings) {
    return HomeScreen();
  }
}
