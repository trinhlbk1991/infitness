import 'package:hive/hive.dart';
part 'workout.g.dart';

@HiveType(typeId : 0)
class Workout {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  Workout({
    required this.id,
    required this.name,
  });
}
