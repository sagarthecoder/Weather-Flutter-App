// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherWind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherWind _$WeatherWindFromJson(Map<String, dynamic> json) => WeatherWind(
      (json['speed'] as num?)?.toDouble(),
      (json['deg'] as num?)?.toDouble(),
      (json['gust'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeatherWindToJson(WeatherWind instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };
