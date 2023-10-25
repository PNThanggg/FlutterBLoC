part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherState {}

final class WeatherBlocLoading extends WeatherState {}
final class WeatherBlocFailure extends WeatherState {}
final class WeatherBlocSuccess extends WeatherState {
  final WeatherResponse weatherResponse;

  const WeatherBlocSuccess(this.weatherResponse);

  @override
  List<Object> get props => [weatherResponse];
}