import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';

class PresenceModel extends PresenceEntity {
  PresenceModel({
    final String? presenceId,
    final String? name,
    final String? grade,
    final bool? isPresence,
    final Timestamp? time,
    final GeoPoint? location,
    final String? permissionId,
    final String? imageURL,
    final String? detail,
  }): super(
    presenceId: presenceId,
    name: name,
    grade: grade,
    isPresence: isPresence,
    time: time,
    location: location,
    permissionId: permissionId,
    imageURL: imageURL,
    detail: detail,
  );

  factory PresenceModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data().toString();
    return PresenceModel(
        presenceId: documentSnapshot.id,
        name: documentSnapshot.get('name_student'),
        grade: documentSnapshot.get('classroom_student'),
        isPresence: documentSnapshot.get('is_presence'),
        time: documentSnapshot.get('timestamp'),
        location: documentSnapshot.get('location'),
        permissionId: documentSnapshot.get('permissionId'),
        imageURL: documentSnapshot.get('image_url'),
        detail: data.contains('detail') ? documentSnapshot.get('detail') : 'detail not exist'
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      'presenceId': presenceId,
      'name_student': name,
      'classroom_student': grade,
      'is_presence': isPresence,
      'timestamp': time,
      'location': location,
      'permissionId': permissionId,
      'image_url': imageURL,
      'detail': detail
    };
  }
}