import 'package:flutter/material.dart';
import 'package:infitness/theme/text_styles.dart';

import 'colors.dart';

class AppTheme {
  get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.dark(
          primary: AppColors.DARK_PRIMARY,
          primaryVariant: AppColors.DARK_PRIMARY_VARIANT,
          secondary: AppColors.SECONDARY,
          secondaryVariant: AppColors.SECONDARY_VARIANT,
          brightness: Brightness.dark,
        ),
        toggleableActiveColor: AppColors.SECONDARY,
        indicatorColor: AppColors.SECONDARY,
        hintColor: AppColors.TEXT_SECONDARY_DARK,
        textTheme: _createTextTheme(AppColors.TEXT_PRIMARY_DARK),
        iconTheme: IconThemeData(color: AppColors.TEXT_PRIMARY_DARK),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.SECONDARY,
          selectionColor: AppColors.SECONDARY_LIGHT,
          selectionHandleColor: AppColors.SECONDARY,
        ),
      );

  get lightTheme => ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.dark(
          primary: AppColors.PRIMARY,
          primaryVariant: AppColors.PRIMARY_VARIANT,
          secondary: AppColors.SECONDARY,
          secondaryVariant: AppColors.SECONDARY_VARIANT,
          brightness: Brightness.light,
        ),
        indicatorColor: AppColors.SECONDARY,
        toggleableActiveColor: AppColors.SECONDARY,
        hintColor: AppColors.TEXT_SECONDARY,
        textTheme: _createTextTheme(AppColors.TEXT_PRIMARY),
        iconTheme: IconThemeData(color: AppColors.TEXT_PRIMARY),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.SECONDARY,
          selectionColor: AppColors.SECONDARY_LIGHT,
          selectionHandleColor: AppColors.SECONDARY,
        ),
      );

  TextTheme _createTextTheme(Color color) => TextTheme(
        headline1: TextStyles.h1.copyWith(color: color),
        headline2: TextStyles.h2.copyWith(color: color),
        headline3: TextStyles.h3.copyWith(color: color),
        headline4: TextStyles.h4.copyWith(color: color),
        headline5: TextStyles.h5.copyWith(color: color),
        headline6: TextStyles.h6.copyWith(color: color),
        subtitle1: TextStyles.subtitle.copyWith(color: color),
        subtitle2: TextStyles.subtitle2.copyWith(color: color),
        bodyText1: TextStyles.body.copyWith(color: color),
        bodyText2: TextStyles.body2.copyWith(color: color),
        button: TextStyles.button.copyWith(color: color),
        caption: TextStyles.caption.copyWith(color: color),
      );
}

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;
