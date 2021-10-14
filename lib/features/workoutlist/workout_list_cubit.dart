import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/database/workout_hive.dart';
import 'package:infitness/features/home/home_cubit.dart';
import 'package:infitness/features/home/home_state.dart';
import 'package:infitness/features/workoutlist/workout_list_state.dart';

class WorkoutListCubit extends Cubit<WorkoutListState> {
  WorkoutHive _workoutHive;
  HomeCubit _homeCubit;

  WorkoutListCubit({
    required WorkoutHive workoutHive,
    required HomeCubit homeCubit,
  })  : _workoutHive = workoutHive,
        _homeCubit = homeCubit,
        super(WorkoutListState(isLoading: false)) {
    _homeCubit.stream.listen((event) {
      if (event.action == HomeState.ACTION_RELOAD_WORKOUTS) {
        loadWorkouts();
      }
    });
  }

  loadWorkouts() async {
    emit(WorkoutListState(isLoading: true));

    final workouts = _workoutHive.getAll();
    emit(WorkoutListState(isLoading: false, workouts: workouts));
  }

  void deleteWorkout(String id) {
    _workoutHive.delete(id);
    loadWorkouts();
  }
}
