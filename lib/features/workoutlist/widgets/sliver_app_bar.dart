import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/utils/log.dart';
import 'package:infitness/widgets/app_text.dart';

SliverAppBar sliverAppBar(BuildContext context) {
  return SliverAppBar(
    expandedHeight: 250,
    centerTitle: false,
    flexibleSpace: LayoutBuilder(
      builder: (context, constraints) {
        final top = constraints.biggest.height;
        return FlexibleSpaceBar(
          background: Container(
            child: Image(
              image: AssetImage('assets/bg_header.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          title: AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 300),
            child: AppText(
              'infitness',
              style: top <= _collapsedHeight(context)
                  ? Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                  : Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
            ),
          ),
          stretchModes: [StretchMode.zoomBackground],
          centerTitle: false,
          titlePadding: EdgeInsetsDirectional.only(
            start: Spacing.NORMAL,
            bottom: Spacing.SMALL,
          ),
        );
      },
    ),
    pinned: true,
  );
}

// 30 is a buffer size to make text color change more smooth
double _collapsedHeight(BuildContext context) =>
    MediaQuery.of(context).padding.top + kToolbarHeight + 30;
