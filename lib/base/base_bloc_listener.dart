import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infitness/utils/log.dart';

class BaseBlocListener<B extends BlocBase<S>, S>
    extends BlocListenerBase<B, S> {
  final bool showLog;

  BaseBlocListener({
    Key? key,
    B? bloc,
    required BlocWidgetListener<S> listener,
    BlocListenerCondition<S>? listenWhen,
    Widget? child,
    this.showLog = true,
  }) : super(
          key: key,
          child: child,
          listener: (context, state) {
            if (!kReleaseMode && showLog) {
              Log.i('Listener<$B>', 'State: $state');
            }

            listener(context, state);
          },
          bloc: bloc,
          listenWhen: listenWhen,
        );
}
