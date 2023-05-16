import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class PresenceEntity {
  final String? presenceId;
  final bool? isPresence;
  final Timestamp? time;
  final GeoPoint? location;
  final String? permissionId;
  final File? imageFile;
  final String? imageURL;
  final String? detail;

  const PresenceEntity({
    this.presenceId,
    this.isPresence,
    this.time,
    this.location,
    this.permissionId,
    this.imageFile,
    this.imageURL,
    this.detail
  });
}