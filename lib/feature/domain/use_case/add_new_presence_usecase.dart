import 'package:sistem_presensi/feature/domain/entities/presence_entity.dart';
import 'package:sistem_presensi/feature/domain/repositories/firebase_repository.dart';

class AddNewPresenceUseCase {
  final FirebaseRepository repository;

  AddNewPresenceUseCase({required this.repository});

  Future<void> call(PresenceEntity presence) async {
    return repository.addNewPresence(presence);
  }
}