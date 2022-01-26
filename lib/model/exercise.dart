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

  @HiveField(4)
  final int repTime;

  @HiveField(3)
  final int index;

  Exercise({
    required this.name,
    this.time = 0,
    this.rep = 0,
    this.repTime = 0,
    this.index = 0,
  });

  Exercise copyWith({
    String? name,
    int? time,
    int? rep,
    int? repTime,
    int? index,
  }) =>
      Exercise(
        name: name ?? this.name,
        time: time ?? this.time,
        rep: rep ?? this.rep,
        repTime: repTime ?? this.repTime,
        index: index ?? this.index,
      );

  @override
  String toString() {
    return 'Exercise{name: $name, time: $time, rep: $rep, repTime: $repTime, index: $index}';
  }

  bool isRest() => this is Rest || this.name == 'Rest';
}

class Rest extends Exercise {
  Rest(int time) : super(name: 'Rest', time: time);
}
