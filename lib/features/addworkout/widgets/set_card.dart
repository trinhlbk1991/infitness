import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/date_time_utils.dart';
import 'package:infitness/widgets/app_card.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/column_builder.dart';
import 'package:infitness/widgets/number_picker.dart';
import 'package:infitness/widgets/space.dart';
import 'package:tuple/tuple.dart';

import 'add_exercise_dialog.dart';

class SetCard extends StatelessWidget {
  final int index;
  final Set set;
  final EdgeInsets? margin;
  final ValueChanged<int> onRepeatChanged;
  final ValueChanged<Set> onAddExercise;
  final ValueChanged<int> onDeleteExercise;
  final ValueChanged<Tuple2<int, Exercise>> onEditExercise;

  const SetCard({
    Key? key,
    required this.index,
    required this.set,
    required this.onRepeatChanged,
    required this.onAddExercise,
    required this.onDeleteExercise,
    required this.onEditExercise,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: card(
        padding: EdgeInsets.all(Spacing.NORMAL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headline6Text(context, 'Set ${index + 1}'),
                _setRepeat(context)
              ],
            ),
            Space(),
            _exercises(set.exercises),
            Space(),
            _btnAddExercise(context),
          ],
        ),
      ),
    );
  }

  Row _setRepeat(BuildContext context) {
    return Row(
      children: [
        AppText(
          'Repeat',
          color: textColorPrimary(context),
        ),
        Space(size: Spacing.SMALL),
        SizedBox(
          height: 32,
          child: NumberPicker(
            theme: numberPickerTheme(context),
            initialValue: set.repeat,
            minValue: 1,
            maxValue: 1000,
            direction: Axis.horizontal,
            withSpring: true,
            onChanged: (value) => onRepeatChanged(value),
          ),
        ),
      ],
    );
  }

  Container _btnAddExercise(BuildContext context) => Container(
        width: double.infinity,
        child: Material(
          child: InkWell(
            onTap: () => onAddExercise(set),
            borderRadius: BorderRadius.circular(AppRadius.DEFAULT),
            child: DottedBorder(
              strokeWidth: 1,
              dashPattern: [5, 3],
              color: textColorSecondary(context),
              radius: Radius.circular(AppRadius.DEFAULT),
              padding: EdgeInsets.all(Spacing.NORMAL),
              borderType: BorderType.RRect,
              child: Center(
                child: AppText(
                  'ADD EXERCISE',
                  color: textColorSecondary(context),
                ),
              ),
            ),
          ),
        ),
      );

  _exercises(List<Exercise> exercises) => ColumnBuilder(
        itemBuilder: (context, index) {
          final exercise = set.exercises[index];
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: Spacing.SMALL),
            decoration: BoxDecoration(
              color: secondaryColor(context).withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey[300]!),
            ),
            padding: EdgeInsets.only(
              left: Spacing.NORMAL,
              right: Spacing.NORMAL,
              top: Spacing.SMALL,
              bottom: Spacing.SMALL,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        exercise.name,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      AppText(
                        exercise.time > 0
                            ? DateTimeUtils.formatSeconds(exercise.time)
                            : (exercise.repTime == 0)
                                ? '${exercise.rep} Reps'
                                : '${exercise.rep} Reps x ${exercise.rep} Secs',
                        color: textColorSecondary(context),
                      ),
                    ],
                  ),
                ),
                _iconButton(
                  context,
                  Icons.delete_outline_rounded,
                  () => onDeleteExercise(index),
                ),
                _iconButton(
                  context,
                  Icons.edit_rounded,
                  () => onEditExercise(Tuple2(index, exercise)),
                ),
              ],
            ),
          );
        },
        itemCount: exercises.length,
      );

  Widget _iconButton(
    BuildContext context,
    IconData icon,
    Function onPressed,
  ) {
    return Container(
      width: 32,
      height: 32,
      margin: EdgeInsets.only(left: Spacing.TINY),
      child: InkWell(
        onTap: () => onPressed(),
        borderRadius: BorderRadius.circular(100),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 24,
        ),
      ),
    );
  }
}
