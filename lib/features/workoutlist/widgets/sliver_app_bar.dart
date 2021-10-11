import 'package:flutter/material.dart';
import 'package:infitness/theme/dimensions.dart';
import 'package:infitness/widgets/app_text.dart';

const TOOLBAR_HEIGHT = 64.0;

SliverAppBar sliverAppBar(BuildContext context) {
  return SliverAppBar(
    toolbarHeight: TOOLBAR_HEIGHT,
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
              style: top <= TOOLBAR_HEIGHT
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
