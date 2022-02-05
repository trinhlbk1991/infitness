import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/base/base_bloc_builder.dart';
import 'package:infitness/base/base_state.dart';
import 'package:infitness/features/startworkout/start_workout_cubit.dart';
import 'package:infitness/features/startworkout/start_workout_state.dart';
import 'package:infitness/features/startworkout/widgets/button_start.dart';
import 'package:infitness/features/startworkout/widgets/workout_timer.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/model/workout.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/asset_audio_utils.dart';
import 'package:infitness/utils/date_time_utils.dart';
import 'package:infitness/utils/tts_utils.dart';
import 'package:infitness/utils/view_utils.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/buttons/icon_button.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:wakelock/wakelock.dart';

import 'widgets/start_workout_dialogs.dart';

class StartWorkoutScreen extends StatefulWidget {
  final Workout workout;

  const StartWorkoutScreen({Key? key, required this.workout}) : super(key: key);

  @override
  _StartWorkoutScreenState createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends BaseState<StartWorkoutScreen>
    with SingleTickerProviderStateMixin {
  static const TAG = 'StartWorkoutScreen';

  late StartWorkoutCubit _cubit;

  late TimerController _timerController;

  final TtsUtils _ttsUtils = TtsUtils();
  final AssetAudioUtils _assetAudioUtils = AssetAudioUtils();

  StreamSubscription? _subscription;

  int startWorkoutTime = 0;
  int totalWorkoutTime = 0;

  @override
  void initState() {
    super.initState();
    _timerController = TimerController(this);

    _ttsUtils.init();
    _assetAudioUtils.open("assets/countdown.wav");

    setState(() {
      Wakelock.enable();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = BlocProvider.of(context);

    if (_subscription == null) {
      _subscription = _cubit.stream.listen((event) {
        _onStateChanged(context, event);
      });
    }

    _cubit.init(widget.workout);
  }

  @override
  void dispose() {
    _ttsUtils.stop();
    _assetAudioUtils.stop();
    _timerController.dispose();
    _subscription?.cancel();
    _cubit.close();

    setState(() {
      Wakelock.disable();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return showConfirmExitDialog(
          context,
          _timerController,
          _cubit.state.isFirstExercise(),
        );
      },
      child: BaseBlocBuilder<StartWorkoutCubit, StartWorkoutState>(
        showLog: false,
        builder: (context, state) {
          return scaffoldSafe(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _backIcon(context),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _expanded(),
                      AppText(_workoutTimeText(state)),
                      _expanded(),
                      paddingOnly(
                        left: Spacing.LARGE,
                        right: Spacing.LARGE,
                        bottom: Spacing.NORMAL_2,
                        child: WorkoutTimer(
                          timerController: _timerController,
                          exercise: state.getCurrentExercise(),
                          onTimerFinished: (exercise) => _cubit.nextExercise(),
                          onValueChanged: (progress, max) {
                            if (max - progress <= 5000) {
                              _assetAudioUtils.play();
                            }

                            setState(() {
                              totalWorkoutTime = _totalWorkoutTime();
                            });
                          },
                        ),
                      ),
                      paddingOnly(
                        left: Spacing.NORMAL,
                        right: Spacing.NORMAL,
                        child: AppText(
                          state.getCurrentExercise().name,
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      paddingOnly(
                        left: Spacing.NORMAL,
                        right: Spacing.NORMAL,
                        child: AppText(
                          state.canForward()
                              ? 'Next: ${state.getNextExercise()?.name}'
                              : '',
                          color: textColorSecondary(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      _expanded(),
                      _bottomActions(context, state)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded _expanded() => Expanded(child: Container());

  Widget _bottomActions(BuildContext context, StartWorkoutState state) {
    return paddingOnly(
      bottom: Spacing.LARGE_2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          state.canBackward()
              ? iconOutlineButton(
                  context,
                  icon: Icons.fast_rewind_rounded,
                  buttonSize: 48,
                  onPressed: () => _cubit.previousExercise(),
                )
              : Container(width: 48),
          btnStart(
            context,
            state: state.timerState,
            onStartTapped: () => _startWorkout(state),
            onPauseTapped: () => _pauseWorkout(),
            onResumeTapped: () => _resumeWorkout(),
          ),
          state.isFirstExercise() && !_timerController.isAnimating
              ? Container(width: 48)
              : state.canForward()
                  ? iconOutlineButton(
                      context,
                      icon: Icons.fast_forward_rounded,
                      buttonSize: 48,
                      onPressed: () => _cubit.nextExercise(),
                    )
                  : iconOutlineButton(
                      context,
                      icon: Icons.stop_rounded,
                      buttonSize: 48,
                      onPressed: () => showFinishDialog(
                        context,
                        state.workout.name,
                        onFinish: () => _cubit.saveWorkoutHistory(),
                      ),
                    ),
        ],
      ),
    );
  }

  void _resumeWorkout() {
    _cubit.resumeExercise();
    if (_timerController.duration != Duration.zero) {
      _timerController.start();
    }
  }

  void _pauseWorkout() {
    _cubit.pauseExercise();
    _timerController.pause();
    _assetAudioUtils.pause();
  }

  void _startWorkout(StartWorkoutState state) {
    startWorkoutTime = DateTime.now().millisecondsSinceEpoch;
    _cubit.startExercise();
    if (_timerController.duration != Duration.zero) {
      _timerController.start();
    }
    _speakExercise(state.getCurrentExercise());
  }

  Widget _backIcon(BuildContext context) {
    return IconButton(
      iconSize: 24,
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: secondaryColor(context),
      ),
      onPressed: () => showConfirmExitDialog(
        context,
        _timerController,
        _cubit.state.isFirstExercise(),
      ),
    );
  }

  void _onStateChanged(BuildContext context, StartWorkoutState state) {
    final exercise = state.exercises[state.exerciseIndex];

    if (state is StartWorkoutState_Init) {
      if (exercise.time > 0) {
        _timerController.duration = Duration(seconds: exercise.time);
      }
    } else if (state is StartWorkoutState_Forward) {
      if (exercise.time > 0) {
        _timerController.duration = Duration(seconds: exercise.time);
      } else {
        _timerController.duration =
            Duration(seconds: exercise.rep * exercise.repTime);
      }
      _timerController.restart();
      _speakExercise(exercise);
      _assetAudioUtils.stop();
    } else if (state is StartWorkoutState_Backward) {
      if (exercise.time > 0) {
        _timerController.duration = Duration(seconds: exercise.time);
      } else {
        _timerController.duration =
            Duration(seconds: exercise.rep * exercise.repTime);
      }
      _timerController.restart();
      _assetAudioUtils.stop();
    } else if (state is StartWorkoutState_Finished) {
      showFinishDialog(
        context,
        state.workout.name,
        onFinish: () => _cubit.saveWorkoutHistory(),
      );
    }
  }

  Future _speakExercise(Exercise exercise) async {
    var text = '';
    if (exercise.rep > 0) {
      text += '${exercise.rep} reps ';
    }
    if (exercise.time > 0) {
      final minutes = exercise.time ~/ 60;
      final seconds = exercise.time % 60;

      if (minutes > 0) {
        text += '$minutes minutes ';
      }
      if (seconds > 0) {
        text += '$seconds seconds ';
      }
    }
    text += exercise.name;

    await _ttsUtils.speak(text);
  }

  String _workoutTimeText(StartWorkoutState state) {
    final estTime = DateTimeUtils.formatSeconds(state.workout.estTime());
    totalWorkoutTime = _totalWorkoutTime();
    return '${DateTimeUtils.formatSeconds(totalWorkoutTime)} / $estTime';
  }

  int _totalWorkoutTime() => startWorkoutTime == 0
      ? 0
      : (DateTime.now().millisecondsSinceEpoch - startWorkoutTime) ~/ 1000;
}
