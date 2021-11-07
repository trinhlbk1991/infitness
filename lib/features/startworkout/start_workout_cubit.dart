import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/database/history_hive.dart';
import 'package:infitness/features/startworkout/widgets/exercise_timer.dart';
import 'package:infitness/model/history.dart';
import 'package:infitness/model/workout.dart';
import 'package:infitness/utils/date_time_utils.dart';

import 'start_workout_state.dart';

class StartWorkoutCubit extends Cubit<StartWorkoutState> {
  HistoryHive _historyHive;

  StartWorkoutCubit({
    required HistoryHive historyHive,
  })  : _historyHive = historyHive,
        super(StartWorkoutState(workout: Workout()));

  void init(Workout workout) {
    if (state.workout.id.isEmpty) {
      // Only emit init state on the first time, skip the rest!
      emit(StartWorkoutState_Init(workout));
    }
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
    if (state.exerciseIndex + 1 < state.exercises.length) {
      final newState = state.copyWith(
        exerciseIndex: state.exerciseIndex + 1,
      );
      emit(StartWorkoutState_Forward(newState));
    } else {
      emit(StartWorkoutState_Finished(state));
    }
  }

  previousExercise() {
    if (state.exerciseIndex - 1 >= 0) {
      final newState = state.copyWith(
        exerciseIndex: state.exerciseIndex - 1,
      );
      emit(StartWorkoutState_Backward(newState));
    }
  }

  void saveWorkoutHistory() {
    final history = History(
      workout: state.workout,
      date: DateTimeUtils.currentTimeUtc(),
    );
    _historyHive.save(history);
  }
}
