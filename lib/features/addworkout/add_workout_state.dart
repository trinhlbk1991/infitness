import 'package:equatable/equatable.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/model/workout.dart';
import 'package:uuid/uuid.dart';

class AddWorkoutState extends Equatable {
  final bool isAddMode;
  final String? workoutId;
  final List<Set> sets;
  final int restSet;
  final int restExercise;

  AddWorkoutState({
    this.isAddMode = true,
    this.workoutId,
    this.sets = const [],
    this.restExercise = 30,
    this.restSet = 60,
  });

  AddWorkoutState.fromState({
    required AddWorkoutState state,
    bool? isAddMode,
    String? workoutId,
    List<Set>? sets,
    int? restSet,
    int? restExercise,
  }) : this(
          isAddMode: isAddMode ?? state.isAddMode,
          workoutId: workoutId ?? state.workoutId,
          sets: sets ?? state.sets,
          restSet: restSet ?? state.restSet,
          restExercise: restExercise ?? state.restExercise,
        );

  @override
  List<Object?> get props =>
      [isAddMode, workoutId, sets, restSet, restExercise];
}

class AddWorkout_SaveSuccess extends AddWorkoutState {
  AddWorkout_SaveSuccess(AddWorkoutState state)
      : super(
          isAddMode: state.isAddMode,
          workoutId: state.workoutId,
          sets: state.sets,
          restSet: state.restSet,
          restExercise: state.restExercise,
        );

  @override
  String toString() {
    return 'AddWorkout_SaveSuccess{}';
  }
}

class AddWorkout_ShowGuide extends AddWorkoutState {
  AddWorkout_ShowGuide(AddWorkoutState state)
      : super(
          isAddMode: state.isAddMode,
          workoutId: state.workoutId,
          sets: state.sets,
          restSet: state.restSet,
          restExercise: state.restExercise,
        );

  @override
  String toString() {
    return 'AddWorkout_ShowGuide{}';
  }
}
