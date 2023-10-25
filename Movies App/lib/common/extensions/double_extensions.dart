extension DoubleExtensions on double {
  String get convertVoteAverageToPercentageString {
    double input = double.parse((this).toStringAsFixed(1)) * 10;
    return '${input.toStringAsFixed(0)}%';
  }
}
