import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class PermissionEntity {
  final String? permissionId;
  final String? studentId;
  final String? name;
  final String? category;
  final String? description;
  final String? grade;
  final String? status;
  final String? imageURL;
  final File? imageFile;
  final bool? isConfirmed;
  final Timestamp? time;

  const PermissionEntity({
    this.permissionId,
    this.studentId,
    this.name,
    this.category,
    this.description,
    this.grade,
    this.status,
    this.imageURL,
    this.imageFile,
    this.isConfirmed,
    this.time
  });
}