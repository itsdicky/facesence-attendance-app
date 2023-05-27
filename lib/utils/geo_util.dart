import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CGeoUtil {
  static GeoPoint toGeoPoint(Position position) {
    return GeoPoint(position.latitude, position.longitude);
  }

  static Future<String> getAddress(GeoPoint geopoint) async {
    List<Placemark> placemarkList = await placemarkFromCoordinates(geopoint.latitude, geopoint.longitude);
    final loc = placemarkList[2];
    String address = '${loc.street}, ${loc.subLocality}, ${loc.locality}, ${loc.subAdministrativeArea}';
    return address;
  }

  static double getDistance(double fLat, double fLng, double sLat, double sLng) {
    double distance = Geolocator.distanceBetween(fLat, fLng, sLat, sLng);
    return distance;
  }

  static bool isInsideArea(GeoPoint fLoc, GeoPoint sLoc, double radius) {
    double distance = getDistance(fLoc.latitude, fLoc.longitude, sLoc.latitude, sLoc.longitude);
    return distance <= radius;
  }
}