import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/features/addworkout/add_workout_cubit.dart';
import 'package:infitness/features/addworkout/add_workout_screen.dart';
import 'package:infitness/features/home/home_cubit.dart';
import 'package:infitness/features/home/home_screen.dart';
import 'package:infitness/features/startworkout/start_workout_cubit.dart';
import 'package:infitness/features/startworkout/start_workout_screen.dart';
import 'package:infitness/navigation/infitness_navigator.dart';
import 'package:infitness/navigation/route_settings_extensions.dart';

homeScreen(BuildContext context, RouteSettings settings) {
  return BlocProvider(
    create: (context) => HomeCubit(),
    child: HomeScreen(),
  );
}

addWorkoutScreen(BuildContext context, RouteSettings settings) {
  final workout = settings.getObjectArg(InfitnessNavigator.ARG_WORKOUT);
  return BlocProvider(
    create: (context) => AddWorkoutCubit(
      workoutHive: RepositoryProvider.of(context),
    ),
    child: AddWorkoutScreen(workout: workout),
  );
}

startWorkoutScreen(BuildContext context, RouteSettings settings) {
  final workout = settings.getObjectArg(InfitnessNavigator.ARG_WORKOUT);
  return BlocProvider(
    create: (context) => StartWorkoutCubit(),
    child: StartWorkoutScreen(workout: workout),
  );
}
