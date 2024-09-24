// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherMain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherMain _$WeatherMainFromJson(Map<String, dynamic> json) => WeatherMain(
      temperature: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      minTemperature: (json['temp_min'] as num?)?.toDouble(),
      maxTemperature: (json['temp_max'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      seaLevel: (json['sea_level'] as num?)?.toDouble(),
      grndLevel: (json['grnd_level'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeatherMainToJson(WeatherMain instance) =>
    <String, dynamic>{
      'temp': instance.temperature,
      'feels_like': instance.feelsLike,
      'temp_min': instance.minTemperature,
      'temp_max': instance.maxTemperature,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.seaLevel,
      'grnd_level': instance.grndLevel,
    };
