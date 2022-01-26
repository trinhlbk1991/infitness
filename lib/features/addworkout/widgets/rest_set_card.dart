import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:infitness/features/addworkout/widgets/set_card_scroll_actions.dart';
import 'package:infitness/model/exercise.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/date_time_utils.dart';
import 'package:infitness/widgets/app_card.dart';
import 'package:infitness/widgets/app_slidable_action.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/column_builder.dart';
import 'package:infitness/widgets/number_picker.dart';
import 'package:infitness/widgets/space.dart';
import 'package:tuple/tuple.dart';

import 'add_exercise_dialog.dart';
import 'add_workout_buttons.dart';

class RestSetCard extends StatelessWidget {
  final int index;
  final Set set;
  final EdgeInsets? margin;
  final ValueChanged<Set> onDeleteSet;
  final ValueChanged<Set> onEditSet;

  const RestSetCard({
    Key? key,
    required this.index,
    required this.set,
    required this.onDeleteSet,
    required this.onEditSet,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: Slidable(
        child: card(
          padding: EdgeInsets.all(Spacing.NORMAL),
          color: AppColors.CARD_REST,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    'Rest',
                    fontSize: TextSize.HEADER_2,
                    color: Colors.white,
                  ),
                  Expanded(child: Container()),
                  AppText(
                    DateTimeUtils.formatSeconds(set.exercises.first.time),
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
        endActionPane: setCardActions(
          context,
          onDelete: () => onDeleteSet(set),
          onEdit: () => onEditSet(set),
        ),
      ),
    );
  }
}
