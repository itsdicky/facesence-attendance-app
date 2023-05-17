import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

import '../entities/presence_entity.dart';

class GetPresenceUsecase {
  final FirebaseRepository repository;

  GetPresenceUsecase({required this.repository});

  Stream<List<PresenceEntity>> call() {
    print('STREAM PRESENCE: new data (((3)))');
    return repository.getCurrentUserPresences();
  }
}