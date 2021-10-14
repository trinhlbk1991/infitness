import 'package:infitness/database/hive_utils.dart';
import 'package:infitness/model/workout.dart';

class WorkoutHive {
  final _box = HiveUtils.boxWorkout();

  List<Workout> getAll() {
    return _box.values.toList().where((element) => !element.isDeleted).toList();
  }

  Workout? getById(String id) {
    final workout = _box.get(id);
    if (workout == null || workout.isDeleted) {
      return null;
    }
    return workout;
  }

  save(Workout workout) {
    _box.put(workout.id, workout);
  }

  saveList(List<Workout> workouts) {
    workouts.forEach((element) {
      save(element);
    });
  }

  delete(String id) {
    final workout = getById(id);
    if (workout != null) {
      save(workout.copyWith(isDeleted: true));
    }
  }
}
