import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';

class Space extends StatelessWidget {
  final double size;

  Space({this.size = Spacing.NORMAL});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
    );
  }
}
