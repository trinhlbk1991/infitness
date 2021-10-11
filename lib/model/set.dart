import 'package:hive/hive.dart';
import 'package:infitness/model/exercise.dart';
part 'set.g.dart';

@HiveType(typeId: 2)
class Set {
  @HiveField(0)
  final List<Exercise> exercises;

  @HiveField(1)
  final int repeat;

  Set({this.exercises = const [], this.repeat = 1});
}
