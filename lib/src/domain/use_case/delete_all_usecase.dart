import '../repositories/firebase_repository.dart';

class DeleteAllUseCase {
  final FirebaseRepository repository;

  DeleteAllUseCase({required this.repository});

  Future<void> call(String collectionName) async {
    return repository.deleteAll(collectionName);
  }
}