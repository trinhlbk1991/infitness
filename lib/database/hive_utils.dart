import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveUtils {
  HiveUtils._();

  static const String BOX_SETTINGS = 'settings';
  static const String BOX_WORKOUT = 'workout';

  static init() async {
    await Hive.initFlutter();
    await Hive.openBox(BOX_SETTINGS);
    await Hive.openBox(BOX_WORKOUT);
  }

  static boxSettings() => Hive.box(BOX_SETTINGS);

  static boxWorkout() => Hive.box(BOX_WORKOUT);
}
