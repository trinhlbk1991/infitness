import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextStyle? style;

  AppText(
    this.text, {
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    var textStyle = style ?? Theme.of(context).textTheme.bodyText1!;

    if (color != null) {
      textStyle = textStyle.copyWith(color: color);
    }

    if (fontWeight != null) {
      textStyle = textStyle.copyWith(fontWeight: fontWeight);
    }

    if (fontSize != null) {
      textStyle = textStyle.copyWith(fontSize: fontSize);
    }

    return Text(
      text!,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

Widget headline5Text(BuildContext context, String text) => AppText(
      text,
      style: Theme.of(context).textTheme.headline5,
    );

Widget headline6Text(BuildContext context, String text) => AppText(
      text,
      style: Theme.of(context).textTheme.headline6,
    );

Widget subtitle1Text(BuildContext context, String text) => AppText(
      text,
      style: Theme.of(context).textTheme.subtitle1,
    );

Widget subtitle2Text(BuildContext context, String text) => AppText(
      text,
      style: Theme.of(context).textTheme.subtitle2,
    );

Widget body1Text(BuildContext context, String text) => AppText(
      text,
      style: Theme.of(context).textTheme.bodyText1,
    );

Widget body2Text(BuildContext context, String text) => AppText(
      text,
      style: Theme.of(context).textTheme.bodyText2,
    );

Widget captionText(BuildContext context, String text) => AppText(
      text,
      style: Theme.of(context).textTheme.caption,
    );
