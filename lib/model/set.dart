import 'package:hive/hive.dart';
import 'package:infitness/model/exercise.dart';

part 'set.g.dart';

@HiveType(typeId: 2)
class Set {
  @HiveField(0)
  final List<Exercise> exercises;

  @HiveField(1)
  final int repeat;

  @HiveField(2)
  final int index;

  Set({
    this.exercises = const [],
    this.repeat = 1,
    this.index = 0,
  });

  Set copyWith({
    List<Exercise>? exercises,
    int? repeat,
    int? index,
  }) =>
      Set(
        exercises: exercises ?? this.exercises,
        repeat: repeat ?? this.repeat,
        index: index ?? this.index,
      );

  @override
  String toString() {
    return 'Set{index: $index, exercises: $exercises, repeat: $repeat}';
  }
}
