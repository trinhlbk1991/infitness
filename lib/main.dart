import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infitness/database/hive_utils.dart';
import 'package:infitness/database/settings_hive.dart';
import 'package:infitness/database/workout_hive.dart';
import 'package:infitness/infitness_app.dart';
import 'package:provider/provider.dart';

import 'model/exercise.dart';
import 'model/set.dart';
import 'model/workout.dart';
import 'theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(
        details.exception, details.stack ?? StackTrace.fromString('Unknown'));
  };

  await HiveUtils.init();
  _setupDummyWorkouts();
  final themeMode = SettingsHive().getThemeMode();

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) => ThemeNotifier(themeMode),
      child: InfitnessApp(),
    ),
  );
}

_setupDummyWorkouts() {
  final dummyWorkouts = [
    Workout(id: '1', name: 'Morning Yoga', sets: [
      Set(
        exercises: [
          Exercise(name: 'Right knee to chest', time: 60),
          Exercise(name: 'Left knee to chest', time: 60),
        ],
        repeat: 2,
      ),
      Set(
        exercises: [
          Exercise(name: 'Child\'s pose', time: 105),
          Exercise(name: 'Cat-cow', time: 45),
        ],
        repeat: 1,
      ),
      Set(
        exercises: [
          Exercise(name: 'Sphinx', rep: 100),
        ],
        repeat: 3,
      ),
    ]),
    Workout(id: '2', name: 'Lower Back Stretch', sets: [
      Set(
        exercises: [Exercise(name: 'Push up', rep: 10)],
        repeat: 2,
      ),
      Set(
        exercises: [Exercise(name: 'Pull up', rep: 10)],
        repeat: 2,
      ),
    ]),
    Workout(id: '3', name: 'Full Body Workout'),
  ];
  WorkoutHive().saveList(dummyWorkouts);
}
