import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/database/workout_hive.dart';
import 'package:infitness/features/workoutlist/workout_list_state.dart';

class WorkoutListCubit extends Cubit<WorkoutListState> {
  WorkoutHive _workoutHive;

  WorkoutListCubit({required WorkoutHive workoutHive})
      : _workoutHive = workoutHive,
        super(WorkoutListState(isLoading: false));

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
