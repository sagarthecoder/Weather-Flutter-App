import 'package:flutter/material.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherResult.dart';

import '../../../../Config/WeatherConfig.dart';
import '../../../Service/LocationService/LocationService.dart';
import '../../../Service/NetworkService/NetworkService.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherResult? weatherResult;

  Future<void> updateCurrentWeather() async {
    print('start server');
    try {
      print('Checking location permission...');
      final locationData = await LocationService.shared.getCurrentLocation();
      final lat = locationData.latitude;
      final lon = locationData.longitude;
      print('lat  = $lat, lon = $lon');
      final url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${WeatherConfig.apiKey}";
      final data = await NetworkService.shared
          .genericApiRequest(url, RequestMethod.get, WeatherResult.fromJson);
      weatherResult = data;
      notifyListeners();
    } catch (err) {
      print('err = ${err.toString()}');
    }
  }
}
