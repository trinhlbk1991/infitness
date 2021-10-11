import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/features/workoutlist/workout_list_state.dart';

class WorkoutListCubit extends Cubit<WorkoutListState> {
  WorkoutListCubit() : super(WorkoutListState(isLoading: false));

  loadWorkouts() async {
    // This looks stupid but without the delay, this state won't be emitted
    Future.delayed(Duration(milliseconds: 1)).then((value) {
      emit(WorkoutListState(isLoading: true));
    });


  }
}
