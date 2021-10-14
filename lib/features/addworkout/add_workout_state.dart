import 'package:equatable/equatable.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/model/workout.dart';

class AddWorkoutState extends Equatable {
  final bool isAddMode;
  final String? workoutId;
  final List<Set> sets;

  AddWorkoutState({
    this.isAddMode = true,
    this.workoutId,
    this.sets = const [],
  });

  AddWorkoutState.fromState({
    required AddWorkoutState state,
    bool? isAddMode,
    String? workoutId,
    List<Set>? sets,
  }) : this(
          isAddMode: isAddMode ?? state.isAddMode,
          workoutId: workoutId ?? state.workoutId,
          sets: sets ?? state.sets,
        );

  @override
  List<Object?> get props => [isAddMode, workoutId, sets];
}

class AddWorkout_SaveSuccess extends AddWorkoutState {
  AddWorkout_SaveSuccess(AddWorkoutState state)
      : super(
          isAddMode: state.isAddMode,
          workoutId: state.workoutId,
          sets: state.sets,
        );
}
