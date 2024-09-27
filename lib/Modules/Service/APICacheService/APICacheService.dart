import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class APICacheService {
  APICacheService._internal();
  static final shared = APICacheService._internal();

  Future<dynamic> fetchResponse(String url) async {
    print('Trying to fetch cache');
    final prefs = await SharedPreferences.getInstance();
    String? cachedResponse = prefs.getString(url);

    if (cachedResponse != null) {
      try {
        String decodedString = utf8.decode(base64Decode(cachedResponse));
        final jsonMap = jsonDecode(decodedString);
        return jsonMap;
      } catch (e) {
        print('Error decoding cached response: $e');
      }
    }
    return null;
  }

  // Set cache
  Future<void> setCache(String url, String? responseString) async {
    print('Trying to cache = $url');
    if (responseString == null) {
      print('responseString is null');
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(url, responseString);
    print("Response cached for URL: $url");
  }
}
