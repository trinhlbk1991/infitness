import 'package:flutter/material.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/view_utils.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/buttons/icon_button.dart';
import 'package:infitness/widgets/space.dart';
import 'package:simple_timer/simple_timer.dart';

enum TimerState { IDLE, PLAYING, PAUSED }

Widget exerciseTimer(
  BuildContext context, {
  required TimerController timerController,
  required Exercise exercise,
  TimerState state = TimerState.IDLE,
  bool canForward = true,
  bool canBackward = false,
  required double height,
  required Function onStartTapped,
  required Function onPauseTapped,
  required Function onResumeTapped,
  required Function(Exercise) onNextTapped,
  required Function(Exercise) onPreviousTapped,
  required Function(Exercise) onFinishTapped,
  required Function(Exercise) onTimerFinished,
  required Function(int, int) onValueChanged,
}) {
  return SizedBox(
    height: height,
    child: Stack(
      children: [
        _container(
          context,
          height: height - 30,
          child: Column(
            children: [
              Expanded(
                child: _timer(
                  context,
                  exercise,
                  timerController,
                  onTimerFinished,
                  onValueChanged,
                ),
              ),
              Space(),
              AppText(
                exercise.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              _navigationButtons(
                context,
                exercise,
                canForward,
                canBackward,
                onNextTapped,
                onPreviousTapped,
                onFinishTapped,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            child: _btnStart(
              context,
              state,
              onStartTapped,
              onPauseTapped,
              onResumeTapped,
            ),
            alignment: Alignment.bottomCenter,
          ),
        ),
      ],
    ),
  );
}

Widget _btnStart(
  BuildContext context,
  TimerState state,
  Function onStartTapped,
  Function onPauseTapped,
  Function onResumeTapped,
) {
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

Widget _navigationButtons(
  BuildContext context,
  Exercise exercise,
  bool canForward,
  bool canBackward,
  Function(Exercise) onNextTapped,
  Function(Exercise) onPreviousTapped,
  Function(Exercise) onFinishTapped,
) {
  return paddingOnly(
    left: Spacing.LARGE,
    right: Spacing.LARGE,
    bottom: Spacing.NORMAL,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        canBackward
            ? iconOutlineButton(
                context,
                icon: Icons.fast_rewind_rounded,
                color: secondaryColor(context),
                buttonSize: 44,
                iconSize: 28,
                onPressed: () => onPreviousTapped(exercise),
              )
            : Expanded(child: Container()),
        iconOutlineButton(
          context,
          icon: canForward ? Icons.fast_forward_rounded : Icons.stop_rounded,
          color: secondaryColor(context),
          buttonSize: 44,
          iconSize: 28,
          onPressed: () =>
              canForward ? onNextTapped(exercise) : onFinishTapped(exercise),
        ),
      ],
    ),
  );
}

Widget _timer(
  BuildContext context,
  Exercise exercise,
  TimerController timerController,
  Function(Exercise) onTimerFinished,
  Function(int, int) onValueChanged,
) {
  final String Function(Duration timeElapsed)? _progressTimeTextFormatter =
      (timeElapsed) {
    final minutes = timeElapsed.inMinutes.toString().padLeft(2, '0');
    final seconds = (timeElapsed.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  };

  final String Function(Duration timeElapsed)? _progressRepTextFormatter =
      (timeElapsed) {
    final currentRep = exercise.rep - timeElapsed.inSeconds ~/ exercise.repTime;
    return '$currentRep / ${exercise.rep}';
  };

  return Container(
    margin: EdgeInsets.all(Spacing.NORMAL),
    child: SimpleTimer(
      duration: Duration(
        seconds:
            exercise.time > 0 ? exercise.time : exercise.rep * exercise.repTime,
      ),
      controller: timerController,
      progressTextStyle: Theme.of(context)
          .textTheme
          .headline1
          ?.copyWith(color: secondaryColor(context), fontSize: 70),
      progressTextFormatter: exercise.time > 0
          ? _progressTimeTextFormatter
          : _progressRepTextFormatter,
      progressIndicatorDirection: TimerProgressIndicatorDirection.clockwise,
      progressIndicatorColor: secondaryColor(context),
      backgroundColor: secondaryColor(context).withOpacity(0.1),
      strokeWidth: 20,
      onEnd: () => onTimerFinished(exercise),
      valueListener: (value) => onValueChanged(
          value.inMilliseconds, timerController.duration?.inMilliseconds ?? 0),
    ),
  );
}

Widget _container(
  BuildContext context, {
  required Widget child,
  required double height,
}) =>
    Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            offset: Offset(0.0, 7.0),
          )
        ],
      ),
      child: child,
    );
