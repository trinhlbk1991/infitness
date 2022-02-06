import 'package:flutter/material.dart';
import 'package:infitness/widgets/buttons/icon_button.dart';
import 'workout_timer.dart';

Widget btnStart(
  BuildContext context, {
  required TimerState state,
  required Function onStartTapped,
  required Function onPauseTapped,
  required Function onResumeTapped,
}) {
  return iconButton(
    context,
    icon: state == TimerState.PLAYING
        ? Icons.pause_rounded
        : Icons.play_arrow_rounded,
    buttonSize: 72,
    iconSize: 56,
    onPressed: () {
      switch (state) {
        case TimerState.IDLE:
          onStartTapped();
          break;
        case TimerState.PLAYING:
          onPauseTapped();
          break;
        case TimerState.PAUSED:
          onResumeTapped();
          break;
      }
    },
  );
}
