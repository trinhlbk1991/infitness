import 'package:flutter/material.dart';

class ScreenSizeUtils {
  ScreenSizeUtils._();

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double safeHeight(BuildContext context) =>
      height(context) - paddingTop(context) - paddingBottom(context);

  static double paddingTop(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double paddingBottom(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;
}
