import 'package:json_annotation/json_annotation.dart';
part 'GenericResponse.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericResponse<T> {
  String? message;
  List<T>? data;
  String? status;

  GenericResponse({this.message, this.data, this.status});
  factory GenericResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final dynamic responseData = json['data'];

    List<T>? parsedData;

    // Check if responseData is a list or a single object
    if (responseData is List) {
      // If it's a list, map each item to T
      parsedData = responseData
          .map<T>((item) => fromJsonT(item as Map<String, dynamic>))
          .toList();
    } else if (responseData is Map<String, dynamic>) {
      // If it's a single object, wrap it in a list
      parsedData = [fromJsonT(responseData)];
    }

    return GenericResponse<T>(
      message: json['message'] as String?,
      data: parsedData,
      status: json['status'] as String?,
    );
  }

  // toJson method for serialization (optional if needed)
  Map<String, dynamic> toJson(Object Function(T) toJsonT) {
    return {
      'message': message,
      'data': data?.map((item) => toJsonT(item)).toList(),
      'status': status,
    };
  }

  // factory GenericResponse.fromJson(
  //     Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
  //   var data = <T>[];
  //   json['data'].forEach((v) {
  //     data.add(create(v));
  //   });
  //
  //   return GenericResponse<T>(
  //       status: json["status"], message: json["message"], data: data);
  // }
}
