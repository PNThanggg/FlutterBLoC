import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_log/app_log.dart';

class CounterObserver extends BlocObserver {
  const CounterObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppLog.info('${bloc.runtimeType} $change');
  }
}
