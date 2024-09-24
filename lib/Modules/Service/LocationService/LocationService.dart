import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> requestPermission() async {
    final permission = await location.requestPermission();
    return permission == PermissionStatus.granted;
  }

  Future<LocationData> getCurrentLocation() async {
    final isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      final result = await location.requestService();
      if (result == true) {
        print('Service has been enabled');
      } else {
        throw Exception('GPS service not enabled');
      }
    }
    final locationData = await location.getLocation();
    return locationData;
  }
}
