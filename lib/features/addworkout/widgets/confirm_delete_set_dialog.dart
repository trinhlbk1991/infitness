import 'package:flutter/cupertino.dart';
import 'package:infitness/widgets/alert_bottom_sheet.dart';

showConfirmDeleteSetDialog(BuildContext context, Function onConfirmed) {
  return showAlertBottomSheet(
    context,
    title: 'Delete Set',
    message:
        'Do you want to delete selected set? You can not undo this action.',
    positiveText: 'Delete',
    positiveStyle: PositiveStyle.primaryRed,
    positiveClicked: () {
      onConfirmed();
    },
    negativeText: 'Cancel',
  );
}
