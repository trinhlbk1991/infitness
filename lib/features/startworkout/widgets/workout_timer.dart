import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/utils/date_time_utils.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:simple_timer/simple_timer.dart';

import 'exercise_timer.dart' as inf;

class WorkoutTimer extends StatefulWidget {
  final TimerController timerController;
  final Exercise exercise;
  final Function(Exercise) onTimerFinished;
  final Function(int, int) onValueChanged;

  const WorkoutTimer({
    Key? key,
    required this.timerController,
    required this.exercise,
    required this.onTimerFinished,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  _WorkoutTimerState createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  String _progressText = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _progressText = _formatProgress(0, widget.exercise);
    });
  }

  @override
  Widget build(BuildContext context) {
    return workoutTimer(
      context,
      timerController: widget.timerController,
      exercise: widget.exercise,
      onTimerFinished: widget.onTimerFinished,
      onValueChanged: widget.onValueChanged,
    );
  }

  Widget workoutTimer(
    BuildContext context, {
    required TimerController timerController,
    required Exercise exercise,
    inf.TimerState state = inf.TimerState.IDLE,
    required Function(Exercise) onTimerFinished,
    required Function(int, int) onValueChanged,
  }) {
    return Container(
      width: double.infinity,
      child: _timer(
        context,
        exercise,
        timerController,
        onTimerFinished,
        onValueChanged,
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
    return Stack(
      children: [
        SimpleTimer(
          duration: Duration(
            seconds: exercise.time > 0
                ? exercise.time
                : exercise.rep * exercise.repTime,
          ),
          controller: timerController,
          displayProgressText: false,
          progressIndicatorColor: secondaryColor(context),
          backgroundColor: secondaryColor(context).withOpacity(0.1),
          strokeWidth: 20,
          onEnd: () => onTimerFinished(exercise),
          valueListener: (value) {
            setState(() {
              _progressText = _formatProgress(value.inSeconds, exercise);
            });
            onValueChanged(value.inMilliseconds,
                timerController.duration?.inMilliseconds ?? 0);
          },
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  _progressText,
                  style: GoogleFonts.anton(fontSize: TIMER_PROGRESS_SIZE),
                ),
                exercise.time == 0
                    ? AppText(
                        '/ ${exercise.rep}',
                        style: GoogleFonts.anton(
                          fontSize: TIMER_PROGRESS_SUB_SIZE,
                          color: textColorSecondary(context),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        )
      ],
    );
  }

  String _formatProgress(int value, Exercise exercise) => exercise.time > 0
      ? DateTimeUtils.formatSeconds(exercise.time - value)
      : '${value ~/ exercise.repTime}';

  static const TIMER_PROGRESS_SIZE = 72.0;
  static const TIMER_PROGRESS_SUB_SIZE = 20.0;
}
