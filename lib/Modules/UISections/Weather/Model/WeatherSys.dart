
import 'package:json_annotation/json_annotation.dart';

part 'WeatherSys.g.dart';

@JsonSerializable()
class WeatherSys {
  final String? country;
  final int? sunrise;
  final int? sunset;

  WeatherSys(this.country, this.sunrise, this.sunset);

  factory WeatherSys.fromJson(Map<String, dynamic> json) =>
      _$WeatherSysFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherSysToJson(this);
}
