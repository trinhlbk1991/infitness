import 'package:hive/hive.dart';
part 'exercise.g.dart';

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int time;

  @HiveField(2)
  final int rep;

  @HiveField(3)
  final int repeat;

  Exercise({
    required this.name,
    this.time = 0,
    this.rep = 0,
    this.repeat = 1,
  });
}
