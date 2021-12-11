import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/theme/app_theme.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/theme/text_styles.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/buttons/app_buttons.dart';
import 'package:infitness/widgets/edit_text.dart';
import 'package:infitness/widgets/number_picker.dart';
import 'package:infitness/widgets/space.dart';
import 'package:infitness/widgets/top_rounded_corner_card.dart';

void showAddExerciseDialog(
  BuildContext context, {
  Exercise? exercise,
  required ValueChanged<Exercise> onSave,
}) {
  final nameTextController = TextEditingController();
  final repTextController = TextEditingController();
  final repTimeTextController = TextEditingController();
  final minuteTextController = TextEditingController();
  final secondTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var type = (exercise != null && exercise.rep > 0) ? REPS : TIMER;
  final minutes = exercise != null ? exercise.time ~/ 60 : 0;
  final seconds = exercise != null ? exercise.time % 60 : 30;
  final reps = exercise != null ? exercise.rep : 5;
  final repTime = exercise != null ? exercise.repTime : 5;

  if (exercise != null) {
    nameTextController.text = exercise.name;
  }

  repTextController.text = '$reps';
  repTimeTextController.text = '$repTime';
  minuteTextController.text = '$minutes';
  secondTextController.text = '$seconds';

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
                          headline5Text(context, 'Add Exercise'),
                          Space(),
                          _editTextName(nameTextController),
                          Space(),
                          _typeSwitch(
                            context,
                            value: type,
                            onTypeChanged: (value) =>
                                setState(() => type = value),
                          ),
                          Space(),
                          type == TIMER
                              ? _timerPicker(
                                  context,
                                  minuteTextController: minuteTextController,
                                  secondTextController: secondTextController,
                                )
                              : _repPicker(
                                  context,
                                  repsTextController: repTextController,
                                ),
                          Space(size: Spacing.LARGE),
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
                                  final reps =
                                      int.tryParse(repTextController.text) ?? 0;
                                  final repTime = int.tryParse(
                                          repTimeTextController.text) ??
                                      0;
                                  final exercise = Exercise(
                                    name: nameTextController.text,
                                    time: type == TIMER ? min * 60 + sec : 0,
                                    rep: type == REPS ? reps : 0,
                                    repTime: type == REPS ? repTime : 0,
                                  );
                                  onSave(exercise);
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

Widget _typeSwitch(
  BuildContext context, {
  required String value,
  required ValueChanged<String> onTypeChanged,
}) =>
    GroupButton(
      isRadio: true,
      spacing: Spacing.SMALL_2,
      buttons: [TIMER, REPS],
      selectedButton: value == TIMER ? 0 : 1,
      selectedTextStyle: TextStyles.body.copyWith(color: Colors.white),
      unselectedTextStyle:
          TextStyles.body.copyWith(color: secondaryColor(context)),
      selectedColor: secondaryColor(context),
      unselectedColor: Theme.of(context).canvasColor,
      unselectedBorderColor: secondaryColor(context),
      borderRadius: BorderRadius.circular(AppRadius.DEFAULT),
      onSelected: (index, isSelected) {
        if (index == 0) {
          onTypeChanged(TIMER);
        } else {
          onTypeChanged(REPS);
        }
      },
    );

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

Widget _repPicker(
  BuildContext context, {
  required TextEditingController repsTextController,
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
                controller: repsTextController,
                textAlign: TextAlign.center,
              ),
            ),
            Space(size: Spacing.SMALL),
            AppText('Reps'),
          ],
        ),
        Space(),
        Column(
          children: [AppText('x'), AppText('')],
        ),
        Space(),
        Column(
          children: [
            SizedBox(
              width: 80,
              child: EditText(
                hint: '0',
                controller: repsTextController,
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

const String TIMER = 'Timer';
const String REPS = 'Reps';

Widget _editTextName(TextEditingController controller) => EditText(
      hint: 'Exercise Name',
      controller: controller,
      autoFocus: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Exercise name is required';
        }
        return null;
      },
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

NumberSelectionTheme numberPickerTheme(BuildContext context) =>
    NumberSelectionTheme(
      draggableCircleColor: secondaryColor(context),
      iconsColor: isDarkMode(context)
          ? secondaryColorLight(context)
          : secondaryColorVariant(context),
      numberColor: Colors.white,
      backgroundColor:
          isDarkMode(context) ? Colors.grey[600] : Colors.grey[300],
      outOfConstraintsColor: Colors.red[700],
    );
