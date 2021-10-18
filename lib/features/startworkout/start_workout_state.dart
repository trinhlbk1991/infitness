import 'package:equatable/equatable.dart';
import 'package:infitness/features/startworkout/widgets/exercise_timer.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/model/workout.dart';

class StartWorkoutState extends Equatable {
  final Workout workout;
  final int currentSet;
  final int currentSetRepeat;
  final int currentExercise;
  final TimerState timerState;

  bool isFirstExercise() =>
      currentSet == 0 && currentExercise == 0 && currentSetRepeat == 0;

  bool canForward() => !(currentSet == workout.sets.length - 1 &&
      currentExercise == workout.sets[currentSet].exercises.length - 1 &&
      currentSetRepeat == workout.sets[currentSet].repeat - 1);

  bool canBackward() =>
      !(currentSet == 0 && currentExercise == 0 && currentSetRepeat == 0);

  Exercise getCurrentExercise() =>
      workout.sets[currentSet].exercises[currentExercise];

  StartWorkoutState({
    required this.workout,
    this.currentSet = 0,
    this.currentSetRepeat = 0,
    this.currentExercise = 0,
    this.timerState = TimerState.IDLE,
  });

  StartWorkoutState.fromState(StartWorkoutState state)
      : this(
          workout: state.workout,
          currentSet: state.currentSet,
          currentSetRepeat: state.currentSetRepeat,
          currentExercise: state.currentExercise,
          timerState: state.timerState,
        );

  @override
  List<Object?> get props => [
        workout,
        currentSet,
        currentSetRepeat,
        currentExercise,
        timerState,
      ];

  StartWorkoutState copyWith({
    Workout? workout,
    int? currentSet,
    int? currentSetRepeat,
    int? currentExercise,
    TimerState? timerState,
  }) =>
      StartWorkoutState(
        workout: workout ?? this.workout,
        currentSet: currentSet ?? this.currentSet,
        currentSetRepeat: currentSetRepeat ?? this.currentSetRepeat,
        currentExercise: currentExercise ?? this.currentExercise,
        timerState: timerState ?? this.timerState,
      );

  List<Exercise> getRemainingExercises() {
    final result = <Exercise>[];
    for (int setIndex = currentSet;
        setIndex < workout.sets.length;
        setIndex++) {
      final set = workout.sets[setIndex];
      int setRepeatIndex = (setIndex == currentSet) ? currentSetRepeat : 0;
      for (; setRepeatIndex < set.repeat; setRepeatIndex++) {
        int exerciseIndex =
            (setIndex == currentSet && setRepeatIndex == currentSetRepeat)
                ? currentExercise
                : 0;
        for (; exerciseIndex < set.exercises.length; exerciseIndex++) {
          result.add(set.exercises[exerciseIndex]);
        }
      }
    }
    return result;
  }
}

class StartWorkoutState_Init extends StartWorkoutState {
  StartWorkoutState_Init(Workout workout) : super(workout: workout);
}

class StartWorkoutState_Forward extends StartWorkoutState {
  StartWorkoutState_Forward(StartWorkoutState state) : super.fromState(state);
}

class StartWorkoutState_Backward extends StartWorkoutState {
  StartWorkoutState_Backward(StartWorkoutState state) : super.fromState(state);
}

class StartWorkoutState_Finished extends StartWorkoutState {
  StartWorkoutState_Finished(StartWorkoutState state) : super.fromState(state);
}
