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
      } else {
        // Offline Mode: Retrieve data from cache
        var cachedResponse = await APICacheService.shared.fetchResponse(url);
        if (cachedResponse != null) {
          return GenericResponse.fromJson(cachedResponse, fromJsonT);
          // return fromJson(decodedData);
        } else {
          print('Cache response is null maybe. check = ${cachedResponse}');
          return null;
        }
      }

      if (response.statusCode == 200) {
        final result = {
          'data': response.data,
          'message': response.statusMessage.toString(),
          'status': response.statusCode.toString(),
        };
        final output = GenericResponse.fromJson(result, fromJsonT);
        final jsonString =
            jsonEncode(output.toJson((item) => (item as dynamic).toJson()));

        // Encode JSON string to UTF-8 and Base64 for storage
        String encodedString = base64Encode(utf8.encode(jsonString));

        await APICacheService.shared.setCache(url, encodedString);
        return output;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('error: $e');
    }
  }
}
