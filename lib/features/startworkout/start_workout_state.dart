import 'package:equatable/equatable.dart';
import 'package:infitness/features/startworkout/widgets/exercise_timer.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/model/workout.dart';
import 'package:infitness/utils/log.dart';

class StartWorkoutState extends Equatable {
  final Workout workout;
  final int exerciseIndex;
  final TimerState timerState;

  final List<Exercise> exercises = [];

  bool isFirstExercise() => exerciseIndex == 0;

  bool canForward() => exerciseIndex + 1 < exercises.length;

  bool canBackward() => exerciseIndex > 0;

  Exercise getCurrentExercise() => exercises[exerciseIndex];

  StartWorkoutState({
    required this.workout,
    this.exerciseIndex = 0,
    this.timerState = TimerState.IDLE,
  }) {
    exercises.clear();
    workout.sets.forEach((set) {
      for (int repeat = 0; repeat < set.repeat; repeat++) {
        for (int i = 0; i < set.exercises.length; i++) {
          exercises.add(set.exercises[i]);
          if (workout.restExercise > 0 && i < set.exercises.length - 1) {
            exercises.add(Rest(workout.restExercise));
          }
        }
        if (workout.restSet > 0) {
          exercises.add(Rest(workout.restSet));
        }
      }
    });
  }

  StartWorkoutState.fromState(StartWorkoutState state)
      : this(
          workout: state.workout,
          timerState: state.timerState,
          exerciseIndex: state.exerciseIndex,
        );

  @override
  List<Object?> get props => [workout, timerState, exerciseIndex];

  StartWorkoutState copyWith({
    Workout? workout,
    int? exerciseIndex,
    TimerState? timerState,
  }) =>
      StartWorkoutState(
        workout: workout ?? this.workout,
        exerciseIndex: exerciseIndex ?? this.exerciseIndex,
        timerState: timerState ?? this.timerState,
      );

  List<Exercise> getRemainingExercises() {
    final result = <Exercise>[];
    for (int index = exerciseIndex + 1; index < exercises.length; index++) {
      result.add(exercises[index]);
    }
    return result;
  }

  @override
  String toString() {
    return 'StartWorkoutState{}';
  }
}

class StartWorkoutState_Init extends StartWorkoutState {
  StartWorkoutState_Init(Workout workout) : super(workout: workout);

  @override
  String toString() {
    return 'StartWorkoutState_Init{}';
  }
}

class StartWorkoutState_Forward extends StartWorkoutState {
  StartWorkoutState_Forward(StartWorkoutState state) : super.fromState(state);

  @override
  String toString() {
    return 'StartWorkoutState_Forward{}';
  }
}

class StartWorkoutState_Backward extends StartWorkoutState {
  StartWorkoutState_Backward(StartWorkoutState state) : super.fromState(state);

  @override
  String toString() {
    return 'StartWorkoutState_Backward{}';
  }
}

class StartWorkoutState_Finished extends StartWorkoutState {
  StartWorkoutState_Finished(StartWorkoutState state) : super.fromState(state);
}
