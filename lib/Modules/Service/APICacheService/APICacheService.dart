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

    // Get the cached response from SharedPreferences
    String? cachedResponse = prefs.getString(url);
    print('cachedResponse get = $cachedResponse');

    if (cachedResponse != null) {
      try {
        // Decode from base64
        List<int> utf8Bytes = base64Decode(cachedResponse);
        String decodedString =
            utf8.decode(utf8Bytes); // Decode UTF-8 bytes back to string

        // Decode the cached JSON string into a JSON object
        var decodedJson = jsonDecode(decodedString);

        // Convert it back to a JSON string to simulate a response
        final responseString = jsonEncode(decodedJson);
        print("Response String cache = $responseString");

        // Create a mock HTTP Response object from cached JSON
        final data = http.Response(responseString, 200,
            request: http.Request("GET", Uri.parse(url)));

        print("Got cache data for = $url");
        return data;
      } catch (e) {
        print("Error decoding cached response: $e");
        throw Exception("Error decoding cached response: $e");
      }
    } else {
      print("No cache found for $url");
      return null; // Cache not available
    }
  }

  // Set cache
  Future<void> setCache(String url, dynamic responseBody) async {
    print('Trying to cache = $url');
    final prefs = await SharedPreferences.getInstance();

    // Convert responseBody to a JSON string
    String jsonString = jsonEncode(responseBody);

    // UTF-8 encode the JSON string
    List<int> utf8Bytes = utf8.encode(jsonString);
    String utf8EncodedString =
        base64Encode(utf8Bytes); // Encode to base64 to safely store it

    // Store the base64 encoded JSON string
    await prefs.setString(url, utf8EncodedString);
    print("Response cached for URL: $url");
  }
}
