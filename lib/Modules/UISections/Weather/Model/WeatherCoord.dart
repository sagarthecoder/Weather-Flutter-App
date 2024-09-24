import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import 'SerializingFilter.dart';
part 'WeatherCoord.g.dart';

@JsonSerializable()
class WeatherCoord {
  final double? lon;
  final double? lat;

  WeatherCoord(this.lon, this.lat);

  factory WeatherCoord.fromJson(Map<String, dynamic> json) =>
      _$WeatherCoordFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherCoordToJson(this);
}
