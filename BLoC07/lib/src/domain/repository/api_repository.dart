import 'package:geolocator/geolocator.dart';

import '../model/weather_response.dart';

abstract class ApiRepository {
  Future<WeatherResponse?> getWeather(Position position);
}
