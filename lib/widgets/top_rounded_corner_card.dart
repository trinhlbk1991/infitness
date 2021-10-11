import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';

class TopRoundedCornerCard extends StatelessWidget {
  final Widget? child;

  TopRoundedCornerCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(AppRadius.BOTTOM_SHEET),
          topRight: const Radius.circular(AppRadius.BOTTOM_SHEET),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, -5.0),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: child,
    );
  }
}
