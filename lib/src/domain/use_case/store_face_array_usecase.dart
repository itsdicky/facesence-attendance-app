import 'package:sistem_presensi/src/domain/repositories/firebase_repository.dart';

class StoreFaceArrayUseCase {
  final FirebaseRepository repository;

  StoreFaceArrayUseCase({required this.repository});

  Future<void> call(String uid, List faceArray) async {
    return repository.storeFaceArray(uid, faceArray);
  }
}