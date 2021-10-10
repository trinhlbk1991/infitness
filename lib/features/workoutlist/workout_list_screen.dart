import 'package:flutter/material.dart';
import 'package:infitness/base/base_bloc_builder.dart';
import 'package:infitness/base/base_bloc_listener.dart';
import 'package:infitness/base/base_state.dart';
import 'package:infitness/features/workoutlist/workout_list_cubit.dart';
import 'package:infitness/features/workoutlist/workout_list_state.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:provider/provider.dart';

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({Key? key}) : super(key: key);

  @override
  _WorkoutListScreenState createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends BaseState<WorkoutListScreen> {
  late WorkoutListCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = Provider.of(context);
    _cubit.loadWorkouts();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocListener<WorkoutListCubit, WorkoutListState>(
      showLog: true,
      listener: _onStateChanged,
      child: BaseBlocBuilder<WorkoutListCubit, WorkoutListState>(
        showLog: true,
        builder: (context, state) {
          return Container(
            child: Center(child: AppText('Workout List')),
          );
        },
      ),
    );
  }

  void _onStateChanged(BuildContext context, WorkoutListState state) {
    if (state.isLoading) {
      showProgress(context, message: 'Loading workout list...');
    } else {
      dismissProgress();
    }
  }
}
