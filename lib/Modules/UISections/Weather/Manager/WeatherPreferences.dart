import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert';

class WeatherPreferences {
  final _cityCacheKey = 'favorite_city_cache_key';
  final _cacheManager = DefaultCacheManager();
  WeatherPreferences._internal();
  static final shared = WeatherPreferences._internal();

  Future<List<String>> getFavoritesCities() async {
    try {
      var fileInfo = await _cacheManager.getFileFromCache(_cityCacheKey);
      if (fileInfo != null) {
        String decodedString = utf8.decode(fileInfo.file.readAsBytesSync());
        final List<dynamic> jsonList = jsonDecode(decodedString);
        final items = jsonList.cast<String>();
        print('City Count = ${items.length}');
        return items;
      } else {
        return [];
      }
    } catch (err) {
      print('Error fetching cities = ${err.toString()}');
      return [];
    }
  }

  Future<void> addNewFavoriteCity(String? city) async {
    if (city == null) {
      return;
    }
    try {
      var list = await getFavoritesCities();

      if (list.contains(city.toLowerCase())) {
        return;
      }
      list.add(city.toLowerCase());
      await saveCitiesToDisk(list);
      print('saved cities');
    } catch (err) {
      print('Error to store new city = ${err.toString()}');
    }
  }

  Future<void> saveCitiesToDisk(List<String> list) async {
    String jsonString = jsonEncode(list);
    await _cacheManager.putFile(
        _cityCacheKey, Uint8List.fromList(utf8.encode(jsonString)),
        fileExtension: 'json');
  }

  Future<void> deleteCityFromFavorite(String? city) async {
    if (city == null) {
      return;
    }
    var list = await getFavoritesCities();
    list.removeWhere((item) => item.toLowerCase() == city.toLowerCase());
    await saveCitiesToDisk(list);
  }
}
