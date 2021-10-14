import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/database/workout_hive.dart';
import 'package:infitness/features/home/home_state.dart';
import 'package:infitness/features/workoutlist/workout_list_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(''));

  reloadWorkoutList() {
    emit(HomeState(HomeState.ACTION_RELOAD_WORKOUTS));
  }
}
