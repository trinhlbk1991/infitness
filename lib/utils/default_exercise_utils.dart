// ignore_for_file: non_constant_identifier_names

import 'package:infitness/model/exercise.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/model/workout.dart';

final DEFAULT_WARM_UP = Workout(
  id: '1_warm_up',
  name: "Warm Up",
  sets: [
    Set(
      name: 'Warm Up',
      exercises: [
        Exercise(name: 'Skipping Rope', time: 90),
        Exercise(name: 'Arm Circles', time: 40),
        Exercise(name: 'Jumping Jack', time: 45),
        Exercise(name: 'Lunges and Twist', time: 45),
        Exercise(name: 'Squat', time: 45),
      ],
    )
  ],
);

final DEFAULT_COOL_DOWN = Workout(
  id: '2_cool_down',
  name: 'Cool Down',
  sets: [
    Set(
      name: 'Cool Down',
      exercises: [
        Exercise(name: 'Neck Stretch', time: 30),
        Exercise(name: 'Triceps Stretch', time: 30),
        Exercise(name: 'Quad Stretch', time: 30),
        Exercise(name: 'Pelvic Stretch', time: 30),
        Exercise(name: 'Child Pose', time: 30),
        Exercise(name: 'Cat and Cow', time: 30),
        Exercise(name: 'Pigeon Stretch Left', time: 30),
        Exercise(name: 'Pigeon Stretch Right', time: 30),
        Exercise(name: 'Glute and Lumbar Rotation Stretch Left', time: 30),
        Exercise(name: 'Glute and Lumbar Rotation Stretch Right', time: 30),
        Exercise(name: 'Spiral Twist Left', time: 30),
        Exercise(name: 'Spiral Twist Right', time: 30),
      ],
    ),
  ],
);
