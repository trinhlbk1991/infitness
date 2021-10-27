import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';

Widget iconButton(
  BuildContext context, {
  required IconData icon,
  required Function onPressed,
  double buttonSize = 56,
  double iconSize = 32,
  Color? backgroundColor,
  Color? iconColor,
}) {
  return SizedBox(
    height: buttonSize,
    child: ElevatedButton(
      onPressed: () => onPressed(),
      child: Icon(
        icon,
        color: iconColor ?? Colors.white,
        size: iconSize,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: backgroundColor ?? Theme.of(context).colorScheme.secondary,
      ),
    ),
  );
}

Widget iconOutlineButton(
  BuildContext context, {
  required IconData icon,
  required Function onPressed,
  double buttonSize = 56,
  double iconSize = 32,
  Color? color,
}) {
  return SizedBox(
    height: buttonSize,
    child: ElevatedButton(
      onPressed: () => onPressed(),
      child: Icon(
        icon,
        color: color ?? secondaryColor(context),
        size: iconSize,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
            side: BorderSide(color: color ?? secondaryColor(context))),
      ),
    ),
  );
}
