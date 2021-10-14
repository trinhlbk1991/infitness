import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';

Widget card({
  required Widget child,
  EdgeInsets? margin,
  Color? color,
  EdgeInsets? padding,
}) {
  return Card(
    semanticContainer: true,
    color: color,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: margin,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.CARD),
    ),
    elevation: Spacing.ELEVATION,
    child: Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: child,
    ),
  );
}
