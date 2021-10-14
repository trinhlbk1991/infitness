import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';

import '../app_text.dart';

class BaseButton extends StatelessWidget {
  final String? text;
  final Color? background;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  BaseButton(
    this.text,
    this.onPressed,
    this.background,
    this.borderColor,
    this.textColor,
    this.padding,
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: background ?? Theme.of(context).canvasColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.DEFAULT),
          side: BorderSide(color: borderColor!),
        ),
        padding: padding ??
            EdgeInsets.only(
              left: Spacing.NORMAL,
              right: Spacing.NORMAL,
              top: Spacing.SMALL_2,
              bottom: Spacing.SMALL_2,
            ),
      ),
      onPressed: onPressed,
      child: AppText(
        text!.toUpperCase(),
        fontSize: TextSize.BODY,
        fontWeight: FontWeight.w500,
        color: textColor ?? textColorPrimary(context),
      ),
    );
  }
}
