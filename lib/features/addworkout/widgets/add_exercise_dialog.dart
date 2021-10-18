import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/theme/text_styles.dart';
import 'package:infitness/utils/log.dart';
import 'package:infitness/utils/view_utils.dart';
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
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var type = (exercise != null && exercise.rep > 0) ? REPS : TIMER;
  var minutes = exercise != null ? exercise.time ~/ 60 : 0;
  var seconds = exercise != null ? exercise.time % 60 : 30;
  var reps = exercise != null ? exercise.rep : 15;

  if (exercise != null) {
    controller.text = exercise.name;
  }

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
                          _editTextName(controller),
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
                                  minutes: minutes,
                                  seconds: seconds,
                                  onMinutesChanged: (value) => minutes = value,
                                  onSecondsChanged: (value) => seconds = value,
                                )
                              : _repPicker(
                                  context,
                                  reps: reps,
                                  onRepsChanged: (value) => reps = value,
                                ),
                          Space(size: Spacing.LARGE),
                          Row(
                            children: [
                              _btnCancel(context),
                              Space(),
                              _btnSave(context, () {
                                if (formKey.currentState!.validate()) {
                                  final exercise = Exercise(
                                    name: controller.text,
                                    time: type == TIMER
                                        ? minutes * 60 + seconds
                                        : 0,
                                    rep: type == REPS ? reps : 0,
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
  required int minutes,
  required int seconds,
  required ValueChanged<int> onMinutesChanged,
  required ValueChanged<int> onSecondsChanged,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            SizedBox(
              width: 120,
              child: NumberPicker(
                theme: numberPickerTheme(context),
                minValue: 0,
                maxValue: 60,
                initialValue: minutes,
                direction: Axis.horizontal,
                onChanged: (value) => onMinutesChanged(value),
              ),
            ),
            Space(size: Spacing.SMALL),
            AppText('Minutes'),
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: 120,
              child: NumberPicker(
                theme: numberPickerTheme(context),
                initialValue: seconds,
                minValue: 0,
                maxValue: 60,
                step: 5,
                direction: Axis.horizontal,
                onChanged: (value) => onSecondsChanged(value),
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
  required int reps,
  required ValueChanged<int> onRepsChanged,
}) =>
    SizedBox(
      width: 120,
      height: 79,
      child: NumberPicker(
        theme: numberPickerTheme(context),
        minValue: 1,
        initialValue: reps,
        maxValue: 10000,
        direction: Axis.horizontal,
        onChanged: (value) => onRepsChanged(value),
      ),
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
      iconsColor: secondaryColorVariant(context),
      numberColor: Colors.white,
      backgroundColor: Colors.grey[300],
      outOfConstraintsColor: Colors.red[700],
    );
