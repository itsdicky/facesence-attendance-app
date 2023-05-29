import '../repositories/firebase_repository.dart';

class IsAlreadyPresenceUseCase {
  final FirebaseRepository repository;

  IsAlreadyPresenceUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isAlreadyPresence();
  }
}