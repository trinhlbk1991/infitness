import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppColors {
  AppColors._();

  static const Color PRIMARY = Color(0xFF588BA5);
  static const Color PRIMARY_VARIANT = Color(0xFF33515F);
  static const Color PRIMARY_LIGHT = Color(0xFF588BA5);

  static const Color SECONDARY = Color(0xFF588BA5);
  static const Color SECONDARY_VARIANT = Color(0xFF33515F);
  static const Color SECONDARY_LIGHT = Color(0xFF588BA5);

  static const TEXT_PRIMARY = Colors.black87;
  static const TEXT_SECONDARY = Colors.grey;

  static const TEXT_PRIMARY_DARK = Colors.white;
  static const TEXT_SECONDARY_DARK = Colors.white70;
}


textColorPrimary(BuildContext context) {
  if (isDarkMode(context)) {
    return AppColors.TEXT_PRIMARY_DARK;
  } else {
    return AppColors.TEXT_PRIMARY;
  }
}

textColorSecondary(BuildContext context) {
  if (isDarkMode(context)) {
    return AppColors.TEXT_SECONDARY_DARK;
  } else {
    return AppColors.TEXT_SECONDARY;
  }
}
