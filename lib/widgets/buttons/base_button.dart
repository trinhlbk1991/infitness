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

  BaseButton(
    this.text,
    this.onPressed,
    this.background,
    this.borderColor,
    this.textColor,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      // ignore: deprecated_member_use
      child: RaisedButton(
        padding: EdgeInsets.only(
          left: Spacing.NORMAL,
          right: Spacing.NORMAL,
          top: Spacing.NORMAL,
          bottom: Spacing.NORMAL,
        ),
        color: background ?? Theme.of(context).canvasColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: BorderSide(color: borderColor!),
        ),
        onPressed: onPressed,
        child: AppText(
          text!.toUpperCase(),
          fontSize: TextSize.BODY,
          fontWeight: FontWeight.w500,
          color: textColor ?? textColorPrimary(context),
        ),
      ),
    );
  }
}
