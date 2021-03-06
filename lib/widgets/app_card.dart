import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';

Widget card({
  required Widget child,
  EdgeInsets? margin,
  Color? color,
  Color? borderColor,
  double? borderWidth,
  EdgeInsets? padding,
  double? elevation,
}) {
  return Card(
    semanticContainer: true,
    color: color,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: margin,
    shape: RoundedRectangleBorder(
      side: borderColor != null
          ? BorderSide(color: borderColor, width: borderWidth ?? 0)
          : BorderSide.none,
      borderRadius: BorderRadius.circular(AppRadius.CARD),
    ),
    elevation: elevation ?? Spacing.ELEVATION,
    child: Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: child,
    ),
  );
}
