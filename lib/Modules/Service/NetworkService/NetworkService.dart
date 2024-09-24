import 'package:dio/dio.dart';

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

  Future<T?> genericApiRequest<T>(
      String url,
      RequestMethod requestMethod, // Use the RequestMethod enum
      T Function(Map<String, dynamic>)
          fromJson, // Function to convert JSON to model
      {Map<String, dynamic>? headers,
      dynamic body,
      ResponseType responseType = ResponseType.json}) async {
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

      Response response;
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
        default:
          throw Exception('Unsupported request method: $requestMethod');
      }

      if (response.statusCode == 200) {
        return response.data != null ? fromJson(response.data) : null;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
