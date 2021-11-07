import 'package:equatable/equatable.dart';
import 'package:infitness/model/history.dart';
import 'package:infitness/model/workout.dart';

class WorkoutReportState extends Equatable {
  final bool isLoading;
  final List<History> histories;

  WorkoutReportState({
    this.isLoading = false,
    this.histories = const [],
  });

  @override
  List<Object?> get props => [isLoading, histories];
}
