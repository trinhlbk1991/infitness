import 'package:hive_flutter/hive_flutter.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/model/history.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/model/workout.dart';

class HiveUtils {
  HiveUtils._();

  static const String BOX_SETTINGS = 'settings';
  static const String BOX_GUIDE = 'guide';
  static const String BOX_WORKOUT = 'workout';
  static const String BOX_HISTORY = 'history';
  static const String BOX_TEMPLATE_EXERCISE = 'template_exercise';

  static init() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Exercise>(ExerciseAdapter());
    Hive.registerAdapter<Set>(SetAdapter());
    Hive.registerAdapter<Workout>(WorkoutAdapter());
    Hive.registerAdapter<History>(HistoryAdapter());

    await Hive.openBox(BOX_SETTINGS);
    await Hive.openBox(BOX_GUIDE);
    await Hive.openBox<Workout>(BOX_WORKOUT);
    await Hive.openBox<History>(BOX_HISTORY);
    await Hive.openBox<Set>(BOX_TEMPLATE_EXERCISE);
  }

  static Box boxSettings() => Hive.box(BOX_SETTINGS);

  static Box boxGuide() => Hive.box(BOX_GUIDE);

  static Box<Workout> boxWorkout() => Hive.box<Workout>(BOX_WORKOUT);

  static Box<History> boxHistory() => Hive.box<History>(BOX_HISTORY);

  static Box<Set> boxTemplateExercise() => Hive.box<Set>(BOX_TEMPLATE_EXERCISE);
}
