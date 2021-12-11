import 'package:flutter/material.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/theme/app_theme.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/buttons/app_buttons.dart';
import 'package:infitness/widgets/edit_text.dart';
import 'package:infitness/widgets/number_picker.dart';
import 'package:infitness/widgets/space.dart';
import 'package:infitness/widgets/top_rounded_corner_card.dart';

void showAddRestDialog(
  BuildContext context, {
  int time = 0,
  required ValueChanged<Rest> onSave,
}) {
  final minuteTextController = TextEditingController();
  final secondTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final minutes = time ~/ 60;
  final seconds = time % 60;
  minuteTextController.text = time != 0 ? '$minutes' : '';
  secondTextController.text = time != 0 ? '$seconds' : '';

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Wrap(
            children: [
              Container(
                width: double.infinity,
                child: TopRoundedCornerCard(
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.only(
                      top: AppRadius.BOTTOM_SHEET,
                      left: AppRadius.BOTTOM_SHEET,
                      right: AppRadius.BOTTOM_SHEET,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          headline5Text(context, 'Add Rest'),
                          Space(),
                          _timerPicker(context,
                              minuteTextController: minuteTextController,
                              secondTextController: secondTextController),
                          Space(),
                          Row(
                            children: [
                              _btnCancel(context),
                              Space(),
                              _btnSave(context, () {
                                if (formKey.currentState!.validate()) {
                                  final min =
                                      int.tryParse(minuteTextController.text) ??
                                          0;
                                  final sec =
                                      int.tryParse(secondTextController.text) ??
                                          0;

                                  final rest = Rest(min * 60 + sec);
                                  onSave(rest);
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).pop();
                                }
                              }),
                            ],
                          ),
                          Space(size: Spacing.LARGE),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget _timerPicker(
  BuildContext context, {
  required TextEditingController minuteTextController,
  required TextEditingController secondTextController,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              width: 80,
              child: EditText(
                hint: '0',
                controller: minuteTextController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
            Space(size: Spacing.SMALL),
            AppText('Minutes'),
          ],
        ),
        Space(),
        Column(
          children: [AppText(':'), AppText('')],
        ),
        Space(),
        Column(
          children: [
            SizedBox(
              width: 80,
              child: EditText(
                hint: '0',
                controller: secondTextController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
            Space(size: Spacing.SMALL),
            AppText('Seconds'),
          ],
        )
      ],
    );

Expanded _btnSave(
  BuildContext context,
  Function? positiveClicked,
) =>
    Expanded(
      child: PositiveButton(
        text: 'Save',
        onPressed: () {
          positiveClicked?.call();
        },
      ),
    );

_btnCancel(BuildContext context) => Expanded(
      child: PrimaryOutlineButton(
        text: 'Cancel',
        onPressed: () {
          FocusScope.of(context).unfocus();
          Navigator.of(context).pop();
        },
      ),
    );
