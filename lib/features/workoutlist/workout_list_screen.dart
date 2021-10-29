import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/base/base_bloc_builder.dart';
import 'package:infitness/base/base_bloc_listener.dart';
import 'package:infitness/base/base_state.dart';
import 'package:infitness/features/workoutlist/workout_list_cubit.dart';
import 'package:infitness/features/workoutlist/workout_list_state.dart';
import 'package:infitness/navigation/infitness_navigator.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/alert_bottom_sheet.dart';
import 'package:infitness/widgets/app_text.dart';

import 'widgets/sliver_app_bar.dart';
import 'widgets/workout_card.dart';

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
    _cubit = BlocProvider.of(context);
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
      showLog: false,
      listener: _onStateChanged,
      child: BaseBlocBuilder<WorkoutListCubit, WorkoutListState>(
        showLog: false,
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              sliverAppBar(context),
            ],
            body: state.workouts.isEmpty ? _noWorkout() : _workoutList(state),
          );
        },
      ),
    );
  }

  Widget _noWorkout() {
    return Center(child: AppText('You don\'t have any workouts yet'));
  }

  ListView _workoutList(WorkoutListState state) {
    return ListView.builder(
      padding: EdgeInsets.all(Spacing.NORMAL),
      itemBuilder: (context, index) {
        return WorkoutCard(
          workout: state.workouts[index],
          onStart: (workout) =>
              InfitnessNavigator.gotoStartWorkout(context, workout: workout),
          onEdit: (workout) {
            InfitnessNavigator.gotoAddWorkout(
              context,
              workout: workout,
              callback: () {
                _cubit.loadWorkouts();
              },
            );
          },
          onDelete: (workout) {
            showAlertBottomSheet(
              context,
              title: 'Delete Workout',
              message: 'Do you want to delete ${workout.name}?',
              positiveText: 'Delete',
              positiveStyle: PositiveStyle.primaryRed,
              positiveClicked: () {
                _cubit.deleteWorkout(workout.id);
              },
            );
          },
        );
      },
      itemCount: state.workouts.length,
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
