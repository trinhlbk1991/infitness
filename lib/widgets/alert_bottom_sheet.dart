import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/view_utils.dart';

import 'app_text.dart';
import 'buttons/app_buttons.dart';
import 'space.dart';
import 'top_rounded_corner_card.dart';

void showAlertBottomSheet(
  BuildContext context, {
  required String title,
  required String message,
  String positiveText = 'OK',
  String negativeText = 'Cancel',
  Function? positiveClicked,
  Function? negativeClicked,
  PositiveStyle positiveStyle = PositiveStyle.outline,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Container(
            width: double.infinity,
            child: TopRoundedCornerCard(
              child: padding(
                padding: AppRadius.BOTTOM_SHEET,
                child: Column(
                  children: [
                    headline5Text(context, title),
                    Space(size: Spacing.LARGE),
                    AppText(message),
                    Space(size: Spacing.LARGE),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _negativeBtn(negativeText, context, negativeClicked),
                        Space(),
                        _positiveBtn(positiveText, context, positiveClicked,
                            positiveStyle)
                      ],
                    ),
                    Space(size: Spacing.LARGE),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Expanded _positiveBtn(
  String positiveText,
  BuildContext context,
  Function? positiveClicked,
  PositiveStyle positiveStyle,
) {
  switch (positiveStyle) {
    case PositiveStyle.outline:
      return Expanded(
        child: PrimaryOutlineButton(
          text: positiveText,
          onPressed: () {
            Navigator.of(context).pop();
            positiveClicked?.call();
          },
        ),
      );
    case PositiveStyle.primary:
      return Expanded(
        child: PositiveButton(
          text: positiveText,
          onPressed: () {
            Navigator.of(context).pop();
            positiveClicked?.call();
          },
        ),
      );
    case PositiveStyle.primaryRed:
      return Expanded(
        child: NegativeButton(
          text: positiveText,
          onPressed: () {
            Navigator.of(context).pop();
            positiveClicked?.call();
          },
        ),
      );
  }
}

_negativeBtn(
  String negativeText,
  BuildContext context,
  Function? negativeClicked,
) {
  return negativeText.isEmpty
      ? Container()
      : Expanded(
          child: PrimaryOutlineButton(
            text: negativeText,
            onPressed: () {
              Navigator.of(context).pop();
              negativeClicked?.call();
            },
          ),
        );
}

enum PositiveStyle { outline, primary, primaryRed }
