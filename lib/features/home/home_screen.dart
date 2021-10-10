import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:infitness/base/base_state.dart';
import 'package:infitness/features/workoutlist/workout_list_cubit.dart';
import 'package:infitness/features/workoutlist/workout_list_screen.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/animated_indexed_stack.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends BaseState<HomeScreen> {
  int _currentTab = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return scaffoldSafe(
      child: Column(
        children: [
          Expanded(
            child: AnimatedIndexedStack(
              index: _currentTab,
              children: [
                Provider<WorkoutListCubit>(
                  create: (context) => WorkoutListCubit(),
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
        activeColor: AppColors.PRIMARY,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        onTap: (index) => setState(() => _currentTab = index),
      );

  Widget? _buildFab() {
    return _fab(Icons.add_rounded, () {});
  }

  Widget _fab(IconData icon, VoidCallback onPressed) => FloatingActionButton(
        backgroundColor: AppColors.SECONDARY,
        foregroundColor: Colors.white,
        child: Icon(icon),
        onPressed: onPressed,
      );
}
