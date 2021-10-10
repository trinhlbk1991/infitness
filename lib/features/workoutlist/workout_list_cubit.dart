import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/features/workoutlist/workout_list_state.dart';

class WorkoutListCubit extends Cubit<WorkoutListState> {
  WorkoutListCubit() : super(WorkoutListState(isLoading: false));

  loadWorkouts() async {
    Future.delayed(Duration(milliseconds: 1)).then((value) {
      emit(WorkoutListState(isLoading: true));
    });

    Future.delayed(Duration(seconds: 2)).then((value) {
      emit(WorkoutListState(isLoading: false));
    });
  }
}
