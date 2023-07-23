import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(counterValue: 0));

  /// Add 1 to the current state.
  void increment() => emit(
        CounterState(
          counterValue: state.counterValue + 1,
          isIncrement: true,
        ),
      );

  /// Subtract 1 from the current state.
  void decrement() => emit(
        CounterState(
          counterValue: state.counterValue - 1,
          isIncrement: false,
        ),
      );
}
