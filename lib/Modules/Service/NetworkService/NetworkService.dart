import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_flutter/Modules/Service/APICacheService/APICacheService.dart';
import 'package:weather_flutter/Modules/Service/NetworkService/GenericResponse.dart';

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
  Future<GenericResponse<T>?> genericApiRequest<T>(
      String url,
      RequestMethod requestMethod,
      T Function(Map<String, dynamic>) fromJsonT, // Convert JSON to model
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
      // final fromJson = GenericResponse.fromJson();
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
      } else {
        // Offline Mode: Retrieve data from cache
        var cachedResponse = await APICacheService.shared.fetchResponse(url);
        if (cachedResponse != null) {
          // Use the cached response body for offline use
          final decodedData = jsonDecode(cachedResponse.body);
          print('decodedData = ${decodedData}');
          return GenericResponse.fromJson(decodedData, fromJsonT);
          // return fromJson(decodedData);
        } else {
          throw Exception('No cached data available and no network connection');
        }
      }

      if (response.statusCode == 200) {
        final result = {
          'data': response.data,
          'message': response.statusMessage.toString(),
          'status': response.statusCode.toString(),
        };
        await APICacheService.shared.setCache(url, result);
        return GenericResponse.fromJson(result, fromJsonT);
        // Return the data if the response is successful
        // return response.d != null ? fromJson(response.data) : null;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
