import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'app_card.dart';

const int _kFlex = 1;
const Color _kBackgroundColor = Colors.white;
const bool _kAutoClose = true;

class AppSlidableAction extends StatelessWidget {
  const AppSlidableAction({
    Key? key,
    this.flex = _kFlex,
    this.backgroundColor = _kBackgroundColor,
    this.foregroundColor,
    this.autoClose = _kAutoClose,
    required this.onPressed,
    required this.child,
  })  : assert(flex > 0),
        super(key: key);

  final int flex;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool autoClose;
  final SlidableActionCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: SizedBox.expand(
        child: InkWell(
          onTap: () => _handleTap(context),
          child: card(
            color: backgroundColor,
            child: child,
          ),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    onPressed?.call(context);
    if (autoClose) {
      Slidable.of(context)?.close();
    }
  }
}
