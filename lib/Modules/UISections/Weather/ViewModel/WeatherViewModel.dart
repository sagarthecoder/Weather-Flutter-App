import 'package:flutter/material.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/CityLocation.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/CityLocationList.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherResult.dart';

import '../../../../Config/WeatherConfig.dart';
import '../../../Service/LocationService/LocationService.dart';
import '../../../Service/NetworkService/NetworkService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherViewModel extends ChangeNotifier {
  WeatherResult? weatherResult;
  var isLoading = false;
  Future<void> updateCurrentWeather() async {
    print('start server');
    isLoading = true;
    notifyListeners();
    try {
      print('Checking location permission...');
      final locationData = await LocationService.shared.getCurrentLocation();
      final lat = locationData.latitude;
      final lon = locationData.longitude;
      _updateWeather(lat, lon);
    } catch (err) {
      print('err = ${err.toString()}');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateWeatherByCity(String? cityName) async {
    if (cityName == null) {
      return;
    }
    isLoading = true;
    notifyListeners();
    try {
      final cityLocation = await _getCityLocation(cityName);
      await _updateWeather(cityLocation?.lat, cityLocation?.lon);
    } catch (err) {
      print('City Error = ${err.toString()}');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<CityLocation?> _getCityLocation(String city) async {
    final url =
        "https://api.openweathermap.org/geo/1.0/direct?q=${city.replaceAll(' ', '%20')}&limit=1&appid=${WeatherConfig.apiKey}";
    final response = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(response.body);
    CityLocationList? locationList = CityLocationList.fromJson(jsonResponse);
    return locationList.locations?.first;
  }

  Future<void> _updateWeather(double? lat, double? lon) async {
    if (lat == null || lon == null) {
      print("Lat or Lon is null");
      return;
    }
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${WeatherConfig.apiKey}";
    final data = await NetworkService.shared
        .genericApiRequest(url, RequestMethod.get, WeatherResult.fromJson);
    weatherResult = data;
    notifyListeners();
  }
}
