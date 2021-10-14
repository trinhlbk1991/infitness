import 'package:flutter/material.dart';
import 'package:infitness/theme/colors.dart';
import 'package:infitness/theme/dimensions.dart';

import 'app_text.dart';

class ProgressDialog {
  ProgressDialog._();

  static Future<dynamic> show(
    BuildContext context, {
    required String message,
    bool dismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: AppColors.PRIMARY),
        child: StatefulBuilder(
          builder: (context, setState) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.DEFAULT),
            ),
            child: Padding(
              padding: EdgeInsets.all(Spacing.LARGE),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  Container(
                    margin: EdgeInsets.only(right: Spacing.NORMAL),
                    height: 1,
                  ),
                  Expanded(child: AppText(message)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
