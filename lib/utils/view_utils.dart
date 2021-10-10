import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';

BorderRadius borderRadiusAll({double radius = AppRadius.DEFAULT}) =>
    BorderRadius.all(Radius.circular(radius));

Widget padding({double padding = Spacing.NORMAL, required Widget child}) =>
    Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );

Widget paddingOnly({
  double left = 0,
  double right = 0,
  double top = 0,
  double bottom = 0,
  required Widget child,
}) =>
    Padding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      child: child,
    );
