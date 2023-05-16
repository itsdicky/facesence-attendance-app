import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

import '../entities/presence_entity.dart';

class GetPresenceUsecase {
  final FirebaseRepository repository;

  GetPresenceUsecase({required this.repository});

  Stream<List<PresenceEntity>> call(String uid) {
    return repository.getCurrentUserPresences(uid);
  }
}