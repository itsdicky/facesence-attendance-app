import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/src/domain/entities/presence_entity.dart';

class PresenceModel extends PresenceEntity {
  PresenceModel({
    final String? presenceId,
    final bool? isPresence,
    final Timestamp? time,
    final GeoPoint? location,
    final String? permissionId,
    final String? imageURL,
    final String? detail,
  }): super(
    presenceId: presenceId,
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
      'is_presence': isPresence,
      'timestamp': time,
      'location': location,
      'permissionId': permissionId,
      'image_url': imageURL,
      'detail': detail
    };
  }
}