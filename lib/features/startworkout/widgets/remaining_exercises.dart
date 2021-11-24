import 'package:flutter/material.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/theme/app_theme.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/date_time_utils.dart';
import 'package:infitness/widgets/app_card.dart';
import 'package:infitness/widgets/app_text.dart';

import '../start_workout_state.dart';

Widget remainingExercises(Key? key, StartWorkoutState state) {
  final remainingExercises = state.getRemainingExercises();
  return AnimatedList(
    key: key,
    itemBuilder: (context, index, animation) => animateExerciseCard(
        context,
        index,
        remainingExercises[index],
        index == remainingExercises.length - 1,
        animation),
    initialItemCount: remainingExercises.length,
  );
}

Widget animateExerciseCard(
  BuildContext context,
  int index,
  Exercise exercise,
  bool isLastExercise,
  animation,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(animation),
    child: exercise is Rest
        ? _restCard(context, index, exercise)
        : _exerciseCard(context, index, exercise, isLastExercise),
  );
}

Widget _exerciseCard(BuildContext context, int index, Exercise exercise, bool isLastExercise) =>
    card(
      borderWidth: 2,
      margin: EdgeInsets.only(
        left: Spacing.NORMAL,
        right: Spacing.NORMAL,
        top: Spacing.NORMAL,
        bottom: isLastExercise ? Spacing.NORMAL : 0,
      ),
      padding: EdgeInsets.only(left: Spacing.NORMAL),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              exercise.name,
              fontSize: TextSize.HEADER,
            ),
          ),
          Container(
            width: 100,
            height: 64,
            decoration: BoxDecoration(
              color: secondaryColor(context),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppRadius.CARD),
                bottomRight: Radius.circular(AppRadius.CARD),
              ),
            ),
            child: Center(
              child: AppText(
                exercise.time > 0
                    ? DateTimeUtils.formatSeconds(exercise.time)
                    : 'x${exercise.rep}',
                fontSize: TextSize.HEADER,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );

Widget _restCard(BuildContext context, int index, Exercise exercise) => card(
      borderWidth: 2,
      color: Theme.of(context).canvasColor,
      borderColor: secondaryColor(context).withOpacity(0.7),
      margin: EdgeInsets.only(
        left: Spacing.NORMAL,
        right: Spacing.NORMAL,
        top: Spacing.NORMAL,
      ),
      padding: EdgeInsets.only(left: Spacing.NORMAL),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              exercise.name,
              fontSize: TextSize.HEADER,
            ),
          ),
          Container(
            width: 100,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppRadius.CARD),
                bottomRight: Radius.circular(AppRadius.CARD),
              ),
            ),
            child: Center(
              child: AppText(
                exercise.time > 0
                    ? DateTimeUtils.formatSeconds(exercise.time)
                    : 'x${exercise.rep}',
                fontSize: TextSize.HEADER,
              ),
            ),
          )
        ],
      ),
    );
