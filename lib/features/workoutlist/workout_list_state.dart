import 'package:equatable/equatable.dart';
import 'package:infitness/model/workout.dart';

class WorkoutListState extends Equatable {
  final bool isLoading;
  final List<Workout> workouts;

  WorkoutListState({
    this.isLoading = false,
    this.workouts = const [],
  });

  @override
  List<Object?> get props => [isLoading, workouts];
}
