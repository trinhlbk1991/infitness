import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/database/workout_hive.dart';
import 'package:infitness/features/addworkout/add_workout_state.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/model/workout.dart';
import 'package:uuid/uuid.dart';

class AddWorkoutCubit extends Cubit<AddWorkoutState> {
  WorkoutHive _workoutHive;

  AddWorkoutCubit({required WorkoutHive workoutHive})
      : _workoutHive = workoutHive,
        super(AddWorkoutState());

  init(Workout? workout) {
    if (state.workoutId != null) {
      return;
    }

    emit(AddWorkoutState(
      isAddMode: workout == null,
      workoutId: workout?.id ?? Uuid().v1(),
      sets: workout?.sets ?? [Set()],
    ));
  }

  updateRepeat(int setIndex, int repeat) {
    final newSet = state.sets[setIndex].copyWith(repeat: repeat);
    final newSets = state.sets.toList();
    newSets.removeAt(setIndex);
    newSets.insert(setIndex, newSet);

    emit(AddWorkoutState.fromState(state: state, sets: newSets));
  }

  addNewSet() {
    final newSets = state.sets.toList();
    newSets.add(Set(index: newSets.length));

    emit(AddWorkoutState.fromState(state: state, sets: newSets));
  }

  deleteSet(Set set) {
    final newSets = state.sets.toList();
    newSets.remove(set);
    emit(AddWorkoutState.fromState(state: state, sets: newSets));
  }

  void addExercise(int setIndex, Exercise exercise) {
    final newExercises = state.sets[setIndex].exercises.toList();
    newExercises.add(exercise);

    final newSet = state.sets[setIndex].copyWith(exercises: newExercises);
    final newSets = state.sets.toList();
    newSets.removeAt(setIndex);
    newSets.insert(setIndex, newSet);

    emit(AddWorkoutState.fromState(state: state, sets: newSets));
  }

  void updateExercise(int setIndex, int exerciseIndex, Exercise exercise) {
    final newExercises = state.sets[setIndex].exercises.toList();
    newExercises.removeAt(exerciseIndex);
    newExercises.insert(exerciseIndex, exercise);

    final newSet = state.sets[setIndex].copyWith(exercises: newExercises);
    final newSets = state.sets.toList();
    newSets.removeAt(setIndex);
    newSets.insert(setIndex, newSet);

    emit(AddWorkoutState.fromState(state: state, sets: newSets));
  }

  void deleteExercise(int setIndex, int exerciseIndex) {
    final newExercises = state.sets[setIndex].exercises.toList();
    newExercises.removeAt(exerciseIndex);

    final newSet = state.sets[setIndex].copyWith(exercises: newExercises);
    final newSets = state.sets.toList();
    newSets.removeAt(setIndex);
    newSets.insert(setIndex, newSet);

    emit(AddWorkoutState.fromState(state: state, sets: newSets));
  }

  void saveWorkout(String name) {
    final sets =
        state.sets.where((element) => element.exercises.isNotEmpty).toList();
    final workout = Workout(
      id: state.workoutId ?? Uuid().v1(),
      name: name,
      sets: sets,
    );
    _workoutHive.save(workout);

    emit(AddWorkout_SaveSuccess(state));
  }

  updateRestSet(int value) {
    emit(AddWorkoutState.fromState(state: state, restSet: value));
  }

  updateRestExercise(int value) {
    emit(AddWorkoutState.fromState(state: state, restExercise: value));
  }
}
