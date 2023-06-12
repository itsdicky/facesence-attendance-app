import '../repositories/firebase_repository.dart';

class IsAlreadyPresenceUseCase {
  final FirebaseRepository repository;

  IsAlreadyPresenceUseCase({required this.repository});

  Stream<bool> call() {
    return repository.isAlreadyPresenceStream();
  }
}