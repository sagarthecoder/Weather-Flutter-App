import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class APICacheService {
  APICacheService._internal();
  static final shared = APICacheService._internal();
  final _cacheManager = DefaultCacheManager();

  // Fetch the cached response as http.Response
  Future<http.Response?> fetchResponse(String url) async {
    print('Trying to fetch cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedResponse = prefs.getString(url);
    print('cachedResponse get ');
    if (cachedResponse != null) {
      try {
        // Decode the cached JSON string
        var decodedJson = json.decode(cachedResponse);

        // Return cached response as an http.Response object
        // For arrays, convert it back into a string
        final responseString = jsonEncode(decodedJson);

        final data = http.Response(responseString, 200,
            request: http.Request("GET", Uri.parse(url)));

        print("Got cache data for = $url");
        return data;
      } catch (e) {
        throw Exception("Error decoding cached response: $e");
      }
    } else {
      return null; // Cache not available
    }
  }

  // Set cache
  Future<void> setCache(String url, dynamic responseBody) async {
    print('trying to cache = ${url})');
    final prefs = await SharedPreferences.getInstance();
    String jsonResponse =
        jsonEncode(responseBody); // Convert response to JSON string
    await prefs.setString(url, jsonResponse); // Store it in SharedPreferences
    print("Response cached for URL: $url");
  }
}
