import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final String code;
  final String value;

  const Language({required this.code, required this.value});

  @override
  List<Object?> get props => [code, value];
}
