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
  final int index;

  Exercise({
    required this.name,
    this.time = 0,
    this.rep = 0,
    this.index = 0,
  });

  Exercise copyWith({
    String? name,
    int? time,
    int? rep,
    int? index,
  }) =>
      Exercise(
        name: name ?? this.name,
        time: time ?? this.time,
        rep: rep ?? this.rep,
        index: index ?? this.index,
      );

  @override
  String toString() {
    return 'Exercise{name: $name, time: $time, rep: $rep, index: $index}';
  }
}
