import 'package:flutter/material.dart';
import 'package:infitness/model/set.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/app_text.dart';
import 'package:infitness/widgets/buttons/app_buttons.dart';
import 'package:infitness/widgets/edit_text.dart';
import 'package:infitness/widgets/space.dart';
import 'package:infitness/widgets/top_rounded_corner_card.dart';

void showEditSetDialog(
  BuildContext context, {
  required Set set,
  required ValueChanged<Set> onSave,
}) {
  final setNameTextController = TextEditingController();
  setNameTextController.text = set.name;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Wrap(
            children: [
              Container(
                width: double.infinity,
                child: TopRoundedCornerCard(
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.only(
                      top: AppRadius.BOTTOM_SHEET,
                      left: AppRadius.BOTTOM_SHEET,
                      right: AppRadius.BOTTOM_SHEET,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          headline5Text(context, 'Edit Set'),
                          Space(),
                          _setNameEditText(
                            context,
                            nameTextController: setNameTextController,
                          ),
                          Space(size: Spacing.LARGE),
                          Row(
                            children: [
                              _btnCancel(context),
                              Space(),
                              _btnSave(context, () {
                                final newSet = set.copyWith(
                                    name: setNameTextController.text);
                                onSave(newSet);
                                FocusScope.of(context).unfocus();
                                Navigator.of(context).pop();
                              }),
                            ],
                          ),
                          Space(size: Spacing.LARGE),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget _setNameEditText(
  BuildContext context, {
  required TextEditingController nameTextController,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Set Name'),
        Space(size: Spacing.SMALL),
        EditText(
          hint: 'Enter set name',
          controller: nameTextController,
          autoFocus: true,
        ),
      ],
    );

Expanded _btnSave(
  BuildContext context,
  Function? positiveClicked,
) =>
    Expanded(
      child: PositiveButton(
        text: 'Save',
        onPressed: () {
          positiveClicked?.call();
        },
      ),
    );

_btnCancel(BuildContext context) => Expanded(
      child: PrimaryOutlineButton(
        text: 'Cancel',
        onPressed: () {
          FocusScope.of(context).unfocus();
          Navigator.of(context).pop();
        },
      ),
    );
