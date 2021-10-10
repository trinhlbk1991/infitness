import 'package:flutter/cupertino.dart';

class HomeNavigator {
  static const String HOME = 'home';

  HomeNavigator._();

  static gotoHome(BuildContext context) {
    Navigator.popAndPushNamed(context, HOME);
  }

  static homeScreen(BuildContext context, RouteSettings settings) {
    return Container();
  }
}
