// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResult _$WeatherResultFromJson(Map<String, dynamic> json) =>
    WeatherResult(
      coord: json['coord'] == null
          ? null
          : WeatherCoord.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: json['main'] == null
          ? null
          : WeatherMain.fromJson(json['main'] as Map<String, dynamic>),
      wind: json['wind'] == null
          ? null
          : WeatherWind.fromJson(json['wind'] as Map<String, dynamic>),
      sys: json['sys'] == null
          ? null
          : WeatherSys.fromJson(json['sys'] as Map<String, dynamic>),
      timezone: (json['timezone'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$WeatherResultToJson(WeatherResult instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'weather': instance.weather,
      'main': instance.main,
      'wind': instance.wind,
      'sys': instance.sys,
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
    };
