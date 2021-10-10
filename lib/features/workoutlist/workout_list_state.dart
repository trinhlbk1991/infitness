import 'package:equatable/equatable.dart';

class WorkoutListState extends Equatable {
  final bool isLoading;

  WorkoutListState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];
}
