import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counterValue;
  final bool isIncrement;

  const CounterState({
    required this.counterValue,
    this.isIncrement = true,
  });

  @override
  List<Object> get props => [counterValue, isIncrement];
}