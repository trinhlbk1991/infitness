import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';

Widget card({required Widget child, EdgeInsets? margin}) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: margin,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.CARD)),
    elevation: Spacing.ELEVATION,
    child: child,
  );
}
