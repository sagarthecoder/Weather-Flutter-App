// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherSys.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherSys _$WeatherSysFromJson(Map<String, dynamic> json) => WeatherSys(
      json['country'] as String?,
      (json['sunrise'] as num?)?.toInt(),
      (json['sunset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WeatherSysToJson(WeatherSys instance) =>
    <String, dynamic>{
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
