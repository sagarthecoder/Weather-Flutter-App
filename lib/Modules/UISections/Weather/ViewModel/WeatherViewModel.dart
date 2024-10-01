import 'package:flutter/material.dart';

import 'package:weather_flutter/Modules/UISections/Weather/Manager/WeatherPreferences.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/CityLocation.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherResult.dart';

import '../../../../Config/WeatherConfig.dart';
import '../../../Service/LocationService/LocationService.dart';
import '../../../Service/NetworkService/NetworkService.dart';
import 'package:get/get.dart';

class WeatherViewModel extends GetxController {
  Rxn<WeatherResult?> weatherResult = Rxn<WeatherResult>();
  // WeatherResult? weatherResult;
  var isLoading = false.obs;
  var favoriteCities = <String>[].obs;

  Future<void> reset() async {
    print("reset strted");
    await updateCurrentWeather();
    await refreshFavoriteCityList();
    print("reset ended");
  }

  Future<void> updateCurrentWeather() async {
    print('start server');
    isLoading.value = true;
    try {
      print('Checking location permission...');
      final locationData = await LocationService.shared.getCurrentLocation();
      final lat = locationData.latitude;
      final lon = locationData.longitude;
      print('lat = ${lat}');
      _updateWeather(lat, lon);
    } catch (err) {
      print('err = ${err.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateWeatherByCity(String? cityName) async {
    if (cityName == null) {
      return;
    }
    isLoading.value = true;
    try {
      final cityLocation = await _getCityLocation(cityName);
      await _updateWeather(cityLocation?.lat, cityLocation?.lon);
    } catch (err) {
      print('City Error = ${err.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<CityLocation?> _getCityLocation(String city) async {
    final url =
        "https://api.openweathermap.org/geo/1.0/direct?q=${city.replaceAll(' ', '%20')}&limit=1&appid=${WeatherConfig.apiKey}";
    final result = await NetworkService.shared
        .genericApiRequest(url, RequestMethod.get, CityLocation.fromJson);
    return result?.data?.first;
  }

  Future<void> _updateWeather(double? lat, double? lon) async {
    print('Update Weather start');
    if (lat == null || lon == null) {
      print("Lat or Lon is null");
      return;
    }
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${WeatherConfig.apiKey}";
    final result = await NetworkService.shared
        .genericApiRequest(url, RequestMethod.get, WeatherResult.fromJson);
    print('weather data count = ${result?.data?.length}');
    weatherResult.value = result?.data?.first;
  }

  Future<void> refreshFavoriteCityList() async {
    List<String> list = await WeatherPreferences.shared.getFavoritesCities();
    favoriteCities.value = list;
  }

  Future<void> addNewCity(String? city) async {
    try {
      await WeatherPreferences.shared.addNewFavoriteCity(city);
      await refreshFavoriteCityList();
    } catch (err) {
      print('Error = ${err.toString()}');
    }
  }

  Future<void> deleteFavoriteCity(String? city) async {
    try {
      await WeatherPreferences.shared.deleteCityFromFavorite(city);
    } catch (err) {
      print('Error = ${err.toString()}');
    }
  }
}
