import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position?> detectCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      // request to open GPS
      Geolocator.requestPermission();
    }
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
    }
    LocationSettings settings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );
    return await Geolocator.getCurrentPosition(locationSettings: settings);
  }
}
