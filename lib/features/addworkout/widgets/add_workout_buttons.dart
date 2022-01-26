import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/widgets/buttons/dotted_button.dart';

Widget btnAddExercise(BuildContext context, {required Function onTap}) =>
    Expanded(
      child: DottedButton(
        icon: Icons.add_rounded,
        text: 'Exercise',
        onTap: onTap,
        color: secondaryColor(context),
      ),
    );

Widget btnAddRest(BuildContext context, {required Function onTap}) => Expanded(
      child: DottedButton(
        icon: Icons.add_rounded,
        text: 'Rest',
        onTap: onTap,
        color: textColorSecondary(context),
      ),
    );

Widget btnAddSet(BuildContext context, {required Function onTap}) => Expanded(
      child: DottedButton(
        icon: Icons.add_rounded,
        text: 'Set',
        color: secondaryColor(context),
        onTap: onTap,
      ),
    );
