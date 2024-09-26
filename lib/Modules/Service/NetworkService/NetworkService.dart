import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_flutter/Modules/Service/APICacheService/APICacheService.dart';

enum RequestMethod { get, post, put, delete }

class NetworkService {
  // Private constructor
  NetworkService._(this._dio);

  // Static instance
  static final NetworkService shared = NetworkService._(Dio());

  // Factory method to return the instance
  factory NetworkService() {
    return shared;
  }

  final Dio _dio;

  // Generic API Request Method
  Future<T?> genericApiRequest<T>(String url, RequestMethod requestMethod,
      T Function(Map<String, dynamic>) fromJson, // Convert JSON to model
      {Map<String, dynamic>? headers,
      dynamic body,
      ResponseType responseType = ResponseType.json}) async {
    final hasNetwork = await InternetConnection().hasInternetAccess;
    print('Network = $hasNetwork');

    try {
      Options options = Options(
        method: requestMethod
            .toString()
            .split('.')
            .last
            .toUpperCase(), // Convert enum to string
        headers: headers,
        responseType: responseType,
      );

      Response? response;

      if (hasNetwork) {
        // Online Mode: Make network call
        switch (requestMethod) {
          case RequestMethod.get:
            response = await _dio.get(url, options: options);
            break;
          case RequestMethod.post:
            response = await _dio.post(url, data: body, options: options);
            break;
          case RequestMethod.put:
            response = await _dio.put(url, data: body, options: options);
            break;
          case RequestMethod.delete:
            response = await _dio.delete(url, options: options);
            break;
        }
        // Cache the response body after fetching from the network
        await APICacheService.shared.setCache(url, response.data);
      } else {
        // Offline Mode: Retrieve data from cache
        var cachedResponse = await APICacheService.shared.fetchResponse(url);
        if (cachedResponse != null) {
          // Use the cached response body for offline use
          final decodedData = jsonDecode(cachedResponse.body);
          return fromJson(decodedData);
        } else {
          throw Exception('No cached data available and no network connection');
        }
      }

      if (response.statusCode == 200) {
        // Return the data if the response is successful
        return response.data != null ? fromJson(response.data) : null;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
