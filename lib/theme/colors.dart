import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppColors {
  AppColors._();

  static const Color PRIMARY = Color(0xFFFFFFFF);
  static const Color PRIMARY_VARIANT = Color(0xFFFFFFFF);
  static const Color PRIMARY_LIGHT = Color(0xFFFFFFFF);

  static const Color DARK_PRIMARY = Color(0xFF424242);
  static const Color DARK_PRIMARY_VARIANT = Color(0xFF424242);
  static const Color DARK_PRIMARY_LIGHT = Color(0xFF424242);

  static const Color SECONDARY = Color(0xFF588BA5);
  static const Color SECONDARY_VARIANT = Color(0xFF33515F);
  static const Color SECONDARY_LIGHT = Color(0xFF78BFE3);

  static const TEXT_PRIMARY = Colors.black87;
  static const TEXT_SECONDARY = Colors.grey;

  static const TEXT_PRIMARY_DARK = Colors.white;
  static const TEXT_SECONDARY_DARK = Colors.white70;
}

Color textColorPrimary(BuildContext context) {
  if (isDarkMode(context)) {
    return AppColors.TEXT_PRIMARY_DARK;
  } else {
    return AppColors.TEXT_PRIMARY;
  }
}

Color textColorSecondary(BuildContext context) {
  if (isDarkMode(context)) {
    return AppColors.TEXT_SECONDARY_DARK;
  } else {
    return AppColors.TEXT_SECONDARY;
  }
}

Color secondaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.secondary;

Color secondaryColorVariant(BuildContext context) =>
    Theme.of(context).colorScheme.secondaryVariant;

Color secondaryColorLight(BuildContext context) => AppColors.SECONDARY_LIGHT;
