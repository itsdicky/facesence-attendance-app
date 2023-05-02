import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistem_presensi/feature/domain/repositories/firebase_repository.dart';

import '../entities/presence_entity.dart';

class GetPresenceUsecase {
  final FirebaseRepository repository;

  GetPresenceUsecase({required this.repository});

  Stream<List<PresenceEntity>> call(String uid) {
    return repository.getPresence(uid);
  }
}