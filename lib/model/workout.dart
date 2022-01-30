import 'package:hive/hive.dart';
import 'package:infitness/model/set.dart';

part 'workout.g.dart';

@HiveType(typeId: 0)
class Workout {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<Set> sets;

  @HiveField(3)
  final bool isDeleted;

  @HiveField(4)
  final int createdAt;

  @HiveField(5)
  final int updatedAt;

  Workout({
    this.id = '',
    this.name = '',
    this.sets = const [],
    this.isDeleted = false,
    this.createdAt = 0,
    this.updatedAt = 0,
  });

  Workout copyWith({
    String? id,
    String? name,
    List<Set>? sets,
    bool? isDeleted,
    int? createdAt,
    int? updatedAt,
    int? restSet,
    int? restExercise,
  }) =>
      Workout(
        id: id ?? this.id,
        name: name ?? this.name,
        sets: sets ?? this.sets,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  String toString() {
    return 'Workout{id: $id, name: $name, sets: ${sets.length}';
  }

  int estTime() {
    var time = 0;
    sets.forEach((set) {
      final setTime = set.exercises.fold(
        0,
        (prev, element) =>
            (prev as int) + element.time + element.rep * element.repTime,
      );
      time += setTime * set.repeat;
    });
    return time;
  }
}
