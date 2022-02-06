import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/base/base_bloc_builder.dart';
import 'package:infitness/base/base_bloc_listener.dart';
import 'package:infitness/base/base_state.dart';
import 'package:infitness/features/addworkout/add_workout_cubit.dart';
import 'package:infitness/features/addworkout/widgets/add_exercise_dialog.dart';
import 'package:infitness/features/addworkout/widgets/add_rest_dialog.dart';
import 'package:infitness/features/addworkout/widgets/confirm_delete_set_dialog.dart';
import 'package:infitness/features/addworkout/widgets/rest_set_card.dart';
import 'package:infitness/features/addworkout/widgets/set_card.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/model/workout.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/app_bar.dart';
import 'package:infitness/widgets/buttons/app_buttons.dart';
import 'package:infitness/widgets/column_builder.dart';
import 'package:infitness/widgets/edit_text.dart';
import 'package:infitness/widgets/space.dart';
import 'package:infitness/widgets/top_rounded_corner_card.dart';

import 'add_workout_state.dart';
import 'widgets/add_workout_buttons.dart';

class AddWorkoutScreen extends StatefulWidget {
  final Workout? workout;

  const AddWorkoutScreen({Key? key, this.workout}) : super(key: key);

  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends BaseState<AddWorkoutScreen> {
  late AddWorkoutCubit _cubit;

  final _formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameTextController.text = widget.workout?.name ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = BlocProvider.of(context);
    _cubit.init(widget.workout);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocListener<AddWorkoutCubit, AddWorkoutState>(
      showLog: true,
      listener: _onStateChanged,
      child: BaseBlocBuilder<AddWorkoutCubit, AddWorkoutState>(
        showLog: true,
        builder: (context, state) {
          return scaffoldSafe(
            child: Column(
              children: [
                appBar(
                  context,
                  state.isAddMode ? 'Add Workout' : 'Edit Workout',
                ),
                Expanded(child: _addWorkoutForm(state)),
                _btnSave(),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onStateChanged(BuildContext context, AddWorkoutState state) {
    if (state is AddWorkout_SaveSuccess) {
      Navigator.of(context).pop();
    } else if (state is AddWorkout_ShowGuide) {
      showInfo(context, 'Slide the card set for more options', duration: 5);
    }
  }

  Form _addWorkoutForm(AddWorkoutState state) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.NORMAL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _editTextName(),
            Space(),
            _workoutSets(state.sets),
            Space(),
            Row(
              children: [
                btnAddRest(context, onTap: () {
                  showAddRestDialog(context, onSave: (rest) {
                    if (rest.time > 0) {
                      _cubit.addRestSet(rest.time);
                    }
                  });
                }),
                Space(),
                btnAddSet(context, onTap: () {
                  FocusScope.of(context).unfocus();
                  _cubit.addNewSet();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _workoutSets(List<Set> sets) {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        final set = sets[index];

        if (set.isRestSet()) {
          return RestSetCard(
            index: index,
            set: set,
            margin: EdgeInsets.only(bottom: Spacing.NORMAL),
            onDeleteSet: (set) {
              showConfirmDeleteSetDialog(context, () => _cubit.deleteSet(set));
            },
            onEditSet: (set) {
              final index = sets.indexOf(set);
              showAddRestDialog(
                context,
                time: set.exercises.first.time,
                onSave: (rest) {
                  if (rest.time > 0) {
                    final newSet = Set(index: index, exercises: [rest]);
                    _cubit.updateSet(index, newSet);
                  }
                },
              );
            },
          );
        }

        return SetCard(
          index: index,
          set: set,
          margin: EdgeInsets.only(bottom: Spacing.NORMAL),
          onRepeatChanged: (repeat) {
            FocusScope.of(context).unfocus();
            _cubit.updateRepeat(index, repeat);
          },
          onAddExercise: (set) {
            showAddExerciseDialog(context, onSave: (exercise) {
              _cubit.addExercise(
                index,
                exercise.copyWith(index: set.exercises.length),
              );
            });
          },
          onAddRest: (set) {
            showAddRestDialog(context, onSave: (rest) {
              if (rest.time > 0) {
                _cubit.addExercise(
                  index,
                  rest.copyWith(index: set.exercises.length),
                );
              }
            });
          },
          onDeleteExercise: (exerciseIndex) {
            FocusScope.of(context).unfocus();
            _cubit.deleteExercise(index, exerciseIndex);
          },
          onEditExercise: (pair) {
            FocusScope.of(context).unfocus();
            showAddExerciseDialog(
              context,
              exercise: pair.item2,
              onSave: (value) =>
                  _cubit.updateExercise(index, pair.item1, value),
            );
          },
          onDeleteSet: (value) {
            showConfirmDeleteSetDialog(context, () => _cubit.deleteSet(value));
          },
          onEditSet: (value) {
            final index = sets.indexOf(set);
            _cubit.updateSet(index, value);
          },
        );
      },
      itemCount: sets.length,
    );
  }

  Widget _editTextName() => EditText(
        hint: 'Workout Name',
        controller: nameTextController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Workout name is required';
          }
          return null;
        },
      );

  Container _btnSave() => Container(
        width: double.infinity,
        child: TopRoundedCornerCard(
          padding: EdgeInsets.all(Spacing.NORMAL),
          child: PositiveButton(
            text: 'Save Workout',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _cubit.saveWorkout(nameTextController.text.trim());
              }
            },
          ),
        ),
      );
}
