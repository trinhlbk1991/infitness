import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/database/settings_hive.dart';
import 'package:infitness/database/workout_hive.dart';

class HiveModule {
  HiveModule._();

  static final hives = [
    RepositoryProvider<SettingsHive>(
      create: (context) => SettingsHive(),
    ),
    RepositoryProvider<WorkoutHive>(
      create: (context) => WorkoutHive(),
    ),
  ];
}
