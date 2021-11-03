import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:infitness/base/base_bloc_builder.dart';
import 'package:infitness/base/base_state.dart';
import 'package:infitness/features/startworkout/start_workout_cubit.dart';
import 'package:infitness/features/startworkout/start_workout_state.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/model/workout.dart';
import 'package:infitness/utils/log.dart';
import 'package:infitness/utils/screen_size_utils.dart';
import 'package:infitness/widgets/alert_bottom_sheet.dart';
import 'package:infitness/widgets/app_bar.dart';
import 'package:infitness/widgets/simple_timer.dart';

import 'widgets/exercise_timer.dart';
import 'widgets/remaining_exercises.dart';

class StartWorkoutScreen extends StatefulWidget {
  final Workout workout;

  const StartWorkoutScreen({Key? key, required this.workout}) : super(key: key);

  @override
  _StartWorkoutScreenState createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends BaseState<StartWorkoutScreen>
    with SingleTickerProviderStateMixin {
  late StartWorkoutCubit _cubit;

  late TimerController _timerController;
  final _listViewKey = GlobalKey<AnimatedListState>();

  late FlutterTts _flutterTts;
  final _assetsAudioPlayer = AssetsAudioPlayer();

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _timerController = TimerController(this);
    _initTts();
    _assetsAudioPlayer.open(Audio("assets/countdown.wav"), autoStart: false);
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
    _flutterTts.stop();
    _assetsAudioPlayer.stop();
    _timerController.dispose();
    _subscription?.cancel();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenSizeUtils.height(context);

    return WillPopScope(
      onWillPop: () async {
        return _showConfirmExitDialog();
      },
      child: BaseBlocBuilder<StartWorkoutCubit, StartWorkoutState>(
        showLog: false,
        builder: (context, state) {
          return scaffoldSafe(
            child: Column(
              children: [
                appBar(context, state.workout.name,
                    elevation: 0, onBackPress: () => _showConfirmExitDialog()),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          child: SizedBox(
                            height: screenHeight * 1.5 / 5,
                            child: remainingExercises(_listViewKey, state),
                          ),
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      exerciseTimer(context,
                          timerController: _timerController,
                          exercise: state.getCurrentExercise(),
                          state: state.timerState,
                          canForward: state.canForward(),
                          canBackward: state.canBackward(),
                          height: screenHeight * 3 / 5, onStartTapped: () {
                        _cubit.startExercise();
                        if (_timerController.duration != Duration.zero) {
                          _timerController.start();
                        }
                        _speakExercise(state.getCurrentExercise());
                      }, onPauseTapped: () {
                        _cubit.pauseExercise();
                        _timerController.pause();
                        if (_assetsAudioPlayer.isPlaying.value) {
                          _assetsAudioPlayer.pause();
                        }
                      }, onResumeTapped: () {
                        _cubit.resumeExercise();
                        if (_timerController.duration != Duration.zero) {
                          _timerController.start();
                        }
                      }, onNextTapped: (exercise) {
                        Log.i('KAI', 'NEXT');
                        _cubit.nextExercise();
                      }, onPreviousTapped: (exercise) {
                        _cubit.previousExercise();
                      }, onFinishTapped: (exercise) {
                        _timerController.pause();
                        _showFinishDialog();
                      }, onTimerFinished: (exercise) {
                        _cubit.nextExercise();
                      }, onValueChanged: (progress, max) {
                        if (max - progress <= 5000 &&
                            !_assetsAudioPlayer.isPlaying.value) {
                          _assetsAudioPlayer.play();
                        }
                      }),
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

  _removeTopExercise(Exercise exercise) {
    _listViewKey.currentState?.removeItem(
      0,
      (context, animation) =>
          animateExerciseCard(context, 0, exercise, animation),
    );
  }

  _addTopExercise() {
    _listViewKey.currentState?.insertItem(0);
  }

  void _onStateChanged(BuildContext context, StartWorkoutState state) {
    final set = state.workout.sets[state.currentSet];
    final exercise = set.exercises[state.currentExercise];

    if (state is StartWorkoutState_Init) {
      if (exercise.time > 0) {
        _timerController.duration = Duration(seconds: exercise.time);
      }
    } else if (state is StartWorkoutState_Forward) {
      _removeTopExercise(exercise);
      if (exercise.time > 0) {
        _timerController.duration = Duration(seconds: exercise.time);
        _timerController.restart();
      } else {
        _timerController.pause();
      }
      _speakExercise(exercise);
      if (_assetsAudioPlayer.isPlaying.value) {
        _assetsAudioPlayer.stop();
      }
    } else if (state is StartWorkoutState_Backward) {
      _addTopExercise();
      if (exercise.time > 0) {
        _timerController.duration = Duration(seconds: exercise.time);
        _timerController.restart();
      } else {
        _timerController.pause();
      }
      if (_assetsAudioPlayer.isPlaying.value) {
        _assetsAudioPlayer.stop();
      }
    } else if (state is StartWorkoutState_Finished) {
      _showFinishDialog();
    }
  }

  _showConfirmExitDialog() {
    if (!_timerController.isAnimating && _cubit.state.isFirstExercise()) {
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

  _showFinishDialog() {
    showAlertBottomSheet(
      context,
      title: 'Congratulations',
      message: 'You\'ve just finished ${_cubit.state.workout.name}!',
      positiveText: 'Finish',
      positiveStyle: PositiveStyle.primary,
      positiveClicked: () {
        Navigator.of(context).pop();
      },
      negativeText: null,
    );
  }

  bool get isIOS => !kIsWeb && Platform.isIOS;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isWeb => kIsWeb;

  _initTts() {
    _flutterTts = FlutterTts();

    if (isAndroid) {
      _getDefaultEngine();
    }

    _flutterTts.setErrorHandler((msg) {
      Log.e('StartWorkoutScreen', 'TTS exercise name failed: $msg');
    });
  }

  Future _getDefaultEngine() async {
    var engine = await _flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
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

    await _flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.speak(text);
  }
}
