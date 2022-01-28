// ignore_for_file: unnecessary_import

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/space.dart';

import '../app_text.dart';

class DottedButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final IconData? icon;
  final Color color;

  const DottedButton({
    Key? key,
    required this.text,
    this.color = AppColors.TEXT_SECONDARY,
    required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(AppRadius.DEFAULT),
          child: DottedBorder(
            strokeWidth: 1,
            dashPattern: [5, 3],
            color: color,
            radius: Radius.circular(AppRadius.DEFAULT),
            padding: EdgeInsets.all(Spacing.NORMAL),
            borderType: BorderType.RRect,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null ? Icon(icon, color: color) : Container(),
                icon != null ? Space(size: Spacing.TINY) : Container(),
                AppText(text.toUpperCase(), color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
