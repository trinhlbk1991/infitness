import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/app_card.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/number_picker.dart';
import 'package:infitness/widgets/space.dart';

import 'add_exercise_dialog.dart';

restSettings(
  BuildContext context, {
  int restSet = 0,
  int restExercise = 0,
  required ValueChanged<int> onUpdateRestSet,
  required ValueChanged<int> onUpdateRestExercise,
}) {
  return card(
    padding: EdgeInsets.all(Spacing.NORMAL),
    child: Column(
      children: [
        _restSettingItem(
          context,
          'Rest between set',
          restSet,
          (value) => onUpdateRestSet(value),
        ),
        Space(),
        _restSettingItem(
          context,
          'Rest between exercise',
          restExercise,
          (value) => onUpdateRestExercise(value),
        ),
      ],
    ),
  );
}

_restSettingItem(
  BuildContext context,
  String label,
  int restSet,
  ValueChanged<int> onChanged,
) {
  return Row(
    children: [
      AppText(label, color: textColorPrimary(context)),
      Expanded(child: Container()),
      SizedBox(
        height: 32,
        child: NumberPicker(
          theme: numberPickerTheme(context),
          initialValue: restSet,
          minValue: 0,
          maxValue: 1000,
          step: 5,
          direction: Axis.horizontal,
          withSpring: true,
          onChanged: (value) => onChanged(value),
        ),
      ),
    ],
  );
}
