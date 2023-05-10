import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';

class PresenceModel extends PresenceEntity {
  const PresenceModel({
    required final String presenceId,
    required final String uid,
    final String? grade,
    final Timestamp? time,
    final GeoPoint? location,
    final String? permissionId,
    final String? detail,
  }): super(
    presenceId: presenceId,
    uid: uid,
    grade: grade,
    time: time,
    location: location,
    permissionId: permissionId,
    detail: detail,
  );

  factory PresenceModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return PresenceModel(
        presenceId: documentSnapshot.id,
        uid: documentSnapshot.get('student'),
        grade: documentSnapshot.get('class'),
        time: documentSnapshot.get('timestamp'),
        location: documentSnapshot.get('location'),
        permissionId: documentSnapshot.get('permission'),
        detail: documentSnapshot.get('detail')
    );
  }

  Map<String, dynamic> toDocument(){
    return {
      'presenceId': presenceId,
      'uid': uid,
      'grade': grade,
      'timestamp': time,
      'location': location,
      'permissionId': permissionId,
      'detail': detail
    };
  }
}