import 'package:geolocator/geolocator.dart';

import '../../base/remote/models/base_response.dart';
import '../../base/remote/provider/api_client.dart';
import '../../base/remote/provider/api_constant.dart';
import '../../domain/model/weather_response.dart';
import '../../domain/repository/api_repository.dart';

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<WeatherResponse> getWeather(Position position) async {
    List<String> listIndexHourly = [
      'temperature_2m',
      'relativehumidity_2m',
      'precipitation',
      'rain',
      'snowfall',
      'snow_depth',
      'weathercode',
      'visibility',
      'windspeed_10m',
      'winddirection_10m'
    ];

    List<String> listIndexDaily = [
      'weathercode',
      'temperature_2m_max',
      'temperature_2m_min',
      'sunrise',
      'sunset',
    ];

    BaseResponse response = await ApiClient.instance.request(
      endPoint: ApiConstant.urlAPIWeather,
      method: ApiClient.get,
      queryParameters: {
        'latitude': '${position.latitude}',
        'longitude': '${position.latitude}',
        'hourly': listIndexHourly,
        'daily': listIndexDaily,
        'current_weather': true,
        'timezone': 'auto',
      },
    );

    return WeatherResponse.fromJson(response.data);
  }
}
