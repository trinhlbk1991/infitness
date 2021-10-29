import 'package:infitness/database/hive_utils.dart';
import 'package:infitness/model/workout.dart';
import 'package:infitness/utils/date_time_utils.dart';

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
    final existedWorkout = getById(workout.id);
    final createdAt =
        existedWorkout?.createdAt ?? DateTimeUtils.currentTimeUtc();
    final updatedAt = DateTimeUtils.currentTimeUtc();
    _box.put(
      workout.id,
      workout.copyWith(
        createdAt: createdAt,
        updatedAt: updatedAt,
      ),
    );
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
