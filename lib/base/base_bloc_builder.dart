import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/utils/log.dart';

class BaseBlocBuilder<B extends BlocBase<S>, S> extends BlocBuilderBase<B, S> {
  final BlocWidgetBuilder<S> builder;
  final bool showLog;

  const BaseBlocBuilder({
    Key? key,
    required this.builder,
    B? bloc,
    BlocBuilderCondition<S>? buildWhen,
    this.showLog = false,
  }) : super(key: key, bloc: bloc, buildWhen: buildWhen);

  @override
  Widget build(BuildContext context, S state) {
    if (!kReleaseMode && showLog) {
      Log.i('Builder<$B>', 'State: $state');
    }

    return builder(context, state);
  }
}
