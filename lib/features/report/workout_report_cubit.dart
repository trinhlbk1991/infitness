import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/database/history_hive.dart';
import 'package:infitness/database/workout_hive.dart';
import 'package:infitness/features/home/home_cubit.dart';
import 'package:infitness/features/home/home_state.dart';

import 'workout_report_state.dart';

class WorkoutReportCubit extends Cubit<WorkoutReportState> {
  HistoryHive _historyHive;
  HomeCubit _homeCubit;

  WorkoutReportCubit({
    required HistoryHive historyHive,
    required HomeCubit homeCubit,
  })  : _historyHive = historyHive,
        _homeCubit = homeCubit,
        super(WorkoutReportState(isLoading: false)) {
    _homeCubit.stream.listen((event) {
      if (event.action == HomeState.ACTION_RELOAD_REPORT) {
        loadWorkoutHistory();
      }
    });
  }

  loadWorkoutHistory() async {
    emit(WorkoutReportState(isLoading: true));
    final histories = _historyHive.getAll();
    histories.sort((a, b) => b.date - a.date);
    emit(WorkoutReportState(isLoading: false, histories: histories));
  }
}
