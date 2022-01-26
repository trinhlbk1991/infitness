import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:infitness/widgets/app_slidable_action.dart';

ActionPane setCardActions(
  BuildContext context, {
  required Function onDelete,
  required Function onEdit,
}) {
  return ActionPane(
    motion: ScrollMotion(),
    children: [
      AppSlidableAction(
        onPressed: (context) => onEdit(),
        backgroundColor: Colors.blue[900]!,
        child: Icon(
          Icons.edit_rounded,
          size: 32,
          color: Colors.white,
        ),
      ),
      AppSlidableAction(
        onPressed: (context) => onDelete(),
        backgroundColor: Colors.red[900]!,
        child: Icon(
          Icons.delete_outline_rounded,
          size: 32,
          color: Colors.white,
        ),
      )
    ],
  );
}
