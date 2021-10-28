import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/features/startworkout/widgets/exercise_timer.dart';
import 'package:infitness/model/workout.dart';
import 'package:infitness/utils/log.dart';

import 'start_workout_state.dart';

class StartWorkoutCubit extends Cubit<StartWorkoutState> {
  StartWorkoutCubit() : super(StartWorkoutState(workout: Workout()));

  void init(Workout workout) {
    emit(StartWorkoutState_Init(workout));
  }

  void startExercise() {
    emit(state.copyWith(timerState: TimerState.PLAYING));
  }

  void pauseExercise() {
    emit(state.copyWith(timerState: TimerState.PAUSED));
  }

  void resumeExercise() {
    emit(state.copyWith(timerState: TimerState.PLAYING));
  }

  void nextExercise() {
    final set = state.workout.sets[state.currentSet];
    if (state.currentExercise + 1 < set.exercises.length) {
      // Move to next exercise of same set
      final newState = state.copyWith(
        currentExercise: state.currentExercise + 1,
      );
      emit(StartWorkoutState_Forward(newState));
    } else if (state.currentSetRepeat + 1 < set.repeat) {
      // Move to next repeat of same set
      final newState = state.copyWith(
        currentSetRepeat: state.currentSetRepeat + 1,
        currentExercise: 0,
      );
      emit(StartWorkoutState_Forward(newState));
    } else if (state.currentSet + 1 < state.workout.sets.length) {
      // Move to next set
      Log.i('KAIIIIII', 'Move to next set: ${state.workout.sets.length}, ${state.currentSet}');
      final newState = state.copyWith(
        currentSet: state.currentSet + 1,
        currentSetRepeat: 0,
        currentExercise: 0,
      );
      emit(StartWorkoutState_Forward(newState));
    } else {
      emit(StartWorkoutState_Finished(state));
    }
  }

  previousExercise() {
    final set = state.workout.sets[state.currentSet];
    if (state.currentExercise - 1 >= 0) {
      // Move to previous exercise of same set
      final newState = state.copyWith(
        currentExercise: state.currentExercise - 1,
      );
      emit(StartWorkoutState_Backward(newState));
    } else if (state.currentSetRepeat - 1 >= 0) {
      // Move to previous repeat of same set
      final newState = state.copyWith(
        currentSetRepeat: state.currentSetRepeat - 1,
        currentExercise: set.exercises.length - 1,
      );
      emit(StartWorkoutState_Backward(newState));
    } else if (state.currentSet - 1 >= 0) {
      // Move to previous set
      final previousSet = state.workout.sets[state.currentSet - 1];
      final newState = state.copyWith(
        currentSet: state.currentSet - 1,
        currentSetRepeat: previousSet.repeat - 1,
        currentExercise: previousSet.exercises.length - 1,
      );
      emit(StartWorkoutState_Backward(newState));
    }
  }
}
