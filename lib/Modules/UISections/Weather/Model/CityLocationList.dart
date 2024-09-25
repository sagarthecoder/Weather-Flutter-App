import 'CityLocation.dart';

class CityLocationList {
  final List<CityLocation>? locations;
  CityLocationList({this.locations});

  factory CityLocationList.fromJson(List<dynamic> parsedJson) {
    List<CityLocation> locations = <CityLocation>[];
    locations = parsedJson.map((i) => CityLocation.fromJson(i)).toList();

    return CityLocationList(locations: locations);
  }
}
