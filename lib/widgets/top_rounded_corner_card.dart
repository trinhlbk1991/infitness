import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';

class TopRoundedCornerCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;

  TopRoundedCornerCard({this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
      padding: padding,
      child: child,
    );
  }
}
