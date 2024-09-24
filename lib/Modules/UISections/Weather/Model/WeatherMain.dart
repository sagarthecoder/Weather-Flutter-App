import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import 'SerializingFilter.dart';
part 'WeatherMain.g.dart';

@JsonSerializable()
class WeatherMain {
  @JsonKey(name: 'temp')
  final double? temperature;
  @JsonKey(name: 'feels_like')
  final double? feelsLike;
  @JsonKey(name: 'temp_min')
  final double? minTemperature;
  @JsonKey(name: 'temp_max')
  final double? maxTemperature;
  final double? pressure;
  final double? humidity;
  @JsonKey(name: 'sea_level')
  final double? seaLevel;
  @JsonKey(name: 'grnd_level')
  final double? grndLevel;

  WeatherMain({
    this.temperature,
    this.feelsLike,
    this.minTemperature,
    this.maxTemperature,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherMainToJson(this);
}
