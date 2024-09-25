// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CityLocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityLocation _$CityLocationFromJson(Map<String, dynamic> json) => CityLocation(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      country: json['country'] as String?,
    );

Map<String, dynamic> _$CityLocationToJson(CityLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'country': instance.country,
    };
