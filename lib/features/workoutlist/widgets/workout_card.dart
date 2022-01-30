import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/model/workout.dart';
import 'package:infitness/theme/app_theme.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/date_time_utils.dart';
import 'package:infitness/utils/view_utils.dart';
import 'package:infitness/widgets/app_card.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/buttons/icon_button.dart';
import 'package:infitness/widgets/column_builder.dart';
import 'package:infitness/widgets/space.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    Key? key,
    required this.workout,
    required this.onStart,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  final Workout workout;
  final ValueChanged<Workout> onDelete;
  final ValueChanged<Workout> onEdit;
  final ValueChanged<Workout> onStart;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Expandable(
        collapsed: _collapsedCard(context),
        expanded: _expandedCard(context),
      ),
    );
  }

  _collapsedCard(BuildContext context) {
    return ExpandableButton(
      child: card(
        margin: EdgeInsets.only(bottom: Spacing.NORMAL, left: 1, right: 1),
        child: _workoutSummary(context),
      ),
    );
  }

  _expandedCard(BuildContext context) {
    return ExpandableButton(
      child: card(
        margin: EdgeInsets.only(bottom: Spacing.NORMAL, left: 1, right: 1),
        child: Column(
          children: [
            _workoutSummary(context),
            _workoutDetails(context),
            padding(
              padding: Spacing.NORMAL,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconButton(context, Icons.delete_outline_rounded, onDelete),
                  Icon(
                    Icons.expand_less_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  _iconButton(context, Icons.edit_rounded, onEdit),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _iconButton(
    BuildContext context,
    IconData icon,
    ValueChanged<Workout> onPressed,
  ) {
    return iconOutlineButton(
      context,
      icon: icon,
      onPressed: () => onPressed(workout),
      buttonSize: 36,
      iconSize: 20,
    );
  }

  Widget _workoutSummary(BuildContext context) {
    return padding(
      padding: Spacing.NORMAL,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  workout.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Space(size: Spacing.TINY),
                AppText(
                  _workoutEstTime(workout),
                  color: textColorSecondary(context),
                ),
              ],
            ),
          ),
          Space(),
          iconButton(
            context,
            icon: Icons.play_arrow_rounded,
            onPressed: () => onStart(workout),
          ),
        ],
      ),
    );
  }

  Widget _workoutDetails(BuildContext context) {
    return paddingOnly(
      child: ColumnBuilder(
        itemBuilder: (context, index) {
          return _setItem(context, index, workout.sets[index]);
        },
        itemCount: workout.sets.length,
      ),
    );
  }

  Widget _setItem(BuildContext context, int index, Set set) {
    return Container(
      margin: EdgeInsets.only(
        top: Spacing.SMALL,
        left: Spacing.NORMAL,
        right: Spacing.NORMAL,
      ),
      padding: EdgeInsets.only(
        left: Spacing.NORMAL,
        right: Spacing.NORMAL,
        top: Spacing.SMALL,
        bottom: Spacing.SMALL,
      ),
      decoration: BoxDecoration(
        color: index % 2 == 0
            ? secondaryColor(context).withOpacity(0.15)
            : isDarkMode(context)
                ? Colors.grey[500]!.withOpacity(0.15)
                : Colors.grey[100]!.withOpacity(0.9),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Stack(
        children: [
          ColumnBuilder(
            itemBuilder: (context, index) {
              final exercise = set.exercises[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    child: AppText(
                      exercise.time > 0
                          ? DateTimeUtils.formatSeconds(exercise.time)
                          : '${exercise.rep}',
                      color: textColorSecondary(context),
                    ),
                  ),
                  Expanded(
                    child: AppText(
                      exercise.name,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              );
            },
            itemCount: set.exercises.length,
          ),
          set.repeat > 1
              ? Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AppText(
                      'x${set.repeat}',
                      fontWeight: FontWeight.bold,
                      color: secondaryColor(context),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

String _workoutEstTime(Workout workout) {
  var time = 0;
  workout.sets.forEach((set) {
    final setTime = set.exercises.fold(
        0,
        (previousValue, element) =>
            (previousValue as int) + element.time + element.rep * 5);
    time += setTime * set.repeat;
  });
  return 'Duration: ${DateTimeUtils.formatSeconds(time)}';
}
