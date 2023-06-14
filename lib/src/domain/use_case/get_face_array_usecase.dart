import '../repositories/firebase_repository.dart';

class GetFaceArrayUseCase {
  final FirebaseRepository repository;

  GetFaceArrayUseCase({required this.repository});

  Future<List> call() {
    return repository.getFaceArray();
  }
}