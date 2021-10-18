import 'package:flutter/material.dart';

Widget iconButton(
  BuildContext context, {
  required IconData icon,
  required Function onPressed,
  double buttonSize = 56,
  double iconSize = 32,
}) {
  return SizedBox(
    height: buttonSize,
    child: ElevatedButton(
      onPressed: () => onPressed(),
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: Theme.of(context).colorScheme.secondary,
      ),
    ),
  );
}
