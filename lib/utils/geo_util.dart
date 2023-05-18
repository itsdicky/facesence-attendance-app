import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class CGeoUtil {
  static GeoPoint toGeoPoint(Position position) {
    return GeoPoint(position.latitude, position.longitude);
  }
}