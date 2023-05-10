import 'package:cloud_firestore/cloud_firestore.dart';

class PresenceEntity {
  final String presenceId;
  final String uid;
  final String? grade;
  final Timestamp? time;
  final GeoPoint? location;
  final String? permissionId;
  final String? detail;

  const PresenceEntity({
    required this.presenceId,
    required this.uid,
    this.grade,
    this.time,
    this.location,
    this.permissionId,
    this.detail
  });
}