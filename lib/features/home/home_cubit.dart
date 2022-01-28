// ignore_for_file: unused_import

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/database/workout_hive.dart';
import 'package:infitness/features/home/home_state.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/utils/default_exercise_utils.dart';

class HomeCubit extends Cubit<HomeState> {
  WorkoutHive _workoutHive;

  HomeCubit({
    required WorkoutHive workoutHive,
  })  : _workoutHive = workoutHive,
        super(HomeState(''));

  reloadWorkoutList() {
    emit(HomeState(HomeState.ACTION_RELOAD_WORKOUTS));
  }

  reloadWorkoutReport() {
    emit(HomeState(HomeState.ACTION_RELOAD_REPORT));
  }

  initTemplateExercises() {
    if (_workoutHive.getAll().isNotEmpty) {
      return;
    }

    _workoutHive.save(DEFAULT_WARM_UP);
    _workoutHive.save(DEFAULT_COOL_DOWN);
  }
}
