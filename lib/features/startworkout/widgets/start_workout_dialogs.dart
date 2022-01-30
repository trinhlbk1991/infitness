import 'package:flutter/material.dart';
import 'package:infitness/widgets/alert_bottom_sheet.dart';
import 'package:infitness/widgets/simple_timer.dart';

showConfirmExitDialog(BuildContext context,
    TimerController _timerController,
    bool isFirstExercise,) {
  if (!_timerController.isAnimating && isFirstExercise) {
    Navigator.of(context).pop();
    return true;
  }

  return showAlertBottomSheet(
    context,
    title: 'Stop Workout',
    message:
    'Do you want to stop the current workout? You can not resume this workout later.',
    positiveText: 'Stop',
    positiveStyle: PositiveStyle.primaryRed,
    positiveClicked: () {
      Navigator.of(context).pop();
    },
  );
}

showFinishDialog(BuildContext context, String workoutName,
    {required Function onFinish}) {
  showAlertBottomSheet(
    context,
    title: 'Congratulations',
    message: 'You\'ve just finished $workoutName!',
    positiveText: 'Finish',
    positiveStyle: PositiveStyle.primary,
    positiveClicked: () {
      onFinish();
      Navigator.of(context).pop();
    },
    negativeText: null,
  );
}
