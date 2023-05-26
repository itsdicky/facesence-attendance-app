import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class PresenceEntity {
  final String? presenceId;
  final String? name;
  final String? grade;
  final bool? isPresence;
  final Timestamp? time;
  GeoPoint? location;
  final String? permissionId;
  final File? imageFile;
  final String? imageURL;
  final String? detail;

  void set setLocation(GeoPoint geoPoint) {
    location = geoPoint;
  }

  PresenceEntity({
    this.presenceId,
    this.name,
    this.grade,
    this.isPresence,
    this.time,
    this.location,
    this.permissionId,
    this.imageFile,
    this.imageURL,
    this.detail
  });
}