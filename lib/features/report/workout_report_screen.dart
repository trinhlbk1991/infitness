import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/base/base_bloc_builder.dart';
import 'package:infitness/base/base_bloc_listener.dart';
import 'package:infitness/base/base_state.dart';
import 'package:infitness/features/report/widgets/history_card.dart';
import 'package:infitness/model/history.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/app_bar.dart';
import 'package:infitness/widgets/app_text.dart';

import 'workout_report_cubit.dart';
import 'workout_report_state.dart';

class WorkoutReportScreen extends StatefulWidget {
  const WorkoutReportScreen({Key? key}) : super(key: key);

  @override
  _WorkoutReportScreenState createState() => _WorkoutReportScreenState();
}

class _WorkoutReportScreenState extends BaseState<WorkoutReportScreen> {
  late WorkoutReportCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = BlocProvider.of(context);
    _cubit.loadWorkoutHistory();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocListener<WorkoutReportCubit, WorkoutReportState>(
      showLog: false,
      listener: _onStateChanged,
      child: BaseBlocBuilder<WorkoutReportCubit, WorkoutReportState>(
        showLog: false,
        builder: (context, state) {
          return Column(
            children: [
              appBar(context, 'History', showBackIcon: false),
              Expanded(
                  child: state.histories.isEmpty
                      ? _emptyHistory()
                      : _histories(state.histories)),
            ],
          );
        },
      ),
    );
  }

  Widget _emptyHistory() {
    return Center(child: AppText('You don\'t have any workout histories yet'));
  }

  Widget _histories(List<History> histories) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final history = histories[index];
        return HistoryCard(history: history);
      },
      padding: EdgeInsets.all(Spacing.NORMAL),
      itemCount: histories.length,
    );
  }

  void _onStateChanged(BuildContext context, WorkoutReportState state) {
    if (state.isLoading) {
      showProgress(context, message: 'Loading workout histories...');
    } else {
      dismissProgress();
    }
  }
}
