import 'package:json_annotation/json_annotation.dart';

part 'CityLocation.g.dart';

@JsonSerializable()
class CityLocation {
  final double? lat;
  final double? lon;
  final String? country;

  CityLocation({this.lat, this.lon, this.country});

  // Factory method to parse a single object

  factory CityLocation.fromJson(Map<String, dynamic> json) =>
      _$CityLocationFromJson(json);

  Map<String, dynamic> toJson() => _$CityLocationToJson(this);
}
