// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';

import 'app_text.dart';

Widget appBar(
  BuildContext context,
  String title, {
  double elevation = 4.0,
  double radius = AppRadius.APP_BAR,
  Function? onBackPress,
  bool showBackIcon = true,
}) {
  return AppBar(
    elevation: elevation,
    title: Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: showBackIcon ? 0 : Spacing.NORMAL),
      child: AppText(
        title,
        style: Theme.of(context).textTheme.headline6?.copyWith(
              color: secondaryColor(context),
            ),
      ),
    ),
    titleSpacing: Spacing.SUPER_TINY,
    leading: showBackIcon
        ? IconButton(
            iconSize: 20,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: secondaryColor(context),
            ),
            onPressed: () => onBackPress != null
                ? onBackPress()
                : Navigator.of(context).pop(),
          )
        : null,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(radius),
      ),
    ),
  );
}
