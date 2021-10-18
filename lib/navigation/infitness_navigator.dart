import 'package:flutter/cupertino.dart';
import 'package:infitness/model/workout.dart';

class InfitnessNavigator {
  static const String HOME = '/';
  static const String ADD_WORKOUT = '/add-workout';
  static const String START_WORKOUT = '/start-workout';

  static const String ARG_WORKOUT = 'arg-workout';

  InfitnessNavigator._();

  static gotoHome(BuildContext context) {
    Navigator.popAndPushNamed(context, HOME);
  }

  static gotoAddWorkout(
    BuildContext context, {
    Workout? workout,
    Function? callback,
  }) {
    Navigator.pushNamed(
      context,
      ADD_WORKOUT,
      arguments: {ARG_WORKOUT: workout},
    ).then((value) => callback?.call());
  }

  static gotoStartWorkout(
    BuildContext context, {
    Workout? workout,
    Function? callback,
  }) {
    Navigator.pushNamed(
      context,
      START_WORKOUT,
      arguments: {ARG_WORKOUT: workout},
    ).then((value) => callback?.call());
  }
}
