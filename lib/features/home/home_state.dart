import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class HomeState extends Equatable {
  static const String ACTION_RELOAD_WORKOUTS = 'RELOAD_WORKOUTS';
  static const String ACTION_RELOAD_REPORT = 'RELOAD_REPORT';

  final String action;

  HomeState(this.action);

  @override
  List<Object?> get props => [Uuid().v1()];
}
