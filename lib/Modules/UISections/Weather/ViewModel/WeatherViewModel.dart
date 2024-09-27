import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_flutter/Modules/Service/APICacheService/APICacheService.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Manager/WeatherPreferences.dart';
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
  final _cityCacheKey = 'favorite_city_cache_key';
  final _cacheManager = DefaultCacheManager();
  List<String> favoriteCities = [];

  Future<void> reset() async {
    await updateCurrentWeather();
    await refreshFavoriteCityList();
    notifyListeners();
  }

  Future<void> updateCurrentWeather() async {
    print('start server');
    isLoading = true;
    notifyListeners();
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
    final result = await NetworkService.shared
        .genericApiRequest(url, RequestMethod.get, CityLocation.fromJson);
    return result?.data?.first;
    // final hasNetwork = await InternetConnection().hasInternetAccess;
    // print('conection = ${hasNetwork}');
    // final url =
    //     "https://api.openweathermap.org/geo/1.0/direct?q=${city.replaceAll(' ', '%20')}&limit=1&appid=${WeatherConfig.apiKey}";
    // if (hasNetwork) {
    //   final result = await NetworkService.shared.genericApiRequest(url, RequestMethod.get, CityLocation.fromJson);
    //   return result?.data?.first;
    // final response = await http.get(Uri.parse(url));
    // await APICacheService.shared.setCache(url, response.body);
    // final jsonResponse = json.decode(response.body);
    // CityLocationList? locationList = CityLocationList.fromJson(jsonResponse);
    // return locationList.locations?.first;
    // } else {
    //   var cachedResponse = await APICacheService.shared.fetchResponse(url);
    //   print('cache response = ${cachedResponse.toString()}');
    //   if (cachedResponse != null) {
    //     // Use the cached response body for offline use
    //     // final jsonResponse = json.decode(cachedResponse.body);
    //     final decodedData = jsonDecode(cachedResponse.body);
    //     CityLocationList? locationList = CityLocationList.fromJson(decodedData);
    //     return locationList.locations?.first;
    //   } else {
    //     throw Exception('No cached data available and no network connection');
    //   }
    // }
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
    weatherResult = result?.data?.first;
    notifyListeners();
  }

  Future<void> refreshFavoriteCityList() async {
    List<String> list = await WeatherPreferences.shared.getFavoritesCities();
    favoriteCities = list;
    notifyListeners();
  }

  Future<void> addNewCity(String? city) async {
    try {
      await WeatherPreferences.shared.addNewFavoriteCity(city);
      await refreshFavoriteCityList();
      notifyListeners();
    } catch (err) {
      print('Error = ${err.toString()}');
      notifyListeners();
    }
  }

  Future<void> deleteFavoriteCity(String? city) async {
    try {
      await WeatherPreferences.shared.deleteCityFromFavorite(city);
    } catch (err) {
      print('Error = ${err.toString()}');
    }
    notifyListeners();
  }
}
