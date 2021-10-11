import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/screen_size_utils.dart';
import 'package:infitness/widgets/app_text.dart';

class WorkoutListHeader extends SliverPersistentHeaderDelegate {
  static const MAX_FULL_HEIGHT = 150.0;
  static const MIN_FULL_HEIGHT = 130.0;
  static const COMPACT_HEIGHT = 70.0;
  static const FULL_HEIGHT_RATIO = 0.20;

  late double maxHeight;
  late double minHeight;

  WorkoutListHeader(BuildContext context) {
    maxHeight = _fullHeight(context);
    minHeight = COMPACT_HEIGHT;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: EdgeInsets.only(top: Spacing.SMALL),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(color: Colors.teal),
                AppText(
                  'infitness',
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  double _fullHeight(BuildContext context) {
    final height = ScreenSizeUtils.height(context) * FULL_HEIGHT_RATIO;
    if (height > MAX_FULL_HEIGHT) {
      return MAX_FULL_HEIGHT;
    } else if (height < MIN_FULL_HEIGHT) {
      return MIN_FULL_HEIGHT;
    } else {
      return height;
    }
  }
}
