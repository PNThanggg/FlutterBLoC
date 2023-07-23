import 'package:bloc_02/count/count.dart';
import 'package:bloc_02/count/state/counter_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    CounterCubit? counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit?.close();
    });

    test(
      'initial state of CounterCubit is CounterState(counterValue:0)',
      () {
        expect(
          counterCubit?.state,
          const CounterState(counterValue: 0),
        );
      },
    );

    blocTest(
      'the CounterCubit should emit a CounterState(counterValue:1, wasIncremented:true) when the increment function is called',
      build: () => counterCubit!,
      act: (cubit) => cubit.increment(),
      expect: () => [
        const CounterState(counterValue: 1, isIncrement: true),
      ],
    );

    blocTest(
      'the CounterCubit should emit a CounterState(counterValue:-1, wasIncremented:false) when the decrement function is called',
      build: () => counterCubit!,
      act: (cubit) => cubit.decrement(),
      expect: () => [
        const CounterState(counterValue: -1, isIncrement: false),
      ],
    );
  });
}
