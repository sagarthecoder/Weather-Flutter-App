
import 'package:json_annotation/json_annotation.dart';

part 'Weather.g.dart';

@JsonSerializable()
class Weather {
  final String? main;
  final String? description;
  final String? icon;

  Weather(this.main, this.description, this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
