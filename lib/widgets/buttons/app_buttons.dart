import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';

import 'base_button.dart';

class PositiveButton extends BaseButton {
  PositiveButton({String? text, VoidCallback? onPressed})
      : super(
          text,
          onPressed,
          AppColors.SECONDARY,
          AppColors.SECONDARY,
          Colors.white,
        );
}

class NegativeButton extends BaseButton {
  NegativeButton({String? text, VoidCallback? onPressed})
      : super(
          text,
          onPressed,
          Colors.red[700],
          Colors.red[700],
          Colors.white,
        );
}

class NeutralButton extends BaseButton {
  NeutralButton({String? text, VoidCallback? onPressed})
      : super(
          text,
          onPressed,
          null,
          Colors.grey[300],
          null,
        );
}

class PrimaryOutlineButton extends BaseButton {
  PrimaryOutlineButton({String? text, VoidCallback? onPressed})
      : super(
          text,
          onPressed,
          null,
          AppColors.SECONDARY,
          AppColors.SECONDARY,
        );
}

class NeutralOutlineButton extends BaseButton {
  NeutralOutlineButton({String? text, VoidCallback? onPressed})
      : super(
          text,
          onPressed,
          null,
          AppColors.TEXT_SECONDARY,
          AppColors.TEXT_SECONDARY,
        );
}
