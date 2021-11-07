import 'package:hive/hive.dart';
import 'package:infitness/model/workout.dart';

part 'history.g.dart';

@HiveType(typeId: 3)
class History {
  @HiveField(0)
  final Workout workout;

  @HiveField(1)
  final int date;

  History({required this.workout, required this.date});

  History copyWith({
    Workout? workout,
    int? date,
  }) =>
      History(
        workout: workout ?? this.workout,
        date: date ?? this.date,
      );

  DateTime getDate() => DateTime.fromMillisecondsSinceEpoch(date);

  @override
  String toString() {
    return 'History{workout: ${workout.name}, date: $date}';
  }
}
