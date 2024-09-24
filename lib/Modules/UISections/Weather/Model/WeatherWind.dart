import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import 'SerializingFilter.dart';
part 'WeatherWind.g.dart';

@JsonSerializable()
class WeatherWind {
  final double? speed;
  final double? deg;
  final double? gust;

  WeatherWind(this.speed, this.deg, this.gust);

  factory WeatherWind.fromJson(Map<String, dynamic> json) =>
      _$WeatherWindFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherWindToJson(this);
}
