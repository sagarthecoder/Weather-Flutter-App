// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherCoord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherCoord _$WeatherCoordFromJson(Map<String, dynamic> json) => WeatherCoord(
      (json['lon'] as num?)?.toDouble(),
      (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeatherCoordToJson(WeatherCoord instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };
