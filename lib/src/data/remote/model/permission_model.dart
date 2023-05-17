import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/permission_entity.dart';

class PermissionModel extends PermissionEntity {
  const PermissionModel({
    final String? studentId,
    final String? category,
    final String? description,
    final String? grade,
    final String? status,
    final String? imageURL,
    final bool? isConfirmed,
    final Timestamp? time,
  }): super(
    studentId: studentId,
    category: category,
    description: description,
    grade: grade,
    status: status,
    imageURL: imageURL,
    isConfirmed: isConfirmed,
    time: time
  );

  factory PermissionModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    // final data = documentSnapshot.data().toString();
    return PermissionModel(
      studentId: documentSnapshot.get('student_id'),
      category: documentSnapshot.get('category'),
      description: documentSnapshot.get('description'),
      grade: documentSnapshot.get('classroom'),
      status: documentSnapshot.get('status'),
      imageURL: documentSnapshot.get('image_url'),
      isConfirmed: documentSnapshot.get('is_confirmed'),
      time: documentSnapshot.get('time')
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      'student_id': studentId,
      'category': category,
      'description': description,
      'classroom': grade,
      'status': status,
      'image_url': imageURL,
      'is_confirmed': isConfirmed,
      'time': time
    };
  }
}