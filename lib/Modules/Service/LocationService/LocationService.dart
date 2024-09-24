import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  LocationService._internal();
  static final LocationService shared = LocationService._internal();

  Future<void> requestPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    } else {
      print('Location permission already granted.');
    }
  }

  Future<Position> getCurrentLocation() async {
    // Request permissions first
    await requestPermission();

    // Define the settings based on the platform
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter:
          100, // Minimum distance (measured in meters) a device must move horizontally before an update event is generated
    );

    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }
}
