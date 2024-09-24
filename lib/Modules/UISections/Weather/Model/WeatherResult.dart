import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/Weather.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherCoord.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherMain.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherSys.dart';
import 'package:weather_flutter/Modules/UISections/Weather/Model/WeatherWind.dart';
part 'WeatherResult.g.dart';

@JsonSerializable()
class WeatherResult {
  final WeatherCoord? coord;
  final List<Weather>? weather;
  final WeatherMain? main;
  final WeatherWind? wind;
  final WeatherSys? sys;
  final int? timezone;
  final int? id;
  final String? name;

  WeatherResult({
    this.coord,
    this.weather,
    this.main,
    this.wind,
    this.sys,
    this.timezone,
    this.id,
    this.name,
  });

  factory WeatherResult.fromJson(Map<String, dynamic> json) =>
      _$WeatherResultFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherResultToJson(this);
}
