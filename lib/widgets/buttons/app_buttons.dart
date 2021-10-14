import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';

import 'base_button.dart';

class PositiveButton extends BaseButton {
  PositiveButton({
    String? text,
    VoidCallback? onPressed,
    EdgeInsets? padding,
  }) : super(
          text,
          onPressed,
          AppColors.SECONDARY,
          AppColors.SECONDARY,
          Colors.white,
          padding,
        );
}

class NegativeButton extends BaseButton {
  NegativeButton({
    String? text,
    VoidCallback? onPressed,
    EdgeInsets? padding,
  }) : super(
          text,
          onPressed,
          Colors.red[700],
          Colors.red[700],
          Colors.white,
          padding,
        );
}

class NeutralButton extends BaseButton {
  NeutralButton({
    String? text,
    VoidCallback? onPressed,
    EdgeInsets? padding,
  }) : super(
          text,
          onPressed,
          null,
          Colors.grey[300],
          null,
          padding,
        );
}

class PrimaryOutlineButton extends BaseButton {
  PrimaryOutlineButton({
    String? text,
    VoidCallback? onPressed,
    EdgeInsets? padding,
  }) : super(
          text,
          onPressed,
          null,
          AppColors.SECONDARY,
          AppColors.SECONDARY,
          padding,
        );
}

class NeutralOutlineButton extends BaseButton {
  NeutralOutlineButton({
    String? text,
    VoidCallback? onPressed,
    EdgeInsets? padding,
  }) : super(
          text,
          onPressed,
          null,
          AppColors.TEXT_SECONDARY,
          AppColors.TEXT_SECONDARY,
          padding,
        );
}
