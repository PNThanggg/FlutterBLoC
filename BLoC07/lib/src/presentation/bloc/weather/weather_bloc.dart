import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/repository/api_repository_impl.dart';
import '../../../domain/model/weather_response.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());

      try {
        WeatherResponse weatherResponse = await ApiRepositoryImpl().getWeather(event.position);
        emit(WeatherBlocSuccess(weatherResponse));
      } catch(e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}