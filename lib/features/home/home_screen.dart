import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/base/base_state.dart';
import 'package:infitness/features/home/home_cubit.dart';
import 'package:infitness/features/workoutlist/workout_list_cubit.dart';
import 'package:infitness/features/workoutlist/workout_list_screen.dart';
import 'package:infitness/navigation/infitness_navigator.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/animated_indexed_stack.dart';
import 'package:infitness/widgets/app_text.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key});

  @override
  State createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends BaseState<HomeScreen> {
  late HomeCubit _cubit;
  int _currentTab = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      child: Column(
        children: [
          Expanded(
            child: AnimatedIndexedStack(
              index: _currentTab,
              children: [
                BlocProvider<WorkoutListCubit>(
                  create: (context) => WorkoutListCubit(
                    workoutHive: RepositoryProvider.of(context),
                    homeCubit: _cubit,
                  ),
                  child: WorkoutListScreen(),
                ),
                Container(child: Center(child: AppText('Report'))),
                Container(child: Center(child: AppText('Community'))),
                Container(child: Center(child: AppText('Settings'))),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
      fab: _buildFab(),
    );
  }

  Widget _bottomBar() => AnimatedBottomNavigationBar(
        icons: [
          Icons.directions_run_rounded,
          Icons.bar_chart_rounded,
          Icons.people_outline_rounded,
          Icons.settings_rounded,
        ],
        activeIndex: _currentTab,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: AppRadius.BOTTOM_SHEET,
        rightCornerRadius: AppRadius.BOTTOM_SHEET,
        activeColor: secondaryColor(context),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        onTap: (index) => setState(() => _currentTab = index),
      );

  Widget? _buildFab() {
    return _fab(
      Icons.add_rounded,
      () => InfitnessNavigator.gotoAddWorkout(
        context,
        callback: () {
          _cubit.reloadWorkoutList();
        },
      ),
    );
  }

  Widget _fab(IconData icon, VoidCallback onPressed) => FloatingActionButton(
        backgroundColor: AppColors.SECONDARY,
        foregroundColor: Colors.white,
        child: Icon(icon),
        onPressed: onPressed,
      );
}
